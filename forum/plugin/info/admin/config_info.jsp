<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.redmoon.forum.plugin.info.*"%>
<%@ page import="com.redmoon.kit.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%@ page import="java.io.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 cn.js.fan.web.*,
				 com.redmoon.forum.ui.*,
				 org.jdom.*,
                 java.util.*"
%>
<title><lt:Label res="res.label.forum.plugin.info.config_info" key="title"/></title>
<%@ include file="../../../inc/nocache.jsp" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<LINK href="../../../admin/images/default.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>
<body bgcolor="#FFFFFF">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head"><lt:Label res="res.label.forum.plugin.info.config_info" key="title"/></td>
  </tr>
</table>
<%
if (!privilege.isMasterLogin(request)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
int k = 0;
InfoConfig ic = new InfoConfig();
Element root = ic.getRoot();
String op = ParamUtil.get(request, "op");
if (op.equals("modify")) {
	String code = ParamUtil.get(request, "code");
	String name = ParamUtil.get(request, "name");
	ic.modify(code, name);
	out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "config_info.jsp"));
	return;
}

if(op.equals("add")) {
	String code = ParamUtil.get(request, "code");
	if (code.equals("")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.forum.plugin.info.config_info", "need_code")));
		return;
	}
	if (!StrUtil.isSimpleCode(code)) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "err_simple_code")));
		return;
	}
	String name = ParamUtil.get(request, "name");
	if (name.equals("")) {
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.forum.plugin.info.config_info", "need_name")));
		return;
	}
	ic.add(code, name);
	out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "config_info.jsp"));
	return;
}

if(op.equals("del")) {
	String code = ParamUtil.get(request, "code");
	ic.del(code);
	out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "config_info.jsp"));
	return;
}

String code="", name = "";
List list = root.getChild("alltype").getChildren();
if (list != null) {
	Iterator ir = list.iterator();
	while (ir.hasNext()) {
		 Element child = (Element) ir.next();
		 code = child.getAttributeValue("code");
		 name = child.getChildText("name");
%>
<table cellpadding="6" cellspacing="0" border="0" width="100%">
<tr>
<td width="99%" align="center" valign="top"><br>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
<FORM METHOD=POST id="form<%=k%>" name="form<%=k%>" ACTION="config_info.jsp?op=modify">
  <tr>
    <td colspan="3" class="thead"><%=name%><input type="hidden" name="code" value="<%=code%>"/></td>
    </tr>
  <tr>
    <td width="5%" bgcolor="#F6F6F6"><lt:Label res="res.label.forum.admin.config_theme" key="name"/></td>
    <td width="14%" bgcolor="#F6F6F6"><input type="input" name="name" value="<%=name%>"></td>
    <td width="81%" bgcolor="#F6F6F6"><input name="submit" type=submit value='<lt:Label key="op_modify"/>'>      &nbsp;&nbsp;
<input name="button" type=button onClick="del('<%=code%>')" value='<lt:Label res="res.label.forum.admin.config_theme" key="del"/>'></td>
  </tr>
</FORM> 
</table>
</td>
</tr>
</table>
	<%	
	k++;	 
   }%>   
<%}%>
<table cellpadding="6" cellspacing="0" border="0" width="100%">
<tr>
<td width="99%" align="center" valign="top"><FORM METHOD=POST id="form_add" name="form_add" ACTION='?op=add'>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
  <tr>
    <td colspan="2" class="thead"><lt:Label res="res.label.forum.admin.config_theme" key="add_topic"/></td>
    </tr>
  <tr>
    <td bgcolor="#F6F6F6"><lt:Label res="res.label.forum.admin.config_theme" key="code"/></td>
    <td bgcolor="#F6F6F6"><input type="text" name="code"></td>
  </tr>
  <tr>
    <td width="11%" bgcolor="#F6F6F6"><lt:Label res="res.label.forum.admin.config_theme" key="name"/></td>
    <td width="89%" bgcolor="#F6F6F6"><input type="text" name="name"></td>
  </tr>
  <tr>
    <td colspan="2" bgcolor="#F6F6F6"></td>
    </tr>
    <tr>
    <td></td>
    <td>
      <INPUT TYPE=submit value='<lt:Label key="op_add"/>'>    </td>
  </tr>
</table>
</FORM></td>
</tr>
</table>
<script>
  function del(code) {
	window.location.href='config_info.jsp?op=del&code=' + code;
  }
</script>
</body>
</html>
