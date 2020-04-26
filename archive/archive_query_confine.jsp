<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户档案查询</title>
<%@ include file="../inc/nocache.jsp"%>
<link href="../common.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-size: 14px}
#Layer1 {
	position:absolute;
	left:180px;
	top:55px;
	width:552px;
	height:20px;
	z-index:1;
}
#Layer2 {
	position:absolute;
	left:180px;
	top:82px;
	width:552px;
	height:26px;
	z-index:1;
}
#Layer3 {
	position:absolute;
	left:180px;
	top:107px;
	width:552px;
	height:23px;
	z-index:1;
}
#Layer4 {
	position:absolute;
	left:182px;
	top:132px;
	width:552px;
	height:23px;
	z-index:1;
}
#Layer5 {
	position:absolute;
	left:180px;
	top:157px;
	width:552px;
	height:23px;
	z-index:1;
}
#Layer6 {
	position:absolute;
	left:180px;
	top:182px;
	width:552px;
	height:23px;
	z-index:1;
}
#Layer7 {
	position:absolute;
	left:180px;
	top:207px;
	width:552px;
	height:23px;
	z-index:1;
}
#Layer8 {
	position:absolute;
	left:180px;
	top:232px;
	width:552px;
	height:23px;
	z-index:1;
}
-->
</style>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "archive.query")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String[] deptCodeArr = ParamUtil.getParameters(request,"deptCode");
if(deptCodeArr == null){
   out.print(StrUtil.Alert_Back("请选择查询部门！"));
   return;
}

String deptCodeStr = "";
int i = 0;
while(i < deptCodeArr.length){
	deptCodeStr += "'" + deptCodeArr[i] + "'";
	if(i < deptCodeArr.length -1){
		deptCodeStr += ",";
	}
	i++;
}
%>
<br>
<form name="form1" method="post" action="archive_query_showfieldcode.jsp">
  <table width="95%" border="0">
    <tr>
      <td><table class="tableframe" cellSpacing="1" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="2" noWrap class="right-title">选择查询范围</td>
          </tr>
<%
	String sql = "";
	sql = ArchiveSQLBuilder.getArchiveTable();
	int j = 1;
	TableInfoDb tid = new TableInfoDb();
	Vector vt = tid.list(sql);
	Iterator ir = null;
	ir = vt.iterator();	
	while (ir!=null && ir.hasNext()) {
		tid = (TableInfoDb)ir.next();
		TableFieldInfoDb tfid = new TableFieldInfoDb();
		sql = ArchiveSQLBuilder.getArchiveTableField(tid.getTableShortCode());   
		Vector vt_tfid = tfid.list(sql);
		Iterator ir_tfid = null;
		ir_tfid = vt_tfid.iterator();
%>
		<div id="Layer<%=j%>" style="display:none">
<%
		while (ir_tfid!=null && ir_tfid.hasNext()) {
			tfid = (TableFieldInfoDb)ir_tfid.next();
			out.print(tfid.getFieldName() + "    ");		
		}		
%>	
        </div>	  	  
          <tr id="<%=j%>" onMouseOver="Layer<%=j%>.style.display=''" onMouseOut="Layer<%=j%>.style.display='none'">
            <td width="6%" noWrap><%=tid.getTableDescription()%></td>
            <td>
			<%
			if (tid.getTableCode().equals("ARCHIVE_USER")) {%>
			<input type="checkbox" name="tableCode" value="<%=tid.getTableCode()%>" disabled checked>
			<input name="tableCode" type="hidden" value="<%=tid.getTableCode()%>">
			<%}
			else {
			%>
			<input type="checkbox" name="tableCode" value="<%=tid.getTableCode()%>">
			<%}%>选择该表
			</td>
          </tr>	
<%
		j++;
	}
%>	  
        </tbody>
      </table></td>
    </tr>  
    <tr>
      <td align="center"><input value="下一步 &#8594; 选择查询结果中将要显示的字段" type="submit">&nbsp;&nbsp;
        <input type="hidden" name="deptCodeStr" value="<%=deptCodeStr%>"></td>
    </tr>
  </table>
</form>
</body>
</html>
