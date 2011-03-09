<?php

function smarty_function_chart($params, &$smarty)
{
  $physipath = TNST_DOCROOT . '/' . TNST_CHART_IMAGES;
  $filename = TNST_CHART_IMAGES . sprintf("%s_%s.gif",
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
