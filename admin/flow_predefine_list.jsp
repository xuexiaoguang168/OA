<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../common.css">
<title>预定义流程列表</title>
<script>
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
</script>
<style type="text/css">
<!--
.STYLE3 {color: #FFFFFF}
-->
</style>
</head>
<body>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "admin.flow";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String dirCode = ParamUtil.get(request, "dirCode");
if (dirCode.equals("")) {
	out.print(StrUtil.p_center("请选择流程类型！"));
	return;
}
Leaf lf = new Leaf();
lf = lf.getLeaf(dirCode);
if (lf==null || !lf.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "节点不存在！"));
	return;
}

// 如果是分类节点，则重定向至表单处理页面
if (lf.getType()==lf.TYPE_NONE) {
	response.sendRedirect("form_m.jsp?flowTypeCode=" + StrUtil.UrlEncode(lf.getCode()));
	return;
}

LeafPriv lp = new LeafPriv(dirCode);
if (!(lp.canUserSee(privilege.getUser(request)))) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

WorkflowPredefineDb fd = new WorkflowPredefineDb();
		
String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	WorkflowPredefineMgr ftm = new WorkflowPredefineMgr();
	boolean re = false;
	try {
		re = ftm.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert("删除成功！"));
	}
	else {
		out.print(StrUtil.Alert("删除失败！"));
	}
}		

if (op.equals("setDefault")) {
	int id = ParamUtil.getInt(request, "id");
	fd = fd.getWorkflowPredefineDb(id);
	fd.setDefaultFlow(true);
	if (fd.save())
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}
%>
<table width="646" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td height="23" class="right-title">&nbsp;&nbsp;<%=lf.getName()%>&nbsp;预定义流程管理</td>
  </tr>
  <tr>
    <td valign="top"><table width="100%"  border="0" cellspacing="0" cellpadding="0">
      <form action="?" method="post">
        <tr>
          <td height="100" align="center" class="p14"><br />
                <table width="98%" cellpadding="0" cellspacing="1">
                  <tr>
                    <td width="11%" height="25" align="center" bgcolor="#5286BD" ><span class="STYLE3">默认</span></td>
                    <td width="36%" align="center" bgcolor="#5286BD" ><span class="STYLE3">名称</span></td>
                    <td width="31%" align="center" bgcolor="#5286BD" class="STYLE3" >类别</td>
                    <td width="22%" height="25" align="center" bgcolor="#5286BD" ><span class="STYLE3">操作</span></td>
                  </tr>
              </table>
        <%
		WorkflowPredefineDb ftd = new WorkflowPredefineDb();
		String sql = "select id from flow_predefined where typeCode=" + StrUtil.sqlstr(dirCode);
		Iterator ir = ftd.list(sql).iterator();
		Directory dir = new Directory();
		while (ir.hasNext()) {
			ftd = (WorkflowPredefineDb) ir.next();
		%>
                <table width="98%"  border="0" cellpadding="5" cellspacing="1" class="p14">
                  <tr>
                    <td width="11%" align="center" bgcolor="#F9F9F9" ><input type="checkbox" name="isDefault" value="true" onclick="setDefault(this, '<%=ftd.getId()%>', '<%=dirCode%>')" <%=ftd.isDefaultFlow()?"checked":""%>/></td>
                    <td width="36%" bgcolor="#F9F9F9" ><%=ftd.getTitle()%></td>
                    <td width="31%" bgcolor="#F9F9F9" ><%=dir.getLeaf(ftd.getTypeCode()).getName()%></td>
                    <td width="22%" align="center" bgcolor="#F9F9F9" ><a href="flow_predefine_init.jsp?op=edit&id=<%=ftd.getId()%>">修改</a>&nbsp;&nbsp;<a href="#" onclick="if (window.confirm('您确定要删除类型吗？')) window.location.href='flow_predefine_list.jsp?op=del&dirCode=<%=StrUtil.UrlEncode(dirCode)%>&id=<%=ftd.getId()%>'">删除</a></td>
                  </tr>
              </table>
        <%}%>
                <br />
          </td>
        </tr>
        <tr>
          <td align="center"><a href="flow_predefine_init.jsp?flowTypeCode=<%=StrUtil.UrlEncode(dirCode)%>">增加预定义流程</a></td>
        </tr>
      </form>
    </table></td>
  </tr>
</table>
<br />
<br />
</body>
<script>
function setDefault(chkObj, id, typeCode) {
	if (!chkObj.checked) {
		alert("请选择您需要置为默认的预定义流程！");
		chkObj.checked = true;
	}
	if (chkObj.checked) {
		window.location.href = "flow_predefine_list.jsp?op=setDefault&id=" + id + "&dirCode=" + typeCode;
	}
}
</script>
</html>
