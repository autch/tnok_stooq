<?php

require_once '../boot.inc.php';

mb_internal_encoding("SJIS");
mb_regex_encoding("SJIS");

$smarty = new TNSmarty();

$params = get_params($_REQUEST);
$db = db_connect();
$stooq = get_by_params($db, $params);

$smarty->assign_by_ref('stooq', $stooq);
assign_params($params, $smarty);
$smarty->display("iphone.tpl");
