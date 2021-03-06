<?php

define("DEFAULT_CALLBACK_NAME", "tnokJSONPCallback");

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

$cb_name = isset($_REQUEST['cb'])
  ? trim($_REQUEST['cb']) : DEFAULT_CALLBACK_NAME;

if(preg_match("/^[a-zA-Z0-9][a-zA-Z0-9_]*$/", $cb_name) == 0)
{
  $cb_name = DEFAULT_CALLBACK_NAME;
}

echo $cb_name . '(';
echo json_encode($source);
echo ");\n";
