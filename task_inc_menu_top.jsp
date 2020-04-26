<%@ page contentType="text/html;charset=utf-8"%>
<script src="inc/nav.js"></script>
<table width="100%" height="30" border="1" align="center" cellpadding="1" cellspacing="0" borderColorLight="#848284" borderColorDark="#ffffff" bgcolor="D6D3CE" style="color:#ffffff">
  <tr>
    <td nowrap="nowrap"><table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><img src="images/task/icon-notyet.gif" align="absmiddle" /> <a class="black" href="task.jsp?status=0" title="我未完成的任务">未完成</a></td>
      </tr>
    </table>
      <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><img src="images/task/icon-yes.gif" align="absmiddle" /> <a class="black" href="task.jsp?status=1" title="我已完成的任务">已完成</a></td>
      </tr>
    </table>
	  <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
        <tr>
          <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><img src="images/task/icon-no.gif" align="absmiddle" /> <a class="black" href="task.jsp?status=2" title="我已作废的任务">已作废</a></td>
        </tr>
      </table>
	  <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="task.jsp" title="我的全部任务">全部任务</a></td>
      </tr>
    </table>
	  <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
        <tr>
          <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="task_query.jsp" title="查询任务">任务查询</a></td>
        </tr>
      </table></td>
  </tr>
</table>
