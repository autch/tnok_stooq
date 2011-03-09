
module ChartConfigPreset
  class Large
    INTERVAL = 5
    PARAMS = { :size => "700,466", :interval => INTERVAL, :boxwidth => "0.5 relative" }
    LABEL_FMT = "%s - 1 day / Interval %dmin. / %s / http://tnok.jp/stooq/"
    LABEL_POS = "character 3, 35.55"

    def interval
      PARAMS[:interval]
    end

    def configure(plot, fetcher, options = {})
      plot.terminal "gif small size #{PARAMS[:size]} #{options[:terminal]}"
      plot.boxwidth PARAMS[:boxwidth]
      plot.y2tics "add (\"#{fetcher.last_closing}\" #{fetcher.last_closing}, \"#{fetcher.current}\" #{fetcher.current})"
      
      label_text = LABEL_FMT % 
        [fetcher.symbol, PARAMS[:interval], fetcher.datetime.strftime("%d %b %Y %H:%M JST")]
      plot.label "\"#{label_text}\" at #{LABEL_POS}"
    end
  end
  DEFAULT = Large

  class Medium
    INTERVAL = 5
    PARAMS = { :size => "500,333", :interval => INTERVAL, :boxwidth => "0.5 relative" }
    LABEL_FMT = "%s / Interval %dmin. / %s / http://tnok.jp/stooq/"
    LABEL_POS = "character 3, 25.2"

    def interval
      PARAMS[:interval]
    end

    def configure(plot, fetcher, options = {})
      plot.terminal "gif small size #{PARAMS[:size]} #{options[:terminal]}"
      plot.boxwidth PARAMS[:boxwidth]
      plot.y2tics "add (\"#{fetcher.last_closing}\" #{fetcher.last_closing}, \"#{fetcher.current}\" #{fetcher.current})"
      
      label_text = LABEL_FMT % 
        [fetcher.symbol, PARAMS[:interval], fetcher.datetime.strftime("%Y-%m-%d %H:%M")]
      plot.label "\"#{label_text}\" at #{LABEL_POS}"
    end
  end

  class Small
    INTERVAL = 10
    PARAMS = { :size => "220,100", :interval => INTERVAL, :boxwidth => "0.5 relative" }
    LABEL_FMT = "%s %s by tnok.jp"
    LABEL_POS = "character 3, 12"

    def interval
      PARAMS[:interval]
    end

    def configure(plot, fetcher, options = {})
      plot.terminal "gif tiny size #{PARAMS[:size]} #{options[:terminal]}"
      plot.format 'x "%H"'
      plot.nokey
      plot.boxwidth PARAMS[:boxwidth]
      
      label_text = LABEL_FMT % [fetcher.symbol, fetcher.datetime.strftime("%b-%d %H:%M")]
      plot.label "\"#{label_text}\" at #{LABEL_POS}"
    end
  end
end

