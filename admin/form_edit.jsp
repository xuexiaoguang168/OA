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

function setFormContent(c) {
	divContent.innerHTML = c;
}

function form1_onsubmit() {
	form1.content.value = getFormContent();
}

function openFormWin() {
	var preWin=window.open('../editor_full/flow_form.jsp?op=edit','','left=0,top=0,width=750,height=482,resizable=1,scrollbars=1, status=1, toolbar=0, menubar=0');
}
</script>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.flow")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String code = ParamUtil.get(request, "code");
FormDb fd = new FormDb();
fd = fd.getFormDb(code);
if (fd==null || !fd.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "类型" + code + "不存在！"));
	return;
}
		
String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	FormMgr ftm = new FormMgr();
	boolean re = false;
	try {
		re = ftm.modify(request);
		fd = fd.getFormDb(code);
		if (re) {
			out.print(StrUtil.Alert("编辑成功！"));
		}
		else {
			out.print(StrUtil.Alert("编辑失败！请检查是否有重复的编码或者编码使用了数据库的关键字！"));
		}
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}

}		
%>
<table width="622" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="26" valign="bottom" class="right-title">&nbsp;&nbsp;<span> 编辑表单</span></td>
  </tr>
  <tr> 
    <td valign="top" bgcolor="#FFFFFF">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<form action="form_edit_compare.jsp" id="form1" name="form1" method=post onSubmit="return form1_onsubmit()">
      <tr>
        <td height="84" align="center" class="p14">
		<table width="98%"  border="0" cellpadding="5" cellspacing="0" class="p14">
          <tr>
            <td width="16%" >编码 </td>
            <td width="84%" ><input type="text" name="code" value="<%=fd.getCode()%>" readonly></td>
          </tr>
          <tr>
            <td >名称</td>
            <td ><input type="text" name="name" value="<%=fd.getName()%>">
              <input type="hidden" name="content" value=''></td>
          </tr>
          <tr>
            <td >流程类型</td>
            <td ><select name="flowTypeCode" onChange="if(this.options[this.selectedIndex].value=='root'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); return false;}">
			<option value="-1">无</option> <!---1表示非流程所用的表单-->
<%
				Leaf rootlf = new Leaf();
				rootlf = rootlf.getLeaf("root");
				DirectoryView dv = new DirectoryView(rootlf);
				dv.ShowFlowTypeAsOptionsWithCode(out, rootlf, rootlf.getLayer());
%>
				</select>
				<script>
				form1.flowTypeCode.value = "<%=fd.getFlowTypeCode()%>";
				</script>
</td>
          </tr>
        </table>
          <br></td>
      </tr>
      <tr>
        <td align="center"><span class="p14">
          <input type="button" name="next2" value="编辑表单" onClick="openFormWin()">
        </span>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="submit" name="next" value=" 提 交 "></td></tr></form>
    </table>
	<table width="90%" align="center">
	  <tr>
	    <td><strong>以下为表单内容：</strong></td>
	    </tr>
	  <tr><td>
	  <div id="divContent" name="divContent">
	  <%=fd.getContent()%></div>
    </td></tr></table>	</td>
  </tr>
</table>
<br>
<br>
</body>
</html>
