<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.basic.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<%@ page import="com.redmoon.oa.flow.*" %>
<%@ page import="com.redmoon.oa.flow.strategy.*" %>
<HTML><HEAD><TITLE>流程连接属性</TITLE>
<link href="../common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String conditionType = ParamUtil.get(request, "conditionType");
%>
<script src="../inc/common.js"></script>
<script language="JavaScript">
function openWin(url,width,height)
{
	var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function ClearCond() {
	if (confirm("您确定要清除条件么？")) {
		window.opener.SetSelectedLinkProperty("title", "");	
		window.opener.SetSelectedLinkProperty("desc", "");	
		window.close();
	}
}

function ModifyLink() {
	window.opener.SetSelectedLinkProperty("conditionType", conditionType.value);
	window.opener.SetSelectedLinkProperty("desc", desc.value);
	var t = "";
	if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_FORM%>") {
		t = fields.value + compare.value + condValue.value;
	}
	else if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_DEPT%>") {
		t = depts.value;
	}
	window.opener.SetSelectedLinkProperty("title", t);	
	window.close();
}

function window_onload() {
	var t = window.opener.GetSelectedLinkProperty("title");
	rawTitle.innerHTML = t;
	desc.value = window.opener.GetSelectedLinkProperty("desc");
	conditionType.value = window.opener.GetSelectedLinkProperty("conditionType");
	conditionType_onchange();
	if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_FORM%>") {
		if (t=="")
			return;
		if (t.indexOf(">=")!=-1)
			compare.value = ">=";
		else if (t.indexOf("<=")!=-1)
			compare.value = "<=";
		else if (t.indexOf(">")!=-1)
			compare.value = ">";
		else if (t.indexOf("<")!=-1)
			compare.value = "<";
		else if (t.indexOf("=")!=-1)
			compare.value = "=";
		var ary = t.split(compare.value);
		fields.value = ary[0];
		condValue.value = ary[1];
	}
	else if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_DEPT%>") {
		depts.value = t;
	}	
}

function conditionType_onchange() {
	if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_FORM%>") {
		deptNames.disabled = true;
		deptAddBtn.disabled = true;
		deptClearBtn.disabled = true;
		compare.disabled = false;
		condValue.disabled = false;
		fields.disabled = false;
	}
	else if (conditionType.value=="<%=WorkflowLinkDb.COND_TYPE_DEPT%>") {
		compare.disabled = true;
		condValue.disabled = true;
		fields.disabled = true;
		deptNames.disabled = false;		
		deptAddBtn.disabled = false;
		deptClearBtn.disabled = false;
	}
}

function getDepts() {
	return depts.value;
}

function openWinDepts() {
	var ret = showModalDialog('../dept_multi_sel.jsp',window.self,'dialogWidth:520px;dialogHeight:350px;status:no;help:no;')
	if (ret==null)
		return;
	deptNames.value = "";
	depts.value = "";
	for (var i=0; i<ret.length; i++) {
		if (deptNames.value=="") {
			depts.value += ret[i][0];
			deptNames.value += ret[i][1];
		}
		else {
			depts.value += "," + ret[i][0];
			deptNames.value += "," + ret[i][1];
		}
	}
	if (depts.value.indexOf("<%=DeptDb.ROOTCODE%>")!=-1) {
		depts.value = "<%=DeptDb.ROOTCODE%>";
		deptNames.value = "全部";
	}
}
</script>
<META content="Microsoft FrontPage 4.0" name=GENERATOR><meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY leftMargin=4 topMargin=8 rightMargin=0 class=menubar onLoad="window_onload()">
<table width="100%"  border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
  <tr>
    <td height="23" colspan="2" class="right-title">&nbsp;&nbsp;流程连接属性</td>
  </tr>
  <tr>
    <td height="22" align="center" bgcolor="#FFFFFF">描述</td>
    <td height="22" bgcolor="#FFFFFF"><input type="text" name="desc" style="width: 260px"></td>
  </tr>
  <tr>
    <td height="22" align="center" bgcolor="#FFFFFF">类型</td>
    <td height="22" align="left" bgcolor="#FFFFFF">
	<select name="conditionType" onChange="conditionType_onchange()">
	<option value="">根据表单</option>
	<option value="dept">根据上一节点处理人员所在的部门</option>
	</select>
	条件：&nbsp;(<span id="rawTitle"></span>)
	</td>
  </tr>
  <tr>
    <td width="90" height="22" align="center" bgcolor="#FFFFFF">表单</td>
    <td height="22" bgcolor="#FFFFFF">
<%
String flowTypeCode = ParamUtil.get(request, "flowTypeCode");
Leaf lf = new Leaf();
lf = lf.getLeaf(flowTypeCode);
FormDb fd = new FormDb();
fd = fd.getFormDb(lf.getFormCode());
Vector v = fd.getFields();
Iterator ir = v.iterator();
String options = "";
while (ir.hasNext()) {
	FormField ff = (FormField) ir.next();
	options += "<option value='" + ff.getName() + "'>" + ff.getTitle() + "</option>";
}
%>
<select name="fields">
<%=options%>
</select>	
	<select name="compare">
	<option value=">=">>=</option>
	<option value="<="><=</option>
	<option value=">">></option>
	<option value="<"><</option>
	<option value="=">=</option>
	</select>
	&nbsp;<input name="condValue">	</td>
  </tr>
  <tr>
    <td height="22" align="center" bgcolor="#FFFFFF">部门</td>
    <td height="22" bgcolor="#FFFFFF"><textarea name="deptNames" cols="45" rows="5" readOnly wrap="yes" id="deptNames"><%
			  String depts = "";
			  if (conditionType.equals(WorkflowLinkDb.COND_TYPE_DEPT)) {
				  depts = ParamUtil.get(request, "title");
				  String[] arydepts = StrUtil.split(depts, ",");  	  
				  int len = 0;
				  String deptNames = "";
				  if (arydepts!=null) {
					len = arydepts.length;
					DeptDb dd = new DeptDb();
					for (int i=0; i<len; i++) {
						if (deptNames.equals("")) {
							dd = dd.getDeptDb(arydepts[i]);
							deptNames = dd.getName();
						}
						else {
							dd = dd.getDeptDb(arydepts[i]);
							deptNames += "," + dd.getName();
						}
					}
				  }		  
				  out.print(deptNames);
			  }
		  %>
		  </textarea>
      <input type="hidden" name="depts" value="<%=depts%>">	<span class="TableData">
      <input id=deptAddBtn title="添加部门" onClick="openWinDepts()" type="button" value="添 加" name="button">
      <input id=deptClearBtn title="清空部门" onClick="deptNames.value='';depts.value=''" type="button" value="清 空" name="button">
      <br>
      空表示除其它分支条件外的部门</span></td>
  </tr>  
  <tr align="center">
    <td height="28" colspan="2" bgcolor="#FFFFFF"><input name="okbtn" type="button" class="button1" onClick="ModifyLink()" value=" 确 定 ">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="okbtn2" type="button" class="button1" onClick="ClearCond()" value=" 清除条件 ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="cancelbtn" type="button" class="button1" onClick="window.close()" value=" 取 消 "></td>
  </tr>
</table>
</BODY></HTML>
