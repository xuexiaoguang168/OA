<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<%
String isFlow = ParamUtil.get(request, "isFlow");	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>表单管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function presskey(eventobject)
{
	if(event.ctrlKey && window.event.keyCode==13)
	{
		<%if (isFlow.equals("")) {%>
			window.location.href="?isFlow=0";
		<%}else{%>
			window.location.href="?";
		<%}%>
	}
}

document.onkeydown = presskey;
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "admin")) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
		
String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	FormMgr ftm = new FormMgr();
	boolean re = false;
	try {
		re = ftm.del(request);
		if (re) {
			out.print(StrUtil.Alert("删除成功！"));
		}
		else {
			out.print(StrUtil.Alert("删除失败！"));
		}
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}		

String flowTypeCode = ParamUtil.get(request, "flowTypeCode");
String flowTypeName = "";
if (!flowTypeCode.equals("")) {
	Leaf flf = new Leaf();
	flf = flf.getLeaf(flowTypeCode);
	flowTypeName = flf.getName();
	
	LeafPriv lp = new LeafPriv(flowTypeCode);
	if (!(lp.canUserSee(privilege.getUser(request)))) {
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}	
}
%>
<table width="98%" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">&nbsp;&nbsp; 
	<%
	if (isFlow.equals("0"))
		out.print("模块");
	else
		out.print(flowTypeName);
	%>表单管理</td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
        <td height="28" align="center" bgcolor="#E7E7E7"><a href="form_add.jsp?flowTypeCode=<%=StrUtil.UrlEncode(flowTypeCode)%>">增加表单</a></td>
	    </tr>
	<form action="?" method=post>
      <tr>
        <td height="100" align="center" bgcolor="#E7E7E7" class="p14"><table width="93%" cellpadding="0" cellspacing="1">
          <tr>
            <td width="12%" height="25" align="center" bgcolor="#5286BD" ><span class="STYLE3">编码</span></td>
            <td width="28%" height="25" align="center" bgcolor="#5286BD" ><span class="STYLE3">名称</span></td>
            <td width="24%" align="center" bgcolor="#5286BD" class="STYLE3" >表格名称</td>
            <td width="22%" align="center" bgcolor="#5286BD" class="STYLE3" >流程类型</td>
            <td width="14%" height="25" align="center" bgcolor="#5286BD" ><span class="STYLE3">操作</span></td>
          </tr>
        </table>
		<%
		FormDb ftd = new FormDb();
		String sql = "";
		if (isFlow.equals("0"))
			sql = "select code from " + ftd.getTableName() + " where isFlow=0 order by orders asc";	
		else {
			if (!flowTypeCode.equals(""))
				sql = "select code from " + ftd.getTableName() + " where flowTypeCode=" + StrUtil.sqlstr(flowTypeCode) + " and isFlow=1 order by orders asc";
			else
				sql = "select code from " + ftd.getTableName() + " where isFlow=1 order by orders asc";
		}
		Iterator ir = ftd.list(sql).iterator();
		Directory dir = new Directory();
		while (ir.hasNext()) {
			ftd = (FormDb) ir.next();
		%>
		<table width="93%"  border="0" cellpadding="5" cellspacing="1" class="p14">
            <tr>
              <td width="12%" bgcolor="#FFFFFF" ><%=ftd.getCode()%>                </td>
              <td width="28%" bgcolor="#FFFFFF" ><%=ftd.getName()%></td>
              <td width="24%" bgcolor="#FFFFFF" ><%=ftd.getTableNameByForm()%></td>
              <td width="22%" bgcolor="#FFFFFF" >
			  <%
			  Leaf lf = dir.getLeaf(ftd.getFlowTypeCode());
			  if (lf!=null)
			  	out.print(lf.getName());
			  %>			  </td>
              <td width="14%" align="center" bgcolor="#FFFFFF" >
			  <%if (!ftd.isSystem() || ftd.isSystem()) {%>
			  <a href="form_edit.jsp?code=<%=ftd.getCode()%>">修改</a>
			  &nbsp;&nbsp;<a href="#" onClick="if (window.confirm('您确定要删除<%=ftd.getName()%>类型吗？')) window.location.href='form_m.jsp?op=del&code=<%=StrUtil.UrlEncode(ftd.getCode())%>'">删除</a>
			  <%}%>			  </td>
            </tr>
         </table>
		 <%}%>
          <br>          </td>
      </tr></form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
