{if isset($smarty.request.analog)}<!DOCTYPE html>{/if}<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="alternate" type="application/rss+xml" title="管理人のぼやき" href="http://twitter.com/statuses/user_timeline/tnok_stooq.rss">
  <title>{$stooq.symbol|default:$title} | 谷岡 Stooq</title>
  <script type="text/javascript"><!--{if $reload}{literal}
    pe = null;
    function setPE()
    {
      pe = window.setTimeout(function(obj){ location.reload(true); }, 60000);
    }
{/literal}{/if}{literal}
    function nida()
    {
      document.body.innerHTML = document.body.innerHTML.replace(/。/g, 'ニダ。');
    }
{/literal}--></script>
{if isset($smarty.request.analog)}
  <style type="text/css">{literal}
    body { margin: 0px; padding: 0px; background: #000; }
    .kuro_obi { padding: 6px 4px; margin: 0px; background: #000; color: #fff;
                font-size: 18pt; vertical-align: middle;}
    #analog_wm { margin: 2px; float: right;  }
  {/literal}</style>
{/if}
</head>
<body{if $reload} onload="setPE();"{/if}>
{if isset($smarty.request.analog)}
<div class="kuro_obi">
  <div style="float: left;">７月２４日正午(予定)以降、このサイトはご覧になれません。</div>
  <img id="analog_wm" src="analog.png" width="104" height="24">
  <div style="clear: both; height: 0px; display:block; visibility: hidden;"></div>
</div>
<div style="padding: 8px; background: #fff;">
{/if}
<div>
<a href="index.php?sym=USDKRW&s={$s|escape}&r={$r|escape}">USDKRW</a>
{* | <a href="index.php?sym=KOSPI&s={$s|escape}&r={$r|escape}">KOSPI</a>*}
|| 自動更新：{if !$reload}<a href="?sym={$stooq.symbol|escape}&s={$s|escape}&r=1">入</a> | 切{else}入 | <a href="?sym={$stooq.symbol|escape}&s={$s|escape}&r=0">切</a>{/if}
 || <a href="tiny.php?sym={$symbol|default:"USDKRW"}"
 title="省サイズ">携帯版</a>
 | <a href="iphone.html">iPhone 版</a>
 | <a href="text.php" title="テキストオンリー">実況コピペ版</a>
{* | <a href="dashboard.php?r=1" title="全部入り">ダッシュボード</a>*}
 | <a href="summary.php" title="β版">日次まとめ</a>
 || <a href="http://tnok.jp/stooq/api.html">仕様</a>
 | <a href="http://twitter.com/tnok_stooq/">Twitter</a></div>
<hr>
{include file="holidays.tpl"}
