<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=shift_jis">
  <meta name="refresh" content="60">
  <title>�e�퍐�m | �J�� Stooq �g�є�</title>
</head>
<body>
{capture name="holidays"}
{include file="holidays.tpl"}
{/capture}
{$smarty.capture.holidays|mb_convert_encoding:"Shift_JIS":"UTF-8"}

<div><a href="index.php?sym={$stooq.symbol|escape}">�߂�</a></div>

</body>
</html>