<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=shift_jis">
  <meta name="refresh" content="60">
  <title>各種告知 | 谷岡 Stooq 携帯版</title>
</head>
<body>
{capture name="holidays"}
{include file="holidays.tpl"}
{/capture}
{$smarty.capture.holidays|mb_convert_encoding:"Shift_JIS":"UTF-8"}

<div><a href="index.php?sym={$stooq.symbol|escape}">戻る</a></div>

</body>
</html>