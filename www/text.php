<?php

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

$smarty->assign_by_ref('usdkrw', $usdkrw);
$smarty->assign_by_ref('kospi', $kospi);

$type = isset($_REQUEST['type']) ? trim($_REQUEST['type']) : FALSE;

switch($type)
{
  case "twitter":
    $tmpl = "twitter.tpl";
    break;
  case "text":
  default:
    $tmpl = "text.tpl";
}

$smarty->display($tmpl);

