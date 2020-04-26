<%@ page contentType="text/html; charset=utf-8"%>
<script src="../inc/nav.js"></script>
<table width="100%" height="30" border="1" align="center" cellpadding="1" cellspacing="0" bordercolorlight="#848284" bordercolordark="#ffffff" bgcolor="D6D3CE" style="color:#ffffff">
  <tr>
    <td nowrap="nowrap"><table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="address.jsp?type=<%=type%>">通讯录</a></td>
      </tr>
    </table>
        <table align="left" border="0" cellpadding="0" cellspacing="0" width="120" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
          <tr>
            <td width="35%" height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" href="address_add.jsp?type=<%=type%>">添加</a></td>
          </tr>
        </table>
    </td>
  </tr>
</table>
