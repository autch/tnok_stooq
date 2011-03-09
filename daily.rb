#!/usr/bin/ruby

require './config.rb'
require './stooq_db.rb'
require './plot_chart.rb'

class DailyFetcher
  SQL = <<__SQL__
SELECT DATE_FORMAT(date, '%Y-%m-%d') AS date, opening, minimum, maximum, closing
FROM stooq_summary
WHERE symbol = ? ORDER BY date ASC
__SQL__

  attr_accessor :mysql
  attr_accessor :symbol
  attr_accessor :result
  attr_accessor :date

  def initialize(mysql = nil)
    @mysql = mysql
    @symbol = 'USDKRW'
    @result = []
    @date = nil
  end

  def fetch
    stmt = @mysql.prepare(SQL)
    begin
      stmt.execute(@symbol)
    
      @result = []
    
      # date, opening, minimum, maximum, closing
      while row = stmt.fetch do
        @date = Date.new(*row[0].split(/-/).map{|i| i.to_i }) # Date.new(row[0].year, row[0].month, row[0].day)
        @result << row
      end

      @result = @result.transpose
    ensure
      stmt.close
    end
  end
end

class DailyConfig
  INTERVAL = nil
  PARAMS = { :size => "1280,480", :interval => INTERVAL, :boxwidth => "" }
  LABEL_FMT = "%s - daily / Interval: a day / %s / http://tnok.jp/stooq/"
  LABEL_POS = "character 3, 36.55"

  def interval
    PARAMS[:interval]
  end

  def configure(plot, fetcher, options = {})
    plot.terminal "gif small size #{PARAMS[:size]} #{options[:terminal]}"
    plot.boxwidth PARAMS[:boxwidth]
    
    label_text = LABEL_FMT % 
      [fetcher.symbol, fetcher.date.strftime("%d %b %Y")]
    plot.label "\"#{label_text}\" at #{LABEL_POS}"
  end
end

@mysql = open_stooq_db()

fetcher = DailyFetcher.new(@mysql)
fetcher.symbol = ARGV.shift || 'USDKRW'
plotter = ChartPlotter.new(fetcher)

def plotter.plot()
  @fetcher.fetch
  Gnuplot::Plot.new(@gnuplot) do |plot|
    plot.style "fill empty"
    plot.grid "xtics y2tics"
    plot.noytics
    plot.xdata "time"
    plot.y2tics "mirror"
    plot.timefmt '"%Y-%m-%d"'
    plot.format 'x "%Y-%m-%d"'
    
    config = @config.new
    config.configure(plot, @fetcher, @options)
    if @output then
      plot.output @output
    end
    
    plot.data << Gnuplot::DataSet.new(@fetcher.result) do |ds|
      ds.using = "1:2:3:4:5"
      ds.title = @fetcher.symbol
      ds.with = 'candlesticks linetype rgb "#0000ff" axis x1y2'
    end
  end

  @gnuplot
end

plotter.config = DailyConfig
plotter.output = nil

img = IO.popen("-", "r+") do |io|
  if io then
    # parent
    io.read
  else
    # child
    Gnuplot.open do |gp|
      plotter.gnuplot = gp
      plotter.plot
    end
  end
end

File.open("daily.gif", "wb"){|io| io << img }

@mysql.close
