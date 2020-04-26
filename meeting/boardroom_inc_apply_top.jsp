<%@ page contentType="text/html; charset=utf-8"%><%@ page import = "com.redmoon.oa.meeting.BoardroomSQLBuilder"%>
<script src="../inc/nav.js"></script>
<table width="100%" height="30" border="1" align="center" cellpadding="1" cellspacing="0" bordercolorlight="#848284" bordercolordark="#ffffff" bgcolor="D6D3CE" style="color:#ffffff">
  <tr>
    <td nowrap="nowrap"><table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="boardroom_apply_list.jsp?result=<%=StrUtil.UrlEncode(BoardroomSQLBuilder.RESULT_APPLY)%>">待批会议</a></td>
      </tr>
    </table>
        <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
          <tr>
            <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="boardroom_apply_list.jsp?result=<%=StrUtil.UrlEncode(BoardroomSQLBuilder.RESULT_AGREE)%>">已准会议</a></td>
          </tr>
        </table>
      <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
          <tr>
            <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="boardroom_apply_list.jsp?result=<%=StrUtil.UrlEncode(BoardroomSQLBuilder.RESULT_USED)%>">进行中会议</a></td>
          </tr>
        </table>
      <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
          <tr>
            <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="boardroom_apply_list.jsp?result=<%=StrUtil.UrlEncode(BoardroomSQLBuilder.RESULT_DISAGREE)%>">未批准会议</a></td>
          </tr>
        </table>
      <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
          <tr>
            <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="boardroom_apply_list.jsp?result=<%=StrUtil.UrlEncode(BoardroomSQLBuilder.RESULT_END)%>">已结束会议</a></td>
          </tr>
      </table></td>
  </tr>
</table>
