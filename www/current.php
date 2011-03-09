<?php
mb_http_output('pass');

require_once '../boot.inc.php';

define("SQL",  "SELECT id, symbol, date, time, opening, minimum, maximum, current, rate "
       . "FROM stooq WHERE symbol = '%s' AND date = CURDATE() ORDER BY time DESC LIMIT 1");
define("CSV_HEADER", "# id,symbol,date,time,opening,minimum,maximum,current,rate_percent");

$db = db_connect();

function get_line($db, $symbol)
{ 
  $cols = array("id", "symbol", "date", "time", "opening", "minimum", "maximum", "current", "rate");

  $r = $db->query(sprintf(SQL, $db->escape_string($symbol)), MYSQLI_USE_RESULT);
  if($r)
  {
    $line = array();
    if($row = $r->fetch_array(MYSQLI_ASSOC))
    {
      foreach($cols as $k)
      {
        $line[] = $row[$k];
      }
    }

    $r->close();
    return join(",", $line);;
  }
  return "";
}

header("Content-Type: text/csv");

print CSV_HEADER . "\n";
print get_line($db, "USDKRW") . "\n";
print get_line($db, "KOSPI") . "\n";

exit();