<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>删除留言</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../common.css" type="text/css">
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=3 marginheight="3" marginwidth="0">
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<!--重定向至 :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<%
String priv="admin";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String id = request.getParameter("id");
if (id==null)
{
	out.println(fchar.Alert_Redirect("未选择留言标识！","guestbookm.jsp"));
	return;
}
%>
<jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
<jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/>
<%
String sql = "delete from guestbook where id="+id;
int ret = conn.executeUpdate(sql);
conn.close();
if (ret>0)
{
	out.println(fchar.Alert_Redirect("删除留言成功！","guestbook_m.jsp"));
}
else
{
	out.println(fchar.Alert_Redirect("删除留言成功！","guestbookm.jsp"));
}
%>
</BODY></HTML>
