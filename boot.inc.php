<?php

ini_set("display_errors", 0);
ini_set("log_errors", 1);

require_once(dirname(__FILE__) . '/config.inc.php');

$path = explode(PATH_SEPARATOR, ini_get('include_path'));
array_unshift($path, TNST_LIB);
ini_set('include_path', implode(PATH_SEPARATOR, $path));

require_once 'db.inc.php';
require_once 'params.inc.php';
require_once 'TNSmarty.class.php';

