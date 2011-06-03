#!/usr/bin/ruby 

require './config.rb'
require './stooq_db.rb'

require 'gnuplot'
require 'date'
require './plot_presets.rb'
require './plot_candlize.rb'
require 'stringio'

class ChartPlotter
  attr_accessor :gnuplot
  attr_accessor :config
  attr_accessor :fetcher
  attr_accessor :output
  attr_accessor :options

  def initialize(fetcher = nil)
    @gnuplot = StringIO.new
    @config = ChartConfigPreset::DEFAULT
    @fetcher = fetcher
    @output = nil
    @options = {}
  end

  def plot
    @fetcher.interval = @config::INTERVAL
    @fetcher.fetch
    Gnuplot::Plot.new(@gnuplot) do |plot|
      plot.style "fill empty"
      plot.grid "xtics y2tics"
      plot.noytics
      plot.y2tics "mirror"
      plot.xdata "time"
      plot.timefmt '"%H:%M"'
      plot.format 'x "%H:%M"'
      plot.xrange '["09:00" : "15:00"] noreverse nowriteback'
      
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
      
      plot.data << Gnuplot::DataSet.new( "#{@fetcher.last_closing}" ) do |ds|
        ds.with = 'lines linetype 0 linecolor rgb "#ff0000" axis x1y2'
        ds.title = "Last closing"
      end
    end

    @gnuplot
  end
end

if $0 == __FILE__ then
  @mysql = open_stooq_db()

  fetcher = Candlizer.new(@mysql)
  fetcher.symbol = ARGV.shift || 'USDKRW'
  fetcher.date = ARGV.shift || Date.today
  fetcher.tm_to = ARGV.shift || nil
  plotter = ChartPlotter.new(fetcher)
  plotter.config = ChartConfigPreset::Large
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
  File.open("chart.gif", "wb"){|io| io << img }

  @mysql.close
end
