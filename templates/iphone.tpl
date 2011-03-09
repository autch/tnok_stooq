<?xml version="1.0" encoding="Shift_JIS" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ja"> 
  <head> 
    <meta http-equiv="content-type" content="text/html; charset=Shift_JIS" /> 
    <title>{$stooq.symbol|escape} | 谷岡 Stooq iPhone/Android版</title>
    <meta name="viewport" content="width=device-width; initial-scale=1.0;maximum-s\cale=1.0; user-scalable=0;"/>
    <link rel="apple-touch-icon" href="/stooq/iui/iui-logo-touch-icon.png" />
    <meta name="apple-touch-fullscreen" content="YES" />
    <style type="text/css" media="screen">@import "/stooq/iui/iuix.css";</style>
    <script type="text/javascript" src="/stooq/iui/iuix.js"></script>
    <script type="text/javascript"><!--{literal}
    pe = null;
    function setPE()
    {
      pe = window.setTimeout(function(obj){ location.reload(true); }, 60000);
    }
{/literal}--></script>
  </head> 
  <body onload="setPE();">
{capture name="holidays"}
{include file="holidays.tpl"}
{/capture}
{$smarty.capture.holidays|mb_convert_encoding:"Shift_JIS":"UTF-8"}
  <div class="toolbar">
    <h1 id="pageTitle">{$stooq.symbol|escape}</h1>
    <a class="button" href="" target="_self">更新</a>
  </div>
  <ul id="stooq" selected="true">
    <li>{$stooq.symbol|escape}: {$stooq.current|escape}
      ({$stooq.rate|difference|escape}%; {$stooq.time|escape})
      {if $stooq.symbol == 'KOSPI'
      && intval(strftime("%H%M", $stooq.timestamp)) < 920}
     （9:20 まで前日値）{/if}
    </li>
    <li><img src="{$stooq.img|sprintf:"s"}"
     alt="{$stooq.symbol|escape}={$stooq.current|escape}"
     style="background-color: #fff; padding-top: 4px;"/>
      </li>
<li>
{if $stooq.symbol == 'USDKRW'}
始: {$stooq.opening|escape},
高: {$stooq.minimum|escape},
安: {$stooq.maximum|escape}
{else}
始: {$stooq.opening|escape},
高: {$stooq.maximum|escape},
安: {$stooq.minimum|escape}
{/if}
</li>
<li class="group">銘柄を選択</li>
<li><a href="?sym=USDKRW" target="_self">USDKRW</a></li>
<li><a href="?sym=KOSPI" target="_self">KOSPI</a></li>
<li class="group"></li>
<li><a href="/stooq/" target="_self">フル版へ</a></li>
</ul>

</body>
</html>
