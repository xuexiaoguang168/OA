<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<%@ page import="cn.js.fan.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改流程</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
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
		String priv="read";
		if (!privilege.isUserPrivValid(request, priv))
		{
			out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
		
		int flow_id = ParamUtil.getInt(request, "flowId");
		WorkflowMgr wfm = new WorkflowMgr();
		WorkflowDb wf = wfm.getWorkflowDb(flow_id);
%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td height="23" class="right-title">&nbsp;  修改流程名称</td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<form id=form1 name="form1" action="flow_modify1_do.jsp" method=post>
      <tr>
        <td height="100" align="center" class="p14"><table width="63%" height="81"  border="0" cellpadding="0" cellspacing="0" class="p14">
            <tr>
              <td class="p14">
			  	流程类型
				<%
				Leaf lf = new Leaf();
				lf = lf.getLeaf(wf.getTypeCode());
				%>
				<%=lf.getName()%>
				<input type="hidden" name="typeCode" value="<%=wf.getTypeCode()%>">
				<input type=hidden name=flowId value="<%=flow_id%>">				</td>
            </tr>
            <tr>
              <td class="p14">流程名称：
                <input type="text" name="title" value="<%=wf.getTitle()%>" style="width:200px"></td>
            </tr>
          </table>
          <br>          </td>
      </tr>
      <tr>
        <td height="30" align="center"><input type="button" value=" 后 退 " onClick="window.location.href='flow_modify.jsp?flowId=<%=flow_id%>'"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="next" value=" 确 定 ">          </td>
      </tr></form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
