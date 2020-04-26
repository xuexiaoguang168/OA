<%@ page contentType="text/html;charset=utf-8" %>
<%@ include file="../inc/nocache.jsp"%>
<%@ page import="cn.js.fan.util.*"%>
<html>
<head>
<title>撰写消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../common.css" type=text/css rel=stylesheet>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="260">
  <tr> 
    <td bgcolor="#CEE7FF" height="23">
        <div align="center"> <b>撰 写 新 消 息</b></div>
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
              <div align="center"><a href="send.jsp"><img src="images/newpm.gif" width="40" height="40" border="0"></a></div>
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
            
          <td height="35"> <li>
<jsp:useBean id="Msg" scope="page" class="com.redmoon.oa.message.MessageMgr"/>
<%
String op = ParamUtil.get(request, "op");
boolean isSuccess = false;
try {
	if (op.equals("")) {
		isSuccess = Msg.AddMsg(application, request);
	}
	if (op.equals("sendDraft")) {
		isSuccess = Msg.sendDraft(request);
	}
}
catch (ErrMsgException e) {
	out.println(StrUtil.Alert_Back("消息发送失败："+e.getMessage()));
	System.out.println("--------------");
	e.printStackTrace();
}
%>
<%if (isSuccess) { %>
    消息处理成功！
<%} else {%>
	消息发送失败！
<%}%>
			  </td>
          </tr>
          <tr> 
            <td height="35"> 
              <div align="center"></div>
            </td>
          </tr>
          <tr> 
            <td height="35"> 
              <div align="center"></div>
            </td>
          </tr>
          <tr> 
            <td height="35"> 
              <div align="center"> </div>
            </td>
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
  </tr>
</table>
</body>
</html>
