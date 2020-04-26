<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.plugin.entrance.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.treasure.*"%>
<%@ page import="com.redmoon.forum.plugin.base.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
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
<html><head>
<meta http-equiv="pragma" content="no-cache">
<link href="<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.forum.treasure" key="buy_treasure"/> - <%=Global.AppName%></title>
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
if (!privilege.isUserLogin(request)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_NOT_LOGIN)));
	return;
}
String code = ParamUtil.get(request, "code");
if (code.equals("")) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "res.label.forum.treasure", "need_code")));
	return;
}
TreasureMgr tmr = new TreasureMgr();
TreasureUnit tu = tmr.getTreasureUnit(code);

String userName = privilege.getUser(request);
String op = ParamUtil.get(request, "op");
if (op.equals("buy")) {
	  if (tu.getCount()<=0) {
	  	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "res.label.forum.treasure", "store_inadequate")));
		return;
	  }
	  String moneyCode = ParamUtil.get(request, "moneyCode");
	  Vector pricev = tu.getPrice();
	  Iterator pir = pricev.iterator();
	  ScoreMgr sm = new ScoreMgr();
	  while (pir.hasNext()) {
	  	TreasurePrice tp = (TreasurePrice)pir.next();
	  	double value = tp.getValue();
		TreasureUserDb tud = new TreasureUserDb();
		tud = tud.getTreasureUserDb(userName, code);

	  	ScoreUnit su = sm.getScoreUnit(tp.getScoreCode());
		
			// 检查用户的积分够不够
			// 原先已买过
			if (tud.isLoaded()) {
				IPluginScore ips = su.getScore();
				if (ips.pay(userName, ips.SELLER_SYSTEM, value)) {
					tud.setAmount(tud.getAmount() + 1);
					if (tud.save()) {
						tmr.setTreasureCount(code, tu.getCount() - 1);
						out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "res.label.forum.treasure", "buy_success"), "../usercenter.jsp"));
						return;
					}
				}
			}
			else {// 原先没买过
				tud.setUserName(userName);
				tud.setTreasureCode(code);
				tud.setAmount(1);
				if (tud.create()) {
				tmr.setTreasureCount(code, tu.getCount() - 1);
					out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "res.label.forum.treasure", "buy_success"), "../usercenter.jsp"));
					return;
				}
			}
	  }
}
%>
<br>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="center" class="thead"><span class="style1"><lt:Label res="res.label.forum.treasure" key="buy_treasure"/></span></td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <br>
      <table width="43%"  border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#EFEFEF">
        <tr>
          <td height="24" colspan="2" align="center" class="td_title"><font color=white><%=tu.getName()%></font></td>
        </tr>
        <tr align="center">
          <td height="22" colspan="2" bgcolor="#FFFFFF"><%=tu.getDesc()%></td>
        </tr>
        <tr>
          <td width="48%" height="130" rowspan="2" align="center" bgcolor="#FFFFFF"><img src="<%=tu.getImage()%>"> </td>
          <td width="52%" height="55" valign="top" bgcolor="#FFFFFF"><lt:Label res="res.label.forum.treasure" key="buy_point"/>
            <br>
              <%
			  Vector pricev = tu.getPrice();
			  Iterator pir = pricev.iterator();
			  ScoreMgr sm = new ScoreMgr();
			  while (pir.hasNext()) {
			  	TreasurePrice tp = (TreasurePrice)pir.next();
			  	ScoreUnit su = sm.getScoreUnit(tp.getScoreCode());
			  %>
              <lt:Label res="res.label.forum.treasure" key="use"/><%=su.getName()%>&nbsp;<%=tp.getValue()%>&nbsp;<a href="treasure_buy.jsp?op=buy&code=<%=StrUtil.UrlEncode(tu.getCode())%>&moneyCode=<%=StrUtil.UrlEncode(tp.getScoreCode())%>"><lt:Label res="res.label.forum.treasure" key="confirm_buy"/></a>
			  <%}%>			  
              <br>
          <lt:Label res="res.label.forum.treasure" key="day_count"/><%=tu.getDay()%> </td>
        </tr>
        <tr>
          <td height="22" bgcolor="#FFFFFF"><lt:Label res="res.label.forum.treasure" key="store_count"/><%=tu.getCount()%></td>
        </tr>
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
  