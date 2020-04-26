<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<%
String rootpath = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑表单</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
<script>
function getFormContent() {
	return divContent.innerHTML;
}

function form1_onsubmit() {
	form1.content.value = getFormContent();
}
</script>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String code = ParamUtil.get(request, "code");
FormDb fd = new FormDb();
fd = fd.getFormDb(code);

String name = ParamUtil.get(request, "name");
String content = ParamUtil.get(request, "content");
String flowTypeCode = ParamUtil.get(request, "flowTypeCode");

FormParser fp = new FormParser(content);
Vector newv = fp.getFields();

try {
	fp.validateFields();
}
catch (ErrMsgException e) {
	out.print(StrUtil.Alert_Back(e.getMessage()));
	return;
}

Vector[] vt = fd.checkFieldChange(fd.getFields(), newv);
Vector delv = vt[0];
int dellen = delv.size();
Vector addv = vt[1];
int addlen = addv.size();
%>
<table width="622" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
<form name="form1" action="form_edit.jsp?op=modify" method="post" onSubmit="return form1_onsubmit()">
  <tr> 
    <td height="26" valign="bottom" class="right-title">&nbsp;&nbsp;<span> 对比表单域</span></td>
  </tr>
  <tr> 
    <td valign="top" bgcolor="#EFEFEF">
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
        <tr>
          <td width="48%" bgcolor="#E9D1D1"><strong>原来的表单域</strong></td>
          <td width="1%" rowspan="2">&nbsp;</td>
          <td width="51%" bgcolor="#E9D1D1"><strong>新的表单域</strong></td>
        </tr>
        <tr>
          <td valign="top">
<%
Iterator ir = fd.getFields().iterator();
while (ir.hasNext()) {
	FormField ff = (FormField)ir.next();
%>
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="25%" height="24">
				<%
				// 检查是否将被删除
				boolean isDel = false;
				for (int i=0; i<dellen; i++) {
					FormField fld = (FormField)delv.get(i);
					if (fld.getName().equals(ff.getName())) {
						isDel = true;
						break;
					}
				}
				%>
				<%if (isDel) {%>
					<font color=red><%=ff.getName()%></font>
				<%}else{%>
					<%=ff.getName()%>
				<%}%>				
				</td>
                <td width="39%">
				<%if (isDel) {%>
					<font color=red><%=ff.getTitle()%></font>
				<%}else{%>
					<%=ff.getTitle()%>
				<%}%>				
				</td>
                <td width="36%">
				<%if (isDel) {%>
					<font color=red><%=ff.getTypeDesc()%></font>
				<%}else{%>
					<%=ff.getTypeDesc()%>
				<%}%>				
				</td>
              </tr>
            </table>
          <%}%></td>
          <td width="51%" valign="top">
<%
// 解析content，在表form_field中建立相应的域
ir = newv.iterator();
while (ir.hasNext()) {
	FormField ff = (FormField)ir.next();
%>
            <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="25%" height="24">
				<%
				// 检查是否将被增加
				boolean isAdd = false;
				for (int i=0; i<addlen; i++) {
					FormField fld = (FormField)addv.get(i);
					if (fld.getName().equals(ff.getName())) {
						isAdd = true;
						break;
					}
				}
				%>
				<%if (isAdd) {%>
					<font color=blue><%=ff.getName()%></font>
				<%}else{%>
					<%=ff.getName()%>
				<%}%>				
				</td>
                <td width="39%">
				<%if (isAdd) {%>
					<font color=blue><%=ff.getTitle()%></font>
				<%}else{%>
					<%=ff.getTitle()%>
				<%}%>				
				</td>
                <td width="36%">
				<%if (isAdd) {%>
					<font color=blue><%=ff.getTypeDesc()%></font>
				<%}else{%>
					<%=ff.getTypeDesc()%>
				<%}%>				
				</td>
              </tr>
            </table>
          <%}%></td>
        </tr>
        <tr>
          <td height="30" colspan="3" align="center">
		  <input type="hidden" name="code" value="<%=code%>">
		  <input type="hidden" name="name" value="<%=name%>">
		  <input type="hidden" name="flowTypeCode" value="<%=flowTypeCode%>">
		  <input type="hidden" name="content" value="">
		  <input type="submit" name="Submit" value="   确     定   ">
		  <br>
		  (红色表示将被删除的字段，蓝色表示将被添加的字段)</td>
        </tr>
      </table>
    </td>
  </tr>
  </form>
</table>
<br>
<br>
<table width="90%" align="center">
  <tr>
    <td><strong>以下为表单内容：</strong></td>
  </tr>
  <tr>
    <td><div id="divContent" name="divContent"> <%=content%></div></td>
  </tr>
</table>
</body>
</html>
