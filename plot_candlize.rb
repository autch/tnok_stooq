class Candlizer
  SQL = <<__SQL__
SELECT summary.date, summary.time, DATE_FORMAT(summary.time, '%H:%i') AS hhmm,
summary.s,
((SELECT current FROM stooq stq WHERE stq.id = summary.open_id)) opening,
summary.min, summary.max,
((SELECT current FROM stooq stq WHERE stq.id = summary.close_id)) closing

FROM (SELECT date, time,
TRUNCATE(EXTRACT(HOUR_MINUTE FROM TIMEDIFF(time, ?))/?, 0) s,
MIN(current) min,
MAX(current) max, 
MIN(id) open_id, MAX(id) close_id

FROM stooq WHERE symbol = ? AND date = ? AND time >= ? AND time < ? AND time <= ?
GROUP BY s) summary;
__SQL__

  attr_accessor :mysql
  attr_accessor :symbol
  attr_accessor :date
  attr_accessor :tm_to
  attr_accessor :interval
  attr_accessor :result
  attr_accessor :datetime

  def initialize(mysql = nil)
    @mysql = mysql
    @symbol = 'USDKRW'
    @date = Date.today
    @interval = 5
    @result = []
    @datetime = nil
    @tm_to = nil
  end

  def fetch
    symbol = @symbol
    date = @date
    date = (Date.parse(date) rescue Date.today)
    date_str = date.strftime("%Y-%m-%d")
    
    ds_from = "09:00:00"
    ds_to = "15:01:00"
    tm_to = @tm_to || ds_to
    
    stmt = @mysql.prepare(SQL)
    stmt.execute(ds_from, @interval, symbol, date_str, ds_from, ds_to, tm_to)
    
    @result = []
    
    # date, time, hhmm, s, opening, min, max, closing
    while row = stmt.fetch do
      rr = row.values_at(2,4,5,6,7)
      @datetime = DateTime.new(row[0].year, row[0].month, row[0].day,
                               row[1].hour, row[1].minute, row[1].second)
      @result << rr
    end

    @result = @result.transpose
  end

  def current
    @result[4] ? @result[4].last : nil
  end

  def last_closing
    sql = <<__SQL__
SELECT current FROM stooq 
WHERE symbol = ? and date < ?
  AND time >= '15:00:00'
  AND time < '15:01:00' 
ORDER BY date DESC, time DESC LIMIT 1
__SQL__

    date = @date
    date = (Date.parse(date) rescue Date.today)
    date_str = date.strftime("%Y%m%d")
    
    stmt = @mysql.prepare(sql)
    stmt.execute(@symbol, date_str)

    stmt.fetch.first
  end
end
