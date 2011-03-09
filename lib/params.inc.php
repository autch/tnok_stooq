<?php

function get_params(&$src)
{
  $params = array();
  $params['id'] = isset($src['id']) ? intval($src['id']) : 0;
  $params['sym'] = isset($src['sym']) ? trim($src['sym']) : 'USDKRW';
  
  if(isset($src['sym']))
  {
    switch(strtoupper($src['sym']))
    {
    case "USDKRW": case "KOSPI":
      $params['sym'] = strtoupper($src['sym']);
      break;
    default:
      $params['sym'] = "USDKRW";
    }
  }
  else
  {
    $params['sym'] = 'USDKRW';
  }

  if(isset($src['s']))
  {
    switch($src['s'])
    {
    case 'l': case 'm': case 's':
      $params['size'] = 'chart_' . trim($src['s']);
      $params['s'] = trim($src['s']);
      break;
    default:
      $params['size'] = 'chart_s';
      $params['s'] = 's';
    }
  }
  else
  {
    $params['size'] = 'chart_s';
    $params['s'] = 's';
  }

  $params['r'] = (isset($src['r']) && (intval($src['r']) == 1)) ? "1" : "0";
  $params['reload'] = $params['r'] == "1" ? TRUE : FALSE;

  return $params;
}

function assign_params(&$params, &$smarty)
{
  foreach($params as $k => $v)
  {
    $smarty->assign($k, $v);
  }
}
