<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
UserMgr um = new UserMgr();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.prision" key="bbs_prision"/> - <%=Global.AppName%></title>
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #e3f1fc;
}
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style></head>
<body>
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="prision" scope="page" class="com.redmoon.forum.life.prision.Prision"/>
<table cellSpacing="1" cellPadding="0" width="100%" border="0">
  <tbody>
    <tr>
      <td vAlign="top" align="center" bgColor="#ffffff" colSpan="2" height="1"></td>
    </tr>
    <tr>
      <td vAlign="top" align="center" bgColor="#e3f1fc" colSpan="2" height="354"><br>
        <br>
        <br>
        <table cellSpacing="1" cellPadding="12" width="308" bgColor="#65b5e0" border="0">
          <tbody>
            <tr bgColor="#cde9f3">
              <td align="middle" width="100%">
                <div align="center">
                  <center>
                  <table height="185" cellSpacing="0" cellPadding="6" width="208" bgColor="#cccccc" border="0">
                    <tbody>
                      <tr>
                        <td bgColor="#ffffff">
                          <table height="51" cellSpacing="4" cellPadding="0" width="217" bgColor="#f6f6f6" border="0">
                            <tbody>
                              <tr>
                                <td bgColor="#ffffff" height="77"><img src="images/prison/3.gif" width="286" height="89"></td>
                              </tr>
                              <tr>
                                <td align="left" bgColor="#ffffff" height="41"><p style="line-height:150%"> <lt:Label res="res.label.prision" key="police"/><br> 
                                  <%
								  String[][] ary = prision.getPolices();
								  if (ary!=null) {
								  	int len = ary.length;
									for (int i=0; i<len; i++) {
										out.println("<a href='userinfo.jsp?username="+ary[i][0]+"'>"+um.getUser(ary[i][0]).getNick()+"</a>&nbsp;");
									}
								  }
								  %> 
                                   <lt:Label res="res.label.prision" key="hello"/></p></td>
                              </tr>
                              <tr>
                                <td align="middle" bgColor="#ffffff" height="51"><a href="prision_arrest.jsp"><img src="images/prison/1.gif" border="0" name="Image7" oSrc="http://forum.xaonline.com/images/0-02.gif" width="173" height="35"></a></td>
                              </tr>
                              <tr>
                                <td align="middle" bgColor="#ffffff" height="51"><a href="prision_bail.jsp"><img src="images/prison/2.gif" border="0" name="Image6" oSrc="http://forum.xaonline.com/images/0-04.gif" width="173" height="35"></a></td>
                              </tr>
                            </tbody>
                          </table>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                  </center>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <br>
        <br>
        <br>
      </td>
    </tr>
  </tbody>
</table>
<jsp:include page="forum/inc/footer.jsp" />
</body>
</html>
