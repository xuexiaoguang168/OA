<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.workplan.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工作计划类型管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
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
String priv="read";
if (!privilege.isUserPrivValid(request, priv)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int id = ParamUtil.getInt(request, "id");
WorkPlanMgr wpm = new WorkPlanMgr();
WorkPlanDb wpd = null;
// 由这里来检查权限
try {
	wpd = wpm.getWorkPlanDb(request, id, "see");
}
catch (ErrMsgException e) {
	out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
	return;
}

String beginDate = DateUtil.format(wpd.getBeginDate(), "yyyy-MM-dd");
String endDate = DateUtil.format(wpd.getEndDate(), "yyyy-MM-dd");
%>
<%@ include file="workplan_inc_menu_top.jsp"%>
<br>
<table class="main" cellSpacing="1" cellPadding="2" width="600" align="center" border="0">
<form action="workplan_do.jsp?op=modify" name="form1" method="post" enctype="multipart/form-data">
  <tbody>
    <tr>
      <td colspan="2" noWrap class="right-title">&nbsp;查看计划</td>
    </tr>
    <tr>
      <td width="14%" noWrap class="TableContent">计划名称：</td>
      <td width="86%" class="TableData"><%=wpd.getTitle()%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划内容：</td>
      <td class="TableData"><%=wpd.getContent()%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>有效期：</td>
      <td class="TableData">开始日期：
           <%=beginDate%>
           <br>
        结束日期： 
        <%=endDate%></td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>计划类型：</td>
      <td class="TableData">
	  <%
	  WorkPlanTypeDb wptd = new WorkPlanTypeDb();
	  wptd = wptd.getWorkPlanTypeDb(wpd.getTypeId());
	  %>
	  <%=wptd.getName()%>	  </td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>发布范围（部门）：</td>
      <td class="TableData">
	  <%
	  String[] arydepts = wpd.getDepts();
	  String[] aryusers = wpd.getUsers();
	  String depts = "";
	  String deptNames = "";
	  String users = "";
	  
	  int len = 0;
	  if (arydepts!=null) {
	  	len = arydepts.length;
		DeptDb dd = new DeptDb();
	  	for (int i=0; i<len; i++) {
			if (depts.equals("")) {
				depts = arydepts[i];
				dd = dd.getDeptDb(arydepts[i]);
				deptNames = dd.getName();
			}
			else {
				depts += "," + arydepts[i];
				dd = dd.getDeptDb(arydepts[i]);
				deptNames += "," + dd.getName();
			}
		}
	  }
	  
	  if (aryusers!=null) {
	  	len = aryusers.length;
		DeptDb dd = new DeptDb();
	  	for (int i=0; i<len; i++) {
			if (users.equals("")) {
				users = aryusers[i];
			}
			else {
				users += "," + aryusers[i];
			}
		}
	  }
	  
	  %>
	  <%=deptNames%>
        &nbsp;</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>参与人：</td>
      <td class="TableData">
          <%=users%>
        &nbsp;</td>
    </tr>
    <tr>
      <td class="TableContent" noWrap>负责人：</td>
      <td class="TableData">
          <%=wpd.getPrincipal()%>
        &nbsp;&nbsp;</td>
    </tr>
    

    <tr>
      <td class="TableContent" noWrap>备注：</td>
      <td class="TableData"><%=wpd.getRemark()%></td>
    </tr>
    
    <tr class="TableControl" align="middle">
      <td colSpan="2" align="left" noWrap>
附件：
                      <%
					  java.util.Iterator attir = wpd.getAttachments().iterator();
					  while (attir.hasNext()) {
					  	Attachment att = (Attachment)attir.next();
					  %>
                        <li><img src="../images/attach.gif" width="17" height="17">&nbsp;<a target="_blank" href="workplan_getfile.jsp?workPlanId=<%=wpd.getId()%>&attachId=<%=att.getId()%>"><%=att.getName()%></a>&nbsp;&nbsp;&nbsp;<a href="workplan_do.jsp?op=delattach&workPlanId=<%=wpd.getId()%>&attachId=<%=att.getId()%>"></a></li>
                        <%}%>	  </td>
    </tr>
  </tbody>
  </form>
</table>
</body>
</html>
