#!/usr/bin/ruby

require './config.rb'
require './stooq_db.rb'
require "./plot_chart.rb"
require './cron_chart.rb'

@mysql = open_stooq_db()

fetcher = Candlizer.new(@mysql)
fetcher.symbol = ARGV.shift || 'USDKRW'
fetcher.date = ARGV.shift
plotter = ChartPlotter.new(fetcher)
plotter.output = nil

plotproc = proc{|pl| 
  IO.popen("-", "r+") do |io|
    if io then
      # parent
      io.read
    else
      # child
      Gnuplot.open do |gp|
        pl.gnuplot = gp
        pl.plot
      end
    end
  end
}

SQL =<<__SQL__
SELECT id, symbol, date, time
FROM stooq
WHERE symbol = ? AND date = ? AND time >= '09:00;00' AND time < '15:01:00'
ORDER BY time ASC
__SQL__

@stmt = @mysql.prepare(SQL)
@stmt.execute(fetcher.symbol, fetcher.date)

while row = @stmt.fetch do
  fetcher.tm_to = row[3].to_s.split.last
  datetime = DateTime.parse("#{row[2].to_s.split.first} #{row[3].to_s.split.last}")

  plotter.config = ChartConfigPreset::Large
  img = plotproc.call(plotter)
  save_chart(fetcher.symbol, datetime, 'l', img)

  plotter.config = ChartConfigPreset::Medium
  img = plotproc.call(plotter)
  save_chart(fetcher.symbol, datetime, 'm', img)

  plotter.config = ChartConfigPreset::Small
  img = plotproc.call(plotter)
  save_chart(fetcher.symbol, datetime, 's', img)
end


@stmt.close
@mysql.close
