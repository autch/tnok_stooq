<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=shift_jis">
  <meta name="refresh" content="60">
  <title>{$stooq.symbol|escape} | �J�� Stooq �g�є�</title>
</head>
<body>
<div>�d�v�F<a href="announce.php"><b>�J��Stooq�I���̂��m�点</b></a></div>

<img src="{$stooq.img|sprintf:"s"}"
     alt="{$stooq.symbol|escape}={$stooq.current|escape}">

<div><a href="">�X�V</a>
 || <a href="?sym=USDKRW">USDKRW</a>
{* | <a href="?sym=KOSPI">KOSPI</a>*}</div>
<div>{$stooq.symbol|escape}: {$stooq.current|escape}
 ({$stooq.rate|difference|escape}%; {$stooq.time|escape})
{if $stooq.symbol == 'KOSPI' && intval(strftime("%H%M", $stooq.timestamp)) < 920}�i9:20 �܂őO���l�j{/if}</div>
{if $stooq.symbol == 'USDKRW'}
<div>�n: {$stooq.opening|escape}, ��: {$stooq.minimum|escape}, ��: {$stooq.maximum|escape}</div>
{else}
<div>�n: {$stooq.opening|escape}, ��: {$stooq.maximum|escape}, ��: {$stooq.minimum|escape}</div>
{/if}
<hr>
<div><a href="index.php?sym={$stooq.symbol|escape}">�t����</a></div>
{include file="ads_and_counter.tpl" ktai=true}
</body>
</html>
