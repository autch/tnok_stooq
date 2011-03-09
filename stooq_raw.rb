#!/usr/bin/ruby

require 'mysql'
require './config.rb'
require './stooq_db.rb'
require 'date'

COLUMNS = %w(id symbol date time opening minimum maximum current rate)
HEADER = "# id,symbol,date,time,opening,minimum,maximum,current,rate_percent"

symbol = ARGV.shift || 'USDKRW'
date = ARGV.shift
date = date ? (Date.parse(date) rescue Date.today) : Date.today
prefix = ARGV.shift || TNST_RAW_PATH

@mysql = open_stooq_db()
begin
  sql = sprintf("SELECT %s FROM stooq " +
                "WHERE symbol = '%s' AND date = '%s' " +
                "ORDER BY date ASC, time ASC", @mysql.quote(COLUMNS.join(', ')),
                @mysql.quote(symbol), @mysql.quote(date.to_s))

  filename = File.join(prefix, sprintf("%s_%s.csv", symbol.downcase, date.to_s))

  @mysql.query(sql){|res|
    File.open(filename, "w"){|f|
      f.puts HEADER
      res.each{|row|
        f.puts row.join(',')
      }
    }
  }

ensure
  @mysql.close
end
