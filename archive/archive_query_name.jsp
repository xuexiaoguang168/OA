<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.archive.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户档案查询</title>
<script language="javascript" type="text/javascript">
function form1_onsubmit() {
	if (form1.queryName.value=="") {
		alert("请填写查询名称！");
		return false;
	}
}
</script>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
</head>

<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "archive.query")) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<br>
<%
String deptCodeStr = ParamUtil.get(request,"deptCodeStr");
if(deptCodeStr.equals("")){
   out.print(StrUtil.Alert_Back("请选择查询部门！"));
   return;
}
String showFieldCodeStr = ParamUtil.get(request,"showFieldCodeStr");
String tableFullCodeStr = ParamUtil.get(request,"tableFullCodeStr");
String conditionFieldCodeStr = ParamUtil.get(request,"conditionFieldCodeStr");

String orderFieldCodeStr = "";
String[] fieldCodeArr = ParamUtil.getParameters(request,"fieldCode");
 
int i = 0;
while(i < fieldCodeArr.length){
	if(!fieldCodeArr[i].equals("")){
		if(orderFieldCodeStr.equals(""))
			orderFieldCodeStr += fieldCodeArr[i]; 
		else
			orderFieldCodeStr += "," + fieldCodeArr[i];
	}
	i++;
}
%>
<form name="form1" method="post" action="archive_query_do.jsp" onsumbit="return form1_onsubmit()">
  <table width="95%" border="0">
    <tr>
      <td>
      <table class="tableframe" cellSpacing="0" cellPadding="2" width="95%" align="center" border="0" bgcolor="#FFFFFF">
        <tbody>
          <tr>
            <td colspan="3" class="right-title">&nbsp;填写查询名称<input name="op" value="add" type="hidden"></td>
          </tr>
          <tr>
            <td width="10%" noWrap>查询名称：</td>         
			<td width="90%" noWrap><input type="text" name="queryName"></td>
          </tr>
        </tbody>
      </table>
      </td>
    </tr>  
    <tr>
      <td align="center"><input value="保存查询" type="submit" onClick="return form1_onsubmit()">
	    <input type="hidden" name="deptCodeStr" value="<%=deptCodeStr%>">
        <input type="hidden" name="showFieldCodeStr" value="<%=showFieldCodeStr%>">
		<input type="hidden" name="tableFullCodeStr" value="<%=tableFullCodeStr%>">
		<input type="hidden" name="orderFieldCodeStr" value="<%=orderFieldCodeStr%>"> 
		<input type="hidden" name="conditionFieldCodeStr" value="<%=conditionFieldCodeStr%>">
	  </td>
    </tr>
  </table>
</form>
</body>
</html>
