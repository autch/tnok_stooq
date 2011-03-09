<?php

require_once '../boot.inc.php';

$smarty = new TNSmarty();

$params = get_params($_REQUEST);
$db = db_connect();
$params['sym'] = 'USDKRW'; $params['id'] = 0;
$usdkrw = get_by_params($db, $params);
$params['sym'] = 'KOSPI'; $params['id'] = 0;
$kospi = get_by_params($db, $params);

assign_params($params, $smarty);

$smarty->assign_by_ref('usdkrw', $usdkrw);
$smarty->assign_by_ref('kospi', $kospi);
$smarty->assign("title", "ダッシュボード");
$smarty->display("dashboard.tpl");
