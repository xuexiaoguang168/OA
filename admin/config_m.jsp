<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.jdom.*"%>
<%@ include file="../inc/inc.jsp" %>
<%@ include file="../inc/nocache.jsp" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>配置管理</title>
<%@ include file="../inc/nocache.jsp" %>
<link rel="stylesheet" href="../common.css">
<script language="JavaScript">
<!--
function validate()
{
	if  (document.addform.name.value=="")
	{
		alert("新加类别不能为空");
		document.addform.name.focus();
		return false ;
	}
}

function checkdel(frm)
{
 if(!confirm("你是否确认删除该类别？"))
	 return;
 frm.op.value="del";
 frm.submit();
}
//-->
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<body bgcolor="#FFFFFF" topmargin='5' leftmargin='0'>
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<jsp:useBean id="myconfig" scope="page" class="com.redmoon.oa.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr> 
    <td width="100%" height="23" class="right-title">&nbsp;配 
      置 管 理</td>
  </tr>
  <tr> 
    <td valign="top" bgcolor="#FFFFFF">
<%
Element root = myconfig.getRootElement();

String name="",value = "";

name = request.getParameter("name");
if (name!=null && !name.equals(""))
{
	value = ParamUtil.get(request, "value");
	myconfig.put(name,value);
	out.println(fchar.Alert_Redirect("更改成功！", "config_m.jsp"));
}

int k = 0;
Iterator ir = root.getChild("oa").getChildren().iterator();
String desc = "";
%>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
<%
while (ir.hasNext()) {
  Element e = (Element)ir.next();
  desc = e.getAttributeValue("desc");
  name = e.getName();
  value = e.getValue();
%>
        <FORM METHOD=POST id="form<%=k%>" name="form<%=k%>" ACTION='config_m.jsp'>
          <tr> 
            <td bgcolor=#F6F6F6 width='52%'> <INPUT TYPE=hidden name=name value="<%=name%>"> 
              &nbsp;<%=myconfig.getDescription(name)%> 
            <td bgcolor=#F6F6F6 width='34%'> 
			<%if (value.equals("true") || value.equals("false")) {%>
				<select name="value" width=10>
				<option value="true">是</option>
				<option value="false">否</option>
				</select>
				<script>
				form<%=k%>.value.value = "<%=value%>";
				</script>
			<%}else{%>
				<input type=text value="<%=value%>" name="value" style='border:1pt solid #636563;font-size:9pt' size=30>
            <%}%>
			<td width="14%" align=center bgcolor=#F6F6F6> <INPUT TYPE=submit name='edit' value='修改'>            </td>
          </tr>
        </FORM>
<%
  k++;
}
%>	
      </table>
	</td>
  </tr>
</table> 
</body>                                        
</html>                            
  