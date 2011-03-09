<?php

require_once '../boot.inc.php';

$smarty = new TNSmarty();

$params = get_params($_REQUEST);
$db = db_connect();
$stooq = get_by_params($db, $params);

$smarty->assign_by_ref('stooq', $stooq);
assign_params($params, $smarty);
$smarty->display("index.tpl");
