<?xml version="1.0" encoding="utf-8"?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja" lang="ja"> 
<head> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
  <meta http-equiv="content-style-type" content="text/css; charset=utf-8" /> 
  <title>{$title|escape} | 谷岡 Stooq</title>
  <style type="text/css">{literal}
    table.summary th { background: #ccc; }
    table.summary td { text-align: right; padding: 4px; }
    table.summary .kospi-start { padding-left: 1em; }
  {/literal}</style>
</head>
<body>
<div><a href="index.php">戻る</a></div>
<hr>
<p>平日 15:10 ごろ生成</p>

<table class="summary">
<tr><th rowspan="2">日付</th><th colspan="4">USDKRW</th><th colspan="4">KOSPI</th></tr>
<tr><th class="kospi-start">始値</th><th>高値</th><th>安値</th><th>終値</th> <th>始値</th><th>高値</th><th>安値</th><th>終値</th></tr>
{foreach $summary as $key => $item}
{$usdkrw = $item.usdkrw}
{$kospi = $item.kospi}
{strip}<tr>
<th>{$key}</th><td>{$usdkrw.opening}</td><td>{$usdkrw.minimum}</td><td>{$usdkrw.maximum}</td><td>{$usdkrw.closing}</td>
<td class="kospi-start">{$kospi.opening}</td><td>{$kospi.minimum}</td><td>{$kospi.maximum}</td><td>{$kospi.closing}</td>
</tr>{/strip}
{/foreach}
</table>

<hr>
<div><a href="index.php">谷岡 Stooq</a></div>
</body>
</html>
