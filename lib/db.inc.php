<?php

define("MMC_KEY_BY_ID", "tnok-stooq_by-id_%d");
define("MMC_KEY_BY_SYM", "tnok-stooq_by_sym_%s");

function db_connect()
{
  $mysqli = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
  return $mysqli;
}

function get_mmc()
{
  $memcache = new Memcache;
  $memcache->connect('127.0.0.1', 11211);
  return $memcache;
}

function query_to_db(&$mysqli, &$params, &$memcache)
{
  $cols = array('id', 'symbol', 'date', 'time', 
                'opening', 'minimum', 'maximum', 'current', 'rate');
  $result = array();

  $sql = "SELECT " . implode(", ", $cols) . " FROM stooq "; 
  if($params['id'] != 0)
  {
    $sql .= "WHERE id = ? LIMIT 1";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("i", $params['id']);
  }
  else
  {
    $sql .= "WHERE symbol = ? ORDER BY date DESC, time DESC LIMIT 1";
    $stmt = $mysqli->prepare($sql);
    $stmt->bind_param("s", $params['sym']);
  }

  $stmt->execute();
  $stmt->bind_result($result['id'], $result['symbol'], $result['date'],
                     $result['time'],
                     $result['opening'], $result['minimum'],
                     $result['maximum'], $result['current'], $result['rate']);

  if($stmt->fetch())
  {
    $params['sym'] = $result['symbol'];
    $params['id'] = $result['id'];
    list($yyyy, $mm, $dd) = explode('-', $result['date']);
    list($hh, $ii, $ss) = explode(":", $result['time']);

    $result['timestamp'] = mktime($hh, $ii, $ss, $mm, $dd, $yyyy);
    $path = TNST_PREFIX_CHART . '/' . strftime("%Y/%m/%d", $result['timestamp']);
    $result['img'] = $path . '/' . sprintf("%s_%s_%%s.gif", strtolower($result['symbol']),
                                           strftime("%Y%m%d%H%M%S", $result['timestamp']));
    if($params['id'] != 0)
    {
      $memcache->set(sprintf(MMC_KEY_BY_ID, $params['id']), $result);
    }
    else
    {
      $memcache->set(sprintf(MMC_KEY_BY_SYM, $params['sym']), $result);
    }

    return $result;
  }
  else
  {
    return FALSE;
  }
}

function get_by_params(&$mysqli, &$params)
{
  $memcache = get_mmc();

  if($params['id'] != 0)
  {
    $result = $memcache->get(sprintf(MMC_KEY_BY_ID, $params['id']));
  }
  else
  {
    $result = $memcache->get(sprintf(MMC_KEY_BY_SYM, $params['sym']));
  }

  if($result !== FALSE)
  {
    return $result;
  }
  else
  {
    return query_to_db($mysqli, $params, $memcache);
  }
}
