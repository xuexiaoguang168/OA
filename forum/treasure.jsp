<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.entrance.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
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

//seo
com.redmoon.forum.util.SeoConfig scfg = new com.redmoon.forum.util.SeoConfig();
String seoTitle = scfg.getProperty("seotitle");
String seoKeywords = scfg.getProperty("seokeywords");
String seoDescription = scfg.getProperty("seodescription");
String seoHead = scfg.getProperty("seohead");
%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<title><lt:Label res="res.label.forum.treasure" key="treasure"/> - <%=Global.AppName%> <%=seoTitle%></title>
<%=seoHead%>
<META name="keywords" content="<%=seoKeywords%>">
<META name="description" content="<%=seoDescription%>">
<meta http-equiv="pragma" content="no-cache">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<script language="JavaScript">
<!--

//-->
</script>
<style type="text/css">
<!--
.style1 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
String op = ParamUtil.get(request, "op");
%>
<br>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="center" class="thead"><span class="style1"><lt:Label res="res.label.forum.treasure" key="treasure"/></span></td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <br>
      <table width="92%"  border="0" align="center" cellpadding="0" cellspacing="0">
        <%
	TreasureMgr em = new TreasureMgr();
	Vector v = em.getAllTreasure();
	Iterator ir = v.iterator();
	TreasureUnit tu;
	int i = 0;
	while (ir.hasNext()) {
	%>
        <tr align="center">
          <td height="24">
            <%
			for (i=0; i<3; i++) {
				if (ir.hasNext()) {
					tu = (TreasureUnit)ir.next();
			%>
			<table width="32%"  border="1" align="left" cellpadding="1" cellspacing="0" bordercolor="<%=skin.getTableBorderClr()%>">
              <tr>
                <td height="24" colspan="2" align="center" class="td_title"><%=tu.getName()%></td>
              </tr>
              <tr align="center">
                <td height="22" colspan="2" bgcolor="#FFFFFF"><%=tu.getDesc()%></td>
              </tr>
              <tr>
                <td width="48%" height="130" rowspan="3" align="center" bgcolor="#FFFFFF">
				<img src="<%=tu.getImage()%>">
				</td>
              <td width="52%" height="55" valign="top" bgcolor="#FFFFFF">
			  <lt:Label res="res.label.forum.treasure" key="buy_point"/><br>
			  <%
			  Vector pricev = tu.getPrice();
			  Iterator pir = pricev.iterator();
			  ScoreMgr sm = new ScoreMgr();
			  while (pir.hasNext()) {
			  	TreasurePrice tp = (TreasurePrice)pir.next();
			  	ScoreUnit su = sm.getScoreUnit(tp.getScoreCode());
				out.print(su.getName() + "：" + tp.getValue());
			  } 
			  %>
              <br>
              <lt:Label res="res.label.forum.treasure" key="day_count"/><%=tu.getDay()%>
				</td>
              </tr>
              <tr>
                <td height="22" bgcolor="#FFFFFF"><lt:Label res="res.label.forum.treasure" key="store_count"/><%=tu.getCount()%></td>
              </tr>
              <tr>
                <td height="22" bgcolor="#FFFFFF">
					<a href="treasure_buy.jsp?code=<%=StrUtil.UrlEncode(tu.getCode())%>"><lt:Label res="res.label.forum.treasure" key="buy"/></a>
				<%if (tu.getCount()>0) {%>
				<%}%>
				</td>
              </tr>
            </table>
			<table width="1%"  border="0" align="left" cellpadding="1" cellspacing="1">
              <tr>
                <td>&nbsp;</td>
              </tr>
            </table>
			<%	}
				else
					break;
			}%>
		  </td>
        </tr>
		<tr><td height=5></td></tr>
    <%}%>
      </table></td>
  </tr>
</table>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table> 
 <%@ include file="inc/footer.jsp"%>                                       
</body>                                        
</html>                            
  