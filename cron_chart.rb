
require './config.rb'
require './stooq_db.rb'
require 'fileutils'
require './plot_chart.rb'

def make_filename(symbol, datetime, size)
  path = File.join(TNST_CHART_PATH, datetime.strftime("%Y/%m/%d"))
  fn = "%s_%s_%s.gif" % [symbol.downcase, datetime.strftime("%Y%m%d%H%M%S"), size]

  File.join(path, fn)
end

def save_chart(symbol, datetime, size, data)
  path = File.join(TNST_CHART_PATH, datetime.strftime("%Y/%m/%d"))
  FileUtils.mkdir_p(path)

  fname = make_filename(symbol, datetime, size)

  File.open(fname, "wb"){|io| io.write(data) }
#  $stderr.puts fname
end

def plot_chart(symbol, datetime)
  fetcher = Candlizer.new(@mysql)
  fetcher.symbol = symbol
  fetcher.date = Date.today
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

  plotter.config = ChartConfigPreset::Large
  img = plotproc.call(plotter)
  save_chart(symbol, datetime, 'l', img)

  plotter.config = ChartConfigPreset::Medium
  img = plotproc.call(plotter)
  save_chart(symbol, datetime, 'm', img)

  plotter.config = ChartConfigPreset::Small
  img = plotproc.call(plotter)
  save_chart(symbol, datetime, 's', img)
rescue
  p [$!, $@, __FILE__, __LINE__]
end
