#!/usr/bin/ruby

require './config.rb'
require './stooq_db.rb'
require 'rubygems'
require 'date'
require './cron_chart.rb'
require 'memcache'
require 'nokogiri'
require 'mechanize'

SQL_INSERT = <<__EOF__
INSERT IGNORE INTO stooq (id, symbol, date, time,
  opening, minimum, maximum, current, rate)
  VALUES(NULL, ?, CURDATE(), ?, ?, ?, ?, ?, ?)
__EOF__

SQL_LAST = <<__EOF__
SELECT opening FROM stooq
  WHERE symbol = ? AND date = (
    SELECT date FROM stooq
      WHERE symbol = ? AND date < CURDATE() AND time >= '15:05:00'
      ORDER BY date DESC LIMIT 1)
    AND time >= '15:05:00'
  ORDER BY date DESC, time DESC LIMIT 1
__EOF__

class Scraper
  def initialize()
    @memcache = MemCache.new(MEMCACHED_HOST)
  end

  def last_opening(sym)
    @stmt_last.execute(sym, sym)
    row = @stmt_last.fetch
    row[0]
  end

  def scrape(url, symbol, db_key, dup_check_limit = 5)
    agent = ::Mechanize.new
    agent.get(url)

    if agent.page then      
      root = agent.page.root
      h = {}
      pickup = {
        :opening => "span#aq_#{symbol}_o",
        :high => "span#aq_#{symbol}_h",
        :low => "span#aq_#{symbol}_l",
        :current => "span#aq_#{symbol}_c2",
        :rate => "span#aq_#{symbol}_m1"
      }

      pickup.each{|k, v| h[k] = root.search(v).first.text }
      
      @mysql = open_stooq_db()
      @stmt = @mysql.prepare(SQL_INSERT)    
      @stmt_last = @mysql.prepare(SQL_LAST)
      begin
        now = DateTime.now
        dt = now.strftime("%Y-%m-d")
        tm = now.strftime("%H:%M:%S")
        dup_check = false
        if now.hour == 9 && now.min < dup_check_limit then
          dup_check = (last_opening(db_key).to_s == h[:opening])
        end
        unless dup_check then
          unless h.any?{|k, v| v == 0 } then
            @stmt.execute(db_key, tm,
                          h[:opening], h[:low], h[:high],
                          h[:current], h[:rate])
            plot_chart(db_key, now)
            @memcache.delete(sprintf("tnok-stooq_by_sym_%s", db_key))
            [h, now]
          end
        end
      rescue
        p [$!, $@, __FILE__, __LINE__]
        $stderr.printf("%s: %s\n", $!, $!.message)
      ensure
	@stmt_last.close
	@stmt.close
	@mysql.close
      end
    end
  end
end

scraper = Scraper.new

# USDKRW
scraper.scrape('http://stooq.com/notowania/?data=&kat=w3',
               'usdkrw', 'USDKRW', 5)
# KOSPI
scraper.scrape('http://stooq.com/notowania/?data=&kat=i1',
               'kospi', 'KOSPI', 21)
