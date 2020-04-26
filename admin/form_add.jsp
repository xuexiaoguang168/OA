<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>创建表单</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function setFormContent(htmlCode) {
	divContent.innerHTML = htmlCode;
}

function getFormContent() {
	return divContent.innerHTML;
}

function form1_onsubmit() {
	form1.content.value = getFormContent();
}

function openFormWin() {
	var preWin=window.open('../editor_full/flow_form.jsp?op=edit','','left=0,top=0,width=750,height=482,resizable=1,scrollbars=1, status=1, toolbar=0, menubar=0');
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin.flow")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String flowTypeCode = ParamUtil.get(request, "flowTypeCode");
		
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	FormMgr ftm = new FormMgr();
	boolean re = false;
	try {
		re = ftm.create(request);
		if (re) {
			if (!flowTypeCode.equals("-1"))
				out.print(StrUtil.Alert_Redirect("创建成功！", "form_m.jsp?flowTypeCode=" + StrUtil.UrlEncode(flowTypeCode)));
			else {
				out.print(StrUtil.Alert_Redirect("创建成功！", "form_m.jsp?isFlow=0"));
			}
		}
		else {
			out.print(StrUtil.Alert("创建失败！"));
		}
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage() + " 请检查是否有重复的编码或者编码使用了数据库的关键字！"));
	}
}		
%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" class="right-title">&nbsp;&nbsp;<span> 创建表单</span></td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="tableframe">
	<form id=form1 name=form1 action="?op=add" method=post onSubmit="return form1_onsubmit()">
      <tr>
        <td height="100" align="center" class="p14"><table width="98%"  border="0" cellpadding="5" cellspacing="0" class="p14">
          <tr>
            <td width="20%" >编码 </td>
            <td width="80%" ><input type="text" name="code" maxlength="18"></td>
          </tr>
          <tr>
            <td >名称</td>
            <td ><input type="text" name="name"></td>
          </tr>
          <tr>
            <td >流程类型</td>
            <td >
			<%
			// -1表示非流程所用的表单
			if (!flowTypeCode.equals("") && !flowTypeCode.equals("-1")) {
				Leaf lf = new Leaf();
				lf = lf.getLeaf(flowTypeCode);
			%>
				<%=lf.getName()%><input name="flowTypeCode" type="hidden" value="<%=flowTypeCode%>">
			<%} else {
			%>
			<select name="flowTypeCode" onChange="if(this.options[this.selectedIndex].value=='root'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); return false;}">
			<option value="-1">无</option>
                <%
				Leaf rootlf = new Leaf();
				rootlf = rootlf.getLeaf("root");
				DirectoryView dv = new DirectoryView(rootlf);
				dv.ShowFlowTypeAsOptionsWithCode(out, rootlf, rootlf.getLayer());
				%>
              </select>
			<%}%>
            </td>
          </tr>
          <tr>
            <td >内容</td>
            <td ><input type="hidden" name="content" value=''></td>
          </tr>
        </table>
            <a href="#" onClick="openFormWin()">编辑表单</a></td>
      </tr>
      <tr>
        <td align="center"><input type="submit" name="next" value="添加新的表单"></td>
      </tr>
      <tr>
        <td align="center"><table width="90%" align="center">
          <tr>
            <td><strong>以下为表单内容：</strong></td>
          </tr>
          <tr>
            <td><div id="divContent" name="divContent"></div></td>
          </tr>
        </table></td>
      </tr>
	</form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
