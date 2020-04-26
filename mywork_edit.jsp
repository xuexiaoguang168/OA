<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "com.redmoon.oa.worklog.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改工作记录</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}
//-->
</script>
</head>
<body background="" leftmargin="0" topmargin="3" marginwidth="0" marginheight="0">
<%
String userName = ParamUtil.get(request, "userName");
%>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td width="100%" height="23" class="right-title">　修改工作记事&nbsp;&nbsp;<a href="mywork.jsp?userName=<%=StrUtil.UrlEncode(userName)%>">本月</a>&nbsp;&nbsp;<a href="mywork_list.jsp?userName=<%=StrUtil.UrlEncode(userName)%>">全部</a></td>
  </tr>
  <tr>
    <td valign="top">
      <%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = ParamUtil.getInt(request, "id");

String content="",mydate="";
String sql = "";

WorkLogMgr wlm = new WorkLogMgr();

String op = request.getParameter("op");
if (op!=null)
{
	boolean re = false;
	try {
		re = wlm.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}

WorkLogDb wld = wlm.getWorkLogDb(request, id);
if (wld!=null && wld.isLoaded()) {
	content = wld.getContent();
	mydate = DateUtil.format(wld.getMyDate(), "yyyy-MM-dd HH:mm:ss");
}
%>
      <br>
      <table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" class="stable">
        <tr bgcolor="#C4DAFF"> 
          <td height="21" colspan="2" align="center" bgcolor="#C4DAFF" class="stable"><%=mydate%></td>
        </tr>
        <form name="form1" action="?op=edit" method="post" onSubmit="">
          <tr bgcolor="#EEEEEE"> 
            <td width="51" height="17" align="center" class="stable">内 容<input type=hidden name="id" value="<%=id%>"></td>
            <td width="357" height="17" class="stable"> <textarea name=content cols="60" class="singleboarder" rows="15"><%=content%></textarea>            </td>
          </tr>
          <tr bgcolor="#EEEEEE"> 
            <td height="28" colspan="2" align="center" class="stable"> <input name="submit" type=submit value="发送"> 
            &nbsp;&nbsp;&nbsp; <input name="reset" type=reset value="取消">            </td>
          </tr>
        </form>
      </table>    
      <br></td>
  </tr>
</table>
</body>
</html>
