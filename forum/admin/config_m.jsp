<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.Enumeration"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="org.jdom.*"%>
<%@ include file="../inc/inc.jsp" %>
<%@ include file="../inc/nocache.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title><lt:Label res="res.label.forum.admin.config_m" key="forum_config"/></title>
<%@ include file="../inc/nocache.jsp" %>
<LINK href="images/default.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style><body bgcolor="#FFFFFF">
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<jsp:useBean id="myconfig" scope="page" class="com.redmoon.forum.Config"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isMasterLogin(request)) {
    out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

ForumDb fd = new ForumDb();
fd = fd.getForumDb();

String op = ParamUtil.get(request, "op");

if (op.equals("setShowLink")) {
	boolean isShowLink = ParamUtil.getBoolean(request, "isShowLink", false);
	boolean canGuestSeeTopic = ParamUtil.getBoolean(request, "canGuestSeeTopic", false);
	boolean canGuestSeeAttachment = ParamUtil.getBoolean(request, "canGuestSeeAttachment", false);
	String guestAction = canGuestSeeTopic?"1":"0";
	guestAction += canGuestSeeAttachment?"1":"0";
	fd.setShowLink(isShowLink);
	fd.setGuestAction(guestAction);
	if (fd.save())
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	else
		out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "info_op_fail")));
}

fd = ForumDb.getInstance();
%>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
    <TR>
      <TD class=head><lt:Label res="res.label.forum.admin.config_m" key="sys_config"/></TD>
    </TR>
  </TBODY>
</TABLE>
<br>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe" style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" >
  <tr> 
    <td width="100%" height="23" class="thead">&nbsp;<lt:Label res="res.label.forum.admin.config_m" key="forum_config"/></td>
  </tr>
  <tr> 
    <td valign="top" bgcolor="#FFFFFF"><table width="100%" border='0' align="center" cellpadding='0' cellspacing='0' class="tableframe_gray">
      <tr >
        <td width="100%" class="stable">    
      <tr>
        <FORM METHOD=POST ACTION="?op=setShowLink" name="form4">
          <td height="23" colspan=3 align="center" class="stable"><table width="100%" border="0" cellpadding="0" cellspacing="1">
              <tr>
                <td height="22" bgcolor="#F6F6F6"><input type="checkbox" name="isShowLink" value="true" <%=fd.isShowLink()?"checked":""%>>
                    <lt:Label res="res.label.forum.admin.forum_m" key="show_link"/>
                    <input type="checkbox" name="canGuestSeeTopic" value="true" <%=fd.canGuestSeeTopic()?"checked":""%>>
                    <lt:Label res="res.label.forum.admin.forum_m" key="guest_can_view_topic"/>
                    <input type="checkbox" name="canGuestSeeAttachment" value="true" <%=fd.canGuestSeeAttachment()?"checked":""%>>
                    <lt:Label res="res.label.forum.admin.forum_m" key="guest_can_download_attach"/></td>
                <td width="14%" align="center" bgcolor="#F6F6F6"><input name="submit" type="submit" value="<lt:Label key="ok"/>"></td>
              </tr>
          </table></td>
        </FORM>
      </tr>
    </TABLE>
      <%
Element root = myconfig.getRootElement();

if (op.equals("setDefaultSkin")) {
	SkinMgr sm = new SkinMgr();
	String defaultSkinCode = ParamUtil.get(request, "defaultSkinCode");
	sm.setDefaultSkin(defaultSkinCode);
	out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
}

String name="",value = "";
name = request.getParameter("name");
if (name!=null && !name.equals(""))
{
	value = ParamUtil.get(request, "value");
	myconfig.put(name,value);
	out.println(fchar.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "config_m.jsp"));
	ForumSchedulerUnit.initParam();
	com.redmoon.forum.MsgDb.initParam();
	ForumPage.init();
}

