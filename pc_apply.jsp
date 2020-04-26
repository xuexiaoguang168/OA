<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="fan.util.*"%>
<%@ include file="inc/inc.jsp" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>部门管理</title>
<link rel="stylesheet" href="common.css">
<script language="JavaScript">
<!--
function validate()
{
	if  (document.addform.hostname.value=="")
	{
		alert("新加电脑不能为空");
		document.addform.hostname.focus();
		return false ;
	}
}

function getpcinfo()
{
	addform.hostname.value = foawarder.hostname;
	addform.ip.value = foawarder.hostIP;
	addform.info.value = foawarder.pcinfo;
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<body bgcolor="#FFFFFF" onload="getpcinfo()">
      <p>
        <object id=foawarder classid="CLSID:B9CBED34-3F4A-48A5-B75B-47A25988692B" codebase="activex/FWarder.CAB" width="2" height="2"
viewastext>
        </object>
      </p>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="images/tab-b5-top.gif">　　　　　<span class="right-title">办 
      公 电 脑 申 请</span></td>
  </tr>
  <tr> 
    <td height="272" valign="top" background="images/tab-b-back.gif"> 

      <p>&nbsp; </p>
      <table width="99%" border='0' align="center" cellpadding='0' cellspacing='0'>
        <tr > 
          <td width="100%" bgcolor="#F6F6F6"> 
		  <jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/> 
		  
		  <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/> 
            <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/> 
            <%
String id="",hostname="",ip="",info="",username="",pwd="";
String op = fchar.getNullString(request.getParameter("op"));
String sql = "";
if (!op.equals(""))
{
	id = request.getParameter("id");
	hostname = fchar.UnicodeToGB(request.getParameter("hostname"));
	ip = request.getParameter("ip");
	info = request.getParameter("info");
	username = fchar.UnicodeToGB(request.getParameter("username"));
	pwd = request.getParameter("pwd");
	
	boolean isvalid = false;
	try {
		isvalid = userservice.isUserAccountValid(username,pwd);
	}
	catch (ErrMsgException e)
	{
		out.println(fchar.makeErrMsg(e.getMessage()));
	}

	if (isvalid)
	{
		
		int rowcount = 0;
		if (op.equals("apply"))
		{
			sql = "insert into pcinfo (username,hostname,ip,info) values ("+fchar.sqlstr(username)+","+fchar.sqlstr(hostname)+","+fchar.sqlstr(ip)+","+fchar.sqlstr(info)+")";
			rowcount = conn.executeUpdate(sql);
			if (rowcount==0)
				out.println(fchar.Alert("申请办公电脑未成功，请检查该电脑是否已经被申请！"));
			else
				out.println(fchar.Alert("申请成功，请等待管理员申核！"));	
		}
	}
	if (conn!=null)
	{
		conn.close();
		conn = null;
	}
}
%>
            <table width="100%" align="center">
              <FORM METHOD=POST ACTION="pc_apply.jsp?op=apply" name="addform" onsubmit="return validate()">
                <tr> 
                  <td height="24" bgcolor=#F6F6F6>用户名</td>
                  <td bgcolor=#F6F6F6><input type="text" size=10 name="username" style="border:1pt solid #636563;font-size:9pt"></td>
                  <td bgcolor=#F6F6F6>密码 
                    <input type="password" size=15 name="pwd" style="border:1pt solid #636563;font-size:9pt"></td>
                  <td align=center bgcolor=#F6F6F6>&nbsp;</td>
                  <td align=left bgcolor=#F6F6F6>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="21%" bgcolor=#F6F6F6>机器名</td>
                  <td width="18%" bgcolor=#F6F6F6>IP</td>
                  <td width="24%" bgcolor=#F6F6F6>信息</td>
                  <td width="12%" align=center bgcolor=#F6F6F6>&nbsp;</td>
                  <td width="25%" align=left bgcolor=#F6F6F6>&nbsp;</td>
                </tr>
                <tr> 
                  <td bgcolor=#F6F6F6> <input type="text" size=10 name="hostname" style="border:1pt solid #636563;font-size:9pt"> 
                  </td>
                  <td bgcolor=#F6F6F6><input type="text" size=15 name="ip" style="border:1pt solid #636563;font-size:9pt"></td>
                  <td bgcolor=#F6F6F6><input type="text" size=32 name="info" style="border:1pt solid #636563;font-size:9pt"></td>
                  <td align=center bgcolor=#F6F6F6>&nbsp;</td>
                  <td align=left bgcolor=#F6F6F6> 
                    <input type="submit" name="add" value="申请" style="border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;" onClick="return  validate()"></td>
                </tr>
              </form>
            </table></TABLE> </td>
  </tr>
  <tr> 
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>

</body>                                        
</html>                            
  