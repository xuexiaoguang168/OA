<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<LINK href="../common.css" type=text/css rel=stylesheet>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String name = privilege.getUser(request);
String receiver = ParamUtil.get(request, "receiver");
%>
<html>
<head>
<title>撰写消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language=javascript>
<!--
function form1_onsubmit()
{
	errmsg = "";
	if (form1.receiver.value=="")
		errmsg += "请填写接收者！\n"
	if (form1.title.value=="")
		errmsg += "请填写标题！\n"
	if (form1.content.value=="")
		errmsg += "请填写内容！\n"
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}

function saveDraft() {
	form1.isDraft.value = "true";
	form1_onsubmit();
	form1.submit();
}

function setPerson(deptCode, deptName, user, userRealName)
{
	form1.receiver.value = user;
	form1.userRealName.value = userRealName;
}

function getSelUserNames() {
	return form1.receiver.value;
}

function getSelUserRealNames() {
	return form1.userRealName.value;
}

<%
UserSetupDb usd = new UserSetupDb();
usd = usd.getUserSetupDb(name);
int messageToMaxUser = usd.getMessageToMaxUser();
%>

var messageToMaxUser = <%=messageToMaxUser%>;
function setUsers(users, userRealNames) {
	var ary = users.split(",");
	var len = ary.length;
	if (len>messageToMaxUser) {
		alert("对不起，您一次最多只能发往" + messageToMaxUser + "个用户！");
		return;
	}
	form1.receiver.value = users;
	form1.userRealName.value = userRealNames;
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
if (!privilege.isUserLogin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}%>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="260">
  <form action="send_do.jsp" method="post" enctype="multipart/form-data" name="form1" onSubmit="return form1_onsubmit()">
  <tr> 
    <td bgcolor="#CEE7FF" height="23">
        <div align="center"> <b>撰 写 新 消 息</b>
		<%
		if (privilege.isUserPrivValid(request, "message.group")) {
		%>
			（<a href="sendtogroup.jsp">群发</a>）
		<%}%>
		</div>
    </td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF" height="50"> 
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td width="75"> 
              <div align="center"><a href="message.jsp?page=1"><img src="images/inboxpm.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><a href="listdraft.jsp"><img src="images/m_draftbox.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><img src="images/newpm.gif" width="40" height="40" border="0"></div>
            </td>
            <td width="75"> 
              <div align="center"> <img src="images/m_delete.gif" width="40" height="40"></div>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
      <td bgcolor="#FFFFFF" height="152" valign="top">
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr> 
            <td width="68" height="27"> 
              <div align="center">接 收 者：</div>            </td>
            <td width="217" height="27">
              <input type="hidden" name="receiver" class="input1" value="<%=receiver%>">
			  <%
			  String userRealName = "";
			  if (!receiver.equals("")) {
			  	com.redmoon.oa.person.UserDb ud = new com.redmoon.oa.person.UserDb();
			  	ud = ud.getUserDb(receiver);
				userRealName = ud.getRealName();
			  }
			  %>
              <input type="text" readonly name="userRealName" class="input1" size="20" maxlength="20" value="<%=userRealName%>">
			  
			  <input type="hidden" name="isDraft" value="false">
			  <a href="#" onClick="javascript:showModalDialog('../user_multi_sel.jsp',window.self,'dialogWidth:600px;dialogHeight:480px;status:no;help:no;')">选择用户</a></td>
          </tr>
          <tr> 
            <td width="68" height="26"> 
              <div align="center">消息标题：</div>            </td>
            <td width="217" height="26">
              <input type="text" name="title" class="input1" size="30">            </td>
          </tr>
          <tr> 
            <td width="68" height="26"> 
              <div align="center">消息内容：</div>            </td>
            <td width="217" height="26"> 
              <textarea name="content" cols="28" rows="3"></textarea>            </td>
          </tr>
          <tr>
            <td height="26" align="center">附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件：</td>
            <td height="26"><input type="file" name="filename"></td>
          </tr>
          <tr> 
            <td colspan="2" height="26"> 
              <div align="center">
                <input type="submit" name="Submit" value="发送" class="button1">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type="reset" name="Submit2" value="重写" class="button1">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" name="Submit3" value="存草稿" class="button1" onClick="saveDraft()">
<%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
&nbsp;&nbsp;
<input name="isToMobile" value="true" type="checkbox" checked>
短讯
<%}%>
</div>            </td>
          </tr>
        </table>
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center" class="9black" height="6">
          <tr> 
            <td></td>
          </tr>
        </table>
      </td>
  </tr>
  <tr> 
    <td bgcolor="#CEE7FF" height="6"></td>
  </tr></form>
</table>
</body>
</html>
