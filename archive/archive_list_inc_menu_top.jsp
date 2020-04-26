<%@ page contentType="text/html; charset=utf-8"%>
<script src="../inc/nav.js"></script>
<table width="100%" height="30" border="1" align="center" cellpadding="1" cellspacing="0" borderColorLight="#848284" borderColorDark="#ffffff" bgcolor="D6D3CE" style="color:#ffffff">
  <tr>
    <td nowrap="nowrap">
	<table align="left" border="0" cellpadding="0" cellspacing="0" width="12%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_user_list.jsp"<%}else{%>href="archive_user_modify.jsp?userName=<%=userName%>"<%}%>>用户信息</a></td>
      </tr>
    </table>
	<table align="left" border="0" cellpadding="0" cellspacing="0" width="12%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_study_list.jsp"<%}else{%>href="archive_study_list.jsp?userName=<%=userName%>"<%}%>>学习信息</a></td>
      </tr>
    </table>
	<table align="left" border="0" cellpadding="0" cellspacing="0" width="12%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_resume_list.jsp"<%}else{%>href="archive_resume_list.jsp?userName=<%=userName%>"<%}%>>履历列表</a></td>
      </tr>
    </table>
	<table align="left" border="0" cellpadding="0" cellspacing="0" width="12%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_family_list.jsp"<%}else{%>href="archive_family_list.jsp?userName=<%=userName%>"<%}%>>家庭列表</a></td>
      </tr>
    </table>
      <table align="left" border="0" cellpadding="0" cellspacing="0" width="13%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_duty_list.jsp"<%}else{%>href="archive_duty_list.jsp?userName=<%=userName%>"<%}%>>任职列表</a></td>
      </tr>
    </table>
	  <table align="left" border="0" cellpadding="0" cellspacing="0" width="13%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
        <tr>
          <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_profession_list.jsp"<%}else{%>href="archive_profession_list.jsp?userName=<%=userName%>"<%}%>>专业技能列表</a></td>
        </tr>
      </table>
	  <table align="left" border="0" cellpadding="0" cellspacing="0" width="13%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_assess_list.jsp"<%}else{%>href="archive_assess_list.jsp?userName=<%=userName%>"<%}%>>考核列表</a></td>
      </tr>
    </table>
	<table align="left" border="0" cellpadding="0" cellspacing="0" width="13%" bgcolor="D6D3CE" style="color:#ffffff" onmouseover="return menu_table_onmouseover(this)" onmouseout="return menu_table_onmouseout(this)">
      <tr>
        <td height="22" align="center" nowrap="nowrap" style="border:thin" onmouseover="return menu_td_onmouseover(this)" onmouseout="return menu_td_onmouseout(this)"><a class="black" <%if(userName.equals("")){%>href="archive_rewards_list.jsp"<%}else{%>href="archive_rewards_list.jsp?userName=<%=userName%>"<%}%>>奖励列表</a></td>
      </tr>
    </table></td>
  </tr>
</table>
