<html>
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
</head>
<body{if $reload} onload="setPE();"{/if}>
<div>
<a href="index.php?sym=USDKRW&s={$s|escape}&r={$r|escape}">USDKRW</a>
 | <a href="index.php?sym=KOSPI&s={$s|escape}&r={$r|escape}">KOSPI</a>
|| 自動更新：{if !$reload}<a href="?sym={$stooq.symbol|escape}&s={$s|escape}&r=1">入</a> | 切{else}入 | <a href="?sym={$stooq.symbol|escape}&s={$s|escape}&r=0">切</a>{/if}
 || <a href="tiny.php?sym={$symbol|default:"USDKRW"}"
 title="省サイズ">携帯版</a>
 | <a href="iphone.php?sym={$symbol|default:"USDKRW"}">iPhone 版</a>
 | <a href="text.php" title="テキストオンリー">実況コピペ版</a>
 | <a href="dashboard.php?r=1" title="全部入り">ダッシュボード</a>
 | <a href="summary.php" title="β版">日次まとめ</a>
 || <a href="http://tnok.jp/tnst/api.html">仕様</a>
 | <a href="http://twitter.com/tnok_stooq/">Twitter</a></div>
<hr>
{include file="holidays.tpl"}
