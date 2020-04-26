<%@ page contentType="text/html;charset=utf-8"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发起任务</title>
<link href="common.css" rel="stylesheet" type="text/css">
<script>
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function changeexpression(i)
{
	frmAnnounce.expression.value = i;
	if (i==0)
	{
		expressspan.innerHTML = "";
		return;
	}
	expressspan.innerHTML = "<img align=absmiddle src=forum/images/emot/em"+i+".gif>";
}

function setPerson(deptCode, deptName, user)
{
	if (frmAnnounce.person.value=="") {
		frmAnnounce.person.value = user;
		frmAnnounce.jobCode.value = deptCode;
	}
	else {
		frmAnnounce.person.value += "," + user;
		frmAnnounce.jobCode.value += "," + deptCode;
	}
}

function frmAnnounce_onsubmit() {
	frmAnnounce.content.value = IframeID.document.body.innerHTML;
}

function window_onload() {
	cws_Size(320);
}

var attachCount = 1;
function AddAttach() {
	updiv.insertAdjacentHTML("BeforeEnd", "<table width=100%><tr>附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件&nbsp;&nbsp;<input type='file' name='filename" + attachCount + "' size=40><td></td></tr></table>");
	attachCount += 1;
}
</script>
</head>
<%
String priv="task";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<body leftmargin="0" topmargin="5" onLoad="window_onload()">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="task_inc_menu_top.jsp"%>
<br>
<%
String op = fchar.getNullStr(request.getParameter("op"));
if (op.equals(""))
{
	out.print(fchar.Alert("您未选择操作方式！"));
	return;
}
String typedesc = "";//类型描述
int type=0;
if (op.equals("new"))
{
	type = 0;
	typedesc = "发起新任务";
	priv="task";
	if (!privilege.isUserPrivValid(request,priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
if (op.equals("newsubtask"))
{
	type = 1;
	typedesc = "发起子任务";
	priv="task";
	if (!privilege.isUserPrivValid(request,priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
if (op.equals("addresult"))
{
	type = 2;
	typedesc = "汇报办理结果";
}
if (op.equals("hurry"))
{
	type = 3;
	typedesc = "催办";
}
String parentid = fchar.getNullStr(request.getParameter("parentid"));
String privurl=fchar.UnicodeToGB(request.getParameter("privurl"));
String person = fchar.UnicodeToGB(fchar.getNullStr(request.getParameter("person")));
%>
<table width="498" border="0" align="center" cellpadding="4" cellspacing="0" class="main">
  <form id="frmAnnounce" name=frmAnnounce method="post" action="task_add_do.jsp?op=<%=op%>" enctype="MULTIPART/FORM-DATA" onSubmit="return frmAnnounce_onsubmit()">
    <TBODY>
      <tr> 
        <td class="right-title"> <font color="#FFFFFF">&nbsp;<span id=expressspan></span></font>&nbsp;<font color="#FFFFFF"><%=typedesc%> 
          <input type=hidden name=type value="<%=type%>">
          <input type=hidden name=op value="<%=op%>">
          <input type=hidden name=expression value="0">
          <input type=hidden name=parentid value="<%=parentid%>">
          <input type=hidden name=privurl value="<%=privurl%>">
          </font></td>
      </tr>
    </TBODY>
    <TBODY>
      <tr> 
        <td width="486"> 任务标题 
        <input name="title" type="text" id="topic" size="55"  title="不得超过 25 个汉字或50个英文字符" maxlength="80">
        <span class="tablebody1">
        <input name="jobCode" type="hidden">
        </span> <span class="tablebody1">
        <input name="person" type="hidden">
        </span></td>
      </tr>
      <tr>
        <td>表&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;情
          <iframe src="task_iframe_emote.jsp" height="25" width="610" marginwidth="0" marginheight="0" frameborder="0" scrolling="yes"></iframe>
            
          <a href="#" onClick="changeexpression(0)">取消表情&nbsp;</a></td>
      </tr>
      <tr> 
        <td><table width="100%" border=0 cellspacing=0 cellpadding=0>
            <tr> 
              <td class=tablebody1 valign=top height=30> 附&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;件 
                <input type="file" name="filename" size=40>
                <input name="content" type="hidden">				<input name="button" type=button onClick="AddAttach()" value="增加附件"></td>
            </tr>
          </table><div id=updiv name=updiv></div></td>
      </tr>
      <tr> 
        <td><%@ include file="editor_full/editor.jsp"%></td>
      </tr>
      
      <tr> 
        <td align="center">
            <input name="submit" type=submit value="发起任务">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
          <input name="reset" type=reset value=" 重 设 ">          </td>
      </tr>
    </TBODY>
  </form>
</table>
</body>
</html>
