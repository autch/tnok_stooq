#!/usr/bin/ruby
#
# Usage: ./make_gif.rb {USDKRW|KOSPI} YYYY-MM-DD /path/to/put/it {l|m|s}
#

require 'RMagick'
require './config.rb'
require './stooq_db.rb'
require 'date'

include Magick

def make_dt(date, time)
  DateTime.new(date.year, date.month, date.day, time.hour, time.minute, time.second)
end

symbol = ARGV.shift || 'USDKRW'
date = ARGV.shift
date = date ? (Date.parse(date) rescue Date.today) : Date.today
prefix = ARGV.shift || TNST_CHART_PATH
size = ARGV.shift || 'l'
size = 'l' unless /^[lms]$/ =~ size

@mysql = open_stooq_db()

gif = ImageList.new
gif.ticks_per_second = 100
gif.delay = 20

d = Draw.new
d.gravity = NorthWestGravity
d.font = "/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans-Bold.ttf"
d.pointsize = { "l" => 24, "m" => 18, "s" => 8}[size]
d.fill = "black"

annotate_pos = { "l" => [20, 10], "m" => [20, 10], "s" => nil }[size]

stmt = @mysql.prepare("SELECT id, date, time, current " +
                      "FROM stooq " +
                      "WHERE symbol = ? AND date = ? AND time >= '09:00:00' AND time < '15:01:00' " +
                      "ORDER BY time ASC")

stmt.execute(symbol, date.to_s)
stmt.each{|r|
  datetime = make_dt(r[1], r[2])
  filename = sprintf("%s/%s_%s_%s.gif", datetime.strftime("%Y/%m/%d"), 
                     symbol.downcase, datetime.strftime("%Y%m%d%H%M%S"), size)
  fullpath = File.join(TNST_CHART_PATH, filename)
  if File.exist?(fullpath) then
    img = Image.read(fullpath).first
    img.delay = 20
    d.annotate(img, 0, 0, annotate_pos.first, annotate_pos.last, "#{r[3]}") if annotate_pos
    gif << img
  end

  GC.start
}
stmt.close

filename = File.join(prefix, sprintf("%s_%s%s.gif", symbol.downcase, date.to_s,
                                     size == 'l' ? '' : "_#{size}"))

gif.optimize_layers(OptimizeLayer).write(filename)
