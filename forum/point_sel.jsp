<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.score.*"%>
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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<title><lt:Label res="res.label.forum.point_sel" key="sel_point"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>
<script src="../inc/common.js"></script>
<script>
function selMoneyCode() {
   	var ary = new Array();
	ary[0] = getRadioValue("moneyCode");
	ary[1] = sum.value;
	if (ary[0]==null) {
		alert("<lt:Label res="res.label.forum.point_sel" key="sel_one_point"/>");
		return;
	}
	else {
		if (!isNumeric(sum.value)) {
			alert("<lt:Label res="res.label.forum.point_sel" key="err_num"/>");
			return;
		}
	}

	window.returnValue = ary;
	window.close();
}
</script>
</head>
<body>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<TABLE width="100%" 
border=0 align=center cellPadding=2 cellSpacing=1 bgcolor="#edeced">
<TBODY>
      <TR bgColor=#f8f8f8> 
        <TD height=23 colspan="2" align="center" class="td_title"><lt:Label res="res.label.forum.point_sel" key="select"/></TD>
      </TR>
<%	  
        ScoreMgr sm = new ScoreMgr();
        Vector v = sm.getAllScore();
        Iterator ir = v.iterator();
        String str = "";
        while (ir.hasNext()) {
            ScoreUnit su = (ScoreUnit) ir.next();
            if (su.isExchange()) {
%>
      <TR bgColor=#f8f8f8> 
        <TD width="2%" height=23 align="center"><input name="moneyCode" type="radio" value="<%=su.getCode()%>"></TD>
        <TD width="98%" align="left"><%=su.getName(request)%></TD>
      </TR>
<%	  
          }
      }
%>      
<TR bgColor=#f8f8f8>
  <TD height=23 colspan="2" align="center"><lt:Label res="res.label.forum.point_sel" key="sum"/>
    <input name="sum" size=6 value=""></TD>
</TR>
<TR bgColor=#f8f8f8>
        <TD height=23 colspan="2" align="center">
		<input type="button" value="<lt:Label key="ok"/>" onClick="selMoneyCode()">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="button" type="button" onClick="window.close()" value="<lt:Label key="cancel"/>"></TD>
      </TR>    </TBODY>
  </TABLE>
</body>
</html>
