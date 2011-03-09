<?php

header("Content-Type: application/x-javascript; charset=utf-8");

require_once '../boot.inc.php';

$smarty = new TNSmarty();

$empty = array();
$params = get_params($empty);
$db = db_connect();
$params['sym'] = 'USDKRW'; $params['id'] = 0;
$usdkrw = get_by_params($db, $params);
$params['sym'] = 'KOSPI'; $params['id'] = 0;
$kospi = get_by_params($db, $params);

assign_params($params, $smarty);

$source = array("usdkrw" => $usdkrw, "kospi" => $kospi);

echo json_encode($source);
