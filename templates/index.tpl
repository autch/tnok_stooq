{include file="default_header.inc.tpl"}

<p>1 分おき {$stooq.symbol|escape}</p>

<p>現在値：{$stooq.current|escape} (前日終値比 {$stooq.rate|difference|escape}%; {$stooq.time|escape} JST)
{if $stooq.symbol == 'KOSPI' && intval(strftime("%H%M", $stooq.timestamp)) < 920}
<b>（9:20 まで KOSPI は前日値）</b>
{/if}</p>

<p>{if $s == "s"}
  <img src="{$stooq.img|sprintf:"s"}" alt="{$stooq.symbol|escape}={$stooq.current|escape}">
{else}
  <a href="?s=s&sym={$stooq.symbol|escape}&r={$reload|escape}">小</a>
{/if}
| {if $s == "m"}
  <img src="{$stooq.img|sprintf:"m"}" alt="{$stooq.symbol|escape}={$stooq.current|escape}">
{else}
  <a href="?s=m&sym={$stooq.symbol|escape}&r={$reload|escape}">中</a>
{/if}
| {if $s == "l"}
  <img src="{$stooq.img|sprintf:"l"}" alt="{$stooq.symbol|escape}={$stooq.current|escape}">
{else}
  <a href="?s=l&sym={$stooq.symbol|escape}&r={$reload|escape}">大</a>
{/if}

</p>
{if $stooq.symbol == 'USDKRW'}
<div>始：{$stooq.opening|escape}
 | 高：{$stooq.minimum|escape}
 | 安：{$stooq.maximum|escape}
</div>
{else}
<div>始：{$stooq.opening|escape}
 | 高：{$stooq.maximum|escape}
 | 安：{$stooq.minimum|escape}
</div>
{/if}
<!-- {$stooq.id|escape} -->

{include file="default_footer.inc.tpl"}
