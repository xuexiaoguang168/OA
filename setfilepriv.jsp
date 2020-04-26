<%@ page contentType="text/html;charset=gb2312"%>
<html>
<head>
<title>授予权限</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="common.css" type="text/css">
<%
String op = request.getParameter("op");
%>
<script language="javascript">
<!--
function setFilePriv()
{
  var op = "<%=op%>";
  len = department.options.length;
  var priv="",privview="";
  for (i=0; i<len; i++)
  {
	if (department.options(i).selected)
	{
		priv += "|"+department.options(i).value;
		if (privview=="")
			privview += department.options(i).text;
		else
			privview += ","+department.options(i).text;
	}
  }
  if (priv!="")
  	priv += "|"
  if (op=="open")
  {
	  window.opener.form1.openpriv.value = priv;
	  window.opener.form1.openprivview.value = privview;
  }
  if (op=="modify")
  {
  	  window.opener.form1.modifypriv.value = priv;
   	  window.opener.form1.modifyprivview.value = privview;
  }
  window.close();
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="../inc/inc.jsp"%>
<br>
<jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
<jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<table class=p9 width="56%" border="0" cellpadding="0" cellspacing="0" align="center" height="70">
  <tr bgcolor="#C4DAFF"> 
    <td height="22" colspan="2" align="center" class="stable">请选择应赋予权限的用户组</td>
  </tr>
  <tr> 
    <td width="77%" height="222" align="center" bgcolor="#F7F7F7" class="stable"> 
      <select id=department name=department size=2 style="HEIGHT: 200px; WIDTH: 180px" multiple>
        <option value="public">公共</option>
        <%
		String sql;
		sql = "select id,name from department";
		ResultSet rs = null;
		try {
			rs = conn.executeQuery(sql);
			while(rs.next())
			{
				out.println("<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>");
				out.println();
			}
		}
		catch (SQLException e) {
			out.print(e.getMessage());
		}
		finally {
			if (rs!=null) {
				rs.close();
				rs = null;
			}
			if (conn!=null) {
				conn.close();
				conn = null;
			}
		}
		%>
      </select> </td>
    <td width="23%" height="222" align="center" bgcolor="#F7F7F7" class="stable"> 
      <input name="button" type=button onClick="setFilePriv()" value="确定"> </td>
  </tr>
</table>
<br>
</body>
</html>