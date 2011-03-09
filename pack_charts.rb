#!/usr/bin/ruby

def pack_it(dir)
  Dir.chdir(dir){|pwd|
    puts "**** Entering #{Dir.pwd}"
    yyyymmdd = Dir.pwd.split(/\//)[-3, 3].join
    %w(usdkrw kospi).each{|sym|
      %w(l m s).each{|size|
        cmdline = sprintf("zip -q9m %s_%s_%s.zip %s_*_%s.gif",
                          sym, yyyymmdd, size,
                          sym, size)
        puts "\# #{cmdline}"
        system cmdline
      }
    }
  }
end

ARGV.each{|dir| pack_it(dir) }
