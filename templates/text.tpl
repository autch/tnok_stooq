<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>実況コピペ用 | 谷岡 Stooq</title>
  <script type="text/javascript"><!--{literal}
    pe = null;
    function setPE()
    {
      pe = window.setTimeout(function(obj){ location.reload(true); }, 60000);
    }
    function copy_value()
    {
      if(document.all
        && navigator.userAgent.match(/windows/i) && document.all.value.value)
      {
        copy_obj = document.all.value.createTextRange()
        copy_obj.execCommand("Copy")
      }
    }
{/literal}--></script>
</head>
<body onload="setPE();">
{include file="holidays.tpl"}

<div>実況板コピペ用（60 秒自動更新）| <a href="?type=twitter">Twitter 用</a></div>
<textarea rows="2" cols="45" onclick="focus(); select();" name="value" id="value" readonly="readonly">USDKRW: {$usdkrw.current|escape} ({$usdkrw.rate|difference|escape}%; {$usdkrw.time|escape} JST)@tnok
{*KOSPI: {if intval(strftime("%H%M", $kospi.timestamp)) < 920}（前日値）{/if} {$kospi.current|escape} ({$kospi.rate|difference|escape}%; {$kospi.time|escape} JST)@tnok*}</textarea>
<button onclick="copy_value()">コピー (IE 専用)</button>
<div><a href="index.php">谷岡 Stooq</a></div>
{include file="ads_and_counter.tpl"}
</body>
</html>
