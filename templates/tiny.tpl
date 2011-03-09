<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=shift_jis">
  <meta name="refresh" content="60">
  <title>{$stooq.symbol|escape} | 谷岡 Stooq 携帯版</title>
</head>
<body>
{capture name="holidays"}
{include file="holidays.tpl"}
{/capture}
{$smarty.capture.holidays|mb_convert_encoding:"Shift_JIS":"UTF-8"}

<img src="{$stooq.img|sprintf:"s"}"
     alt="{$stooq.symbol|escape}={$stooq.current|escape}">

<div><a href="">更新</a>
 || <a href="?sym=USDKRW">USDKRW</a>
 | <a href="?sym=KOSPI">KOSPI</a></div>
<div>{$stooq.symbol|escape}: {$stooq.current|escape}
 ({$stooq.rate|difference|escape}%; {$stooq.time|escape})
{if $stooq.symbol == 'KOSPI' && intval(strftime("%H%M", $stooq.timestamp)) < 920}（9:20 まで前日値）{/if}</div>
{if $stooq.symbol == 'USDKRW'}
<div>始: {$stooq.opening|escape}, 高: {$stooq.minimum|escape}, 安: {$stooq.maximum|escape}</div>
{else}
<div>始: {$stooq.opening|escape}, 高: {$stooq.maximum|escape}, 安: {$stooq.minimum|escape}</div>
{/if}
<hr>
<div><a href="index.php?sym={$stooq.symbol|escape}">フル版</a></div>
{include file="ads_and_counter.tpl" ktai=true}
</body>
</html>
