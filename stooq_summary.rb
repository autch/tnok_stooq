#!/usr/bin/ruby

require './stooq_db.rb'

mysql = open_stooq_db()
begin

  sql = <<__EOF__
INSERT INTO stooq_summary
    (symbol, date, opening, minimum, maximum, closing)
    SELECT symbol, date, opening, minimum, maximum,
           current AS closing
    FROM stooq
    WHERE date = CURDATE() AND time >= '15:05:00'
    GROUP BY symbol, date DESC
    ORDER BY date ASC
__EOF__

  mysql.query(sql)
ensure
  mysql.close
end
