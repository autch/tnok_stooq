<?php
require_once '../boot.inc.php';

$empty = array();
$params = get_params($empty);
$db = db_connect();
$params['sym'] = 'USDKRW'; $params['id'] = 0;
$usdkrw = get_by_params($db, $params);

$kws = array("leotard+thighhighs",
             "school_swimsuit+thighhighs", 
             "maid",
             "vocaloid",
             "ass+thighhighs",
             "one_piece_swimsuit+thighhighs",
             "pantyhose+ass",
             "twintails+zettai_ryouiki",
             "saki",
             "kipi");

$kw = $usdkrw['current'] % 10;

header(sprintf("Location: http://behoimi.org/post?tags=%s&commit=Search", $kws[$kw]));
