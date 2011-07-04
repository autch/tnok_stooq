{include file="default_header.inc.tpl"}

<table>
<tr>
<td>
<div>USDKRW: {$usdkrw.current|escape} ({$usdkrw.rate|difference|escape}%; {$usdkrw.time|escape} JST)</div>
<img src="{$usdkrw.img|sprintf:"m"}"
	alt="{$usdkrw.symbol|escape}={$usdkrw.current|escape}">
<!-- USDKRW id: {$usdkrw.id|escape} -->
<div>始：{$usdkrw.opening|escape}
 | 高：{$usdkrw.minimum|escape}
 | 安：{$usdkrw.maximum|escape}
</div>
</td>

<td>
{*<div>KOSPI: {$kospi.current|escape} ({$kospi.rate|difference|escape}%; {$kospi.time|escape} JST)
{if intval(strftime("%H%M", $kospi.timestamp)) < 920}
<b>（9:20 まで KOSPI は前日値）</b>
{/if}</div>

<img src="{$kospi.img|sprintf:"m"}"
	alt="{$kospi.symbol|escape}={$kospi.current|escape}">
<!-- KOSPI id: {$kospi.id|escape} -->
<div>始：{$kospi.opening|escape}
 | 高：{$kospi.maximum|escape}
 | 安：{$kospi.minimum|escape}
</div>*}
</td>

</tr>
</table>

{include file="default_footer.inc.tpl"}
