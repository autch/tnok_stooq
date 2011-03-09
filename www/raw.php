<?php
mb_http_output('pass');

require_once '../boot.inc.php';

$cols = array("id", "symbol", "date", "time", "opening", "minimum", "maximum", "current", "rate");

$params = get_params($_REQUEST);

$db = db_connect();

$sql = "SELECT id, symbol, date, time, "
."opening, minimum, maximum, current, rate "
."FROM stooq "
."WHERE symbol = '%s' AND date = CURDATE() "
."ORDER BY time ASC";
$r = $db->query(sprintf($sql, $db->escape_string($params['sym'])),
                MYSQLI_USE_RESULT);

if($r)
{
  header("Content-Type: text/csv");

  print "# id,symbol,date,time,opening,minimum,maximum,current,rate_percent\n";

  while($row = $r->fetch_array(MYSQLI_ASSOC))
  {
    $line = array();
    foreach($cols as $k)
    {
      $line[] = $row[$k];
    }

    print join(",", $line);
    print "\n";
  }

  $r->close();
  exit();
}

