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