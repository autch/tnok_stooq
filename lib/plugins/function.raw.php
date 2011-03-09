<?php

function smarty_function_raw($params, &$smarty)
{
  $physipath = TNST_DOCROOT . '/' . TNST_RAW_CSV;
  $filename = TNST_RAW_CSV . sprintf("%s_%s.csv",
                                          strtolower($params['symbol']),
                                          strftime("%Y-%m-%d"));
  if(file_exists(TNST_DOCROOT . '/' . $filename))
  {
    return sprintf("<a href=\"%s\">%s</a>", htmlspecialchars($filename),
                   htmlspecialchars(strtoupper($params['symbol'])));
  }
  else
  {
    return sprintf("%s（まだ）",
                   htmlspecialchars(strtoupper($params['symbol'])));
  }
}
