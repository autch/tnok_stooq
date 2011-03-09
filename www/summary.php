<?php

require_once '../boot.inc.php';

$usdkrw = array();
$kospi = array();

$smarty = new TNSmarty();

$db = db_connect();

$stmt = $db->prepare("SELECT date, "
                     ."opening, minimum, maximum, closing "
                     ."FROM stooq_summary "
                     ."WHERE symbol = ? "
                     ."ORDER BY date DESC");

$stmt->bind_param("s", $symbol);
$symbol = 'USDKRW';
$stmt->execute();
$result = array();
$stmt->bind_result($result['date'], $result['opening'], $result['minimum'],
                   $result['maximum'], $result['closing']);
while($stmt->fetch())
{
  $r = array();
  foreach($result as $k => $v)
    $r[$k] = $v;
  $usdkrw[] = $r;
}

$symbol = 'KOSPI';
$stmt->execute();
while($stmt->fetch())
{
  $r = array();
  foreach($result as $k => $v)
    $r[$k] = $v;
  $kospi[] = $r;
}

$summary = array();

foreach($usdkrw as $day)
{
    $summary[$day['date']]['usdkrw'] = $day;
}
foreach($kospi as $day)
{
    $summary[$day['date']]['kospi'] = $day;
}


$smarty->assign("title", "日次まとめ");
$smarty->assign("usdkrw", $usdkrw);
$smarty->assign("kospi", $kospi);
$smarty->assign("summary", $summary);

$smarty->display("summary.tpl");