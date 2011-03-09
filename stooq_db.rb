
require './config.rb'
require 'mysql'

def open_stooq_db()
  mysql = Mysql.new(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB)
  mysql.query("SET CHARACTER SET utf8")
  mysql.query("SET NAMES utf8")
  mysql
end
