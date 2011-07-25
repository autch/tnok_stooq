{assign var="today" value=$smarty.now|date_format:"%Y%m%d"}
{if $today eq "20091002"}
<p><b>今日は「秋夕（旧盆）」のため休場(´・ω・`)</b></p>
{/if}
{if $today eq "20091112"}
<p><b>今日は<a href="http://ja.wikipedia.org/wiki/%E5%A4%A7%E5%AD%A6%E4%BF%AE%E5%AD%A6%E8%83%BD%E5%8A%9B%E8%A9%A6%E9%A8%93">大学修学能力試験</a>で10時開場</b>（為替の閉場は15時、株式は16時）
でもここは通常どおり動作(´・ω・`)</p>
{/if}

{if $today eq "20091225"}
<p><b>Happy Holidays! 今日は休場。</b></p>
{/if}

{if $today eq "20110606"}
<p><b>今日は顕忠日でおやすみ。</b></p>
{/if}

{if !isset($smarty.request.analog)}
<div style="border: 1px solid red; padding: 2px; margin: 0.5em auto;">
<p>各種スレのテンプレから削除推奨。<a href="http://twitter.com/#!/tnok_stooq/status/83344371633758208">KOSPI終了の言い訳</a> <b>OK, 25日までには閉める。</b></p>

<p>ブラウザオンリーで動く<a href="https://gist.github.com/1077689">テキスト版</a>を作ってみた。各自ダウンロードしてお楽しみください。</p>

<p>閉鎖後も<a href="http://www.google.co.jp/search?ie=UTF-8&q=%E6%9A%AB%E5%AE%9A%E7%A8%8E%E7%8E%87+%E5%BD%93%E5%88%86%E3%81%AE%E9%96%93">当分の間</a>はチャート画像と数値DBのダンプを掲載する。ついでに<a href="http://github.com/autch/tnok_stooq/">全ソースコード</a>。</p>
</div>
{/if}