int k = 0;
Iterator ir = root.getChild("forum").getChildren().iterator();
String desc = "";
while (ir.hasNext()) {
  Element e = (Element)ir.next();
  desc = e.getAttributeValue("desc");
  name = e.getName();
  value = e.getValue();
%>
      <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1">
        <FORM METHOD=POST id="form<%=k%>" name="form<%=k%>" ACTION='config_m.jsp'>
          <tr> 
            <td bgcolor=#F6F6F6 width='52%'> <INPUT TYPE=hidden name=name value="<%=name%>"> 
              &nbsp;<%=myconfig.getDescription(request, name)%> 
            <td bgcolor=#F6F6F6 width='34%'>
			<%
			if (name.equals("waterMarkPos")) {%>
			<select name="value">
			<option value="<%=cn.js.fan.util.file.image.WaterMarkUtil.POS_LEFT_TOP%>"><lt:Label res="res.label.forum.admin.config_m" key="left_top"/></option>
			<option value="<%=cn.js.fan.util.file.image.WaterMarkUtil.POS_LEFT_BOTTOM%>"><lt:Label res="res.label.forum.admin.config_m" key="left_bottom"/></option>
			<option value="<%=cn.js.fan.util.file.image.WaterMarkUtil.POS_RIGHT_TOP%>"><lt:Label res="res.label.forum.admin.config_m" key="right_top"/></option>
			<option value="<%=cn.js.fan.util.file.image.WaterMarkUtil.POS_RIGHT_BOTTOM%>"><lt:Label res="res.label.forum.admin.config_m" key="right_bottom"/></option>
			</select>
			<script>
			form<%=k%>.value.value = "<%=value%>";
			</script>
			<%}
			else if (value.equals("true") || value.equals("false")) {%>
				<select name="value"><option value="true"><lt:Label key="yes"/></option><option value="false"><lt:Label key="no"/></option></select>
				<script>
				form<%=k%>.value.value = "<%=value%>";
				</script>
			<%}else if(name.equals("userLevel")){%>
			<select name="value">
			<option value="levelCredit">信用值</option>
			<option value="levelExperience">经验值</option>
			<option value="levelGold">金币</option>
			<option value="levelTopticCount">最少发贴</option>
			</select>
			<script>
			form<%=k%>.value.value = "<%=value%>";
			</script>
			<%}else{%>
				<input type=text value="<%=value%>" name="value" style='border:1pt solid #636563;font-size:9pt' size=30>
            <%}%>
			<td width="14%" align=center bgcolor=#F6F6F6> <INPUT TYPE=submit name='edit' value='<lt:Label key="op_modify"/>'>            </td>
          </tr>
        </FORM>
      </table>
<%
  k++;
}
%>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1">
  <FORM METHOD=POST id="form_skin" name="form_skin" ACTION='config_m.jsp?op=setDefaultSkin'>
    <tr>
      <td bgcolor=#F6F6F6 width='52%'>&nbsp;<%=myconfig.getDescription(request, "default_skin")%>
      <td bgcolor=#F6F6F6 width='34%'>
      <%
	  String opt = "";
	  SkinMgr sm = new SkinMgr();
	  Iterator irskin = sm.getAllSkin().iterator();
	  while (irskin.hasNext()) {
	  	Skin sk = (Skin)irskin.next();
		String d = "";
		if (sk.isDefaultSkin())
			d = "selected";
		opt += "<option value=" + sk.getCode() + " " + d + ">" + sk.getName() + "</option>";
	  }
	  %>
	  <select name="defaultSkinCode">
	  <%=opt%>
	  </select>
	  </td>
      <td width="14%" align=center bgcolor=#F6F6F6><INPUT TYPE=submit name='edit2' value='<lt:Label key="op_modify"/>'>
      </td>
    </tr>
  </FORM>
</table></td>
  </tr>
  <tr class=row style="BACKGROUND-COLOR: #fafafa">
    <td valign="top" bgcolor="#FFFFFF" class="thead">&nbsp;</td>
  </tr>
</table> 
</body>                                       
</html>