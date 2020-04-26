<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.plugin.auction.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.treasure.*"%>
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
<title><lt:Label res="res.label.forum.treasure" key="treasure_use"/> - <%=Global.AppName%></title>
<style type="text/css">
<!--
.style1 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
<body topmargin='0' leftmargin='0'>
<%@ include file="inc/header.jsp"%>
<jsp:useBean id="dir" scope="page" class="com.redmoon.forum.plugin.auction.Directory"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_NOT_LOGIN)));
	return;
}

String userName = privilege.getUser(request);

int id = 0;
try {
	id = ParamUtil.getInt(request, "id");
}
catch (ErrMsgException e) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("use")) {
	String code = ParamUtil.get(request, "code");
	try {
		TreasureMgr tmg = new TreasureMgr();
		if (tmg.use(request, userName, code, id))
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request, "info_op_success"), "showtopic.jsp?rootid="+id));
	}
	catch (ErrMsgException e) {
		out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
	}
}
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">
	</td>
  </tr>
</table>
<br>
<%
int pagesize = 10;
Paginator paginator = new Paginator(request);

TreasureUserDb tu = new TreasureUserDb();
String sql = "select userName,treasureCode from " + tu.getTableName() + " where userName=" + StrUtil.sqlstr(userName);
int total = tu.getObjectCount(sql);
paginator.init(total, pagesize);
int curpage = paginator.getCurPage();
//设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
%>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="center" class="thead style1"><lt:Label res="res.label.forum.treasure" key="treasure_use"/></td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <table width="86%" border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="<%=skin.getTableBorderClr()%>">
        <tr align="center" class="td_title">
          <td width="17%" height="22"><lt:Label res="res.label.forum.treasure" key="treasure_name"/></td>
          <td width="22%" height="22"><lt:Label res="res.label.forum.treasure" key="buy_date"/></td>
          <td width="21%"><lt:Label res="res.label.forum.treasure" key="count"/></td>
          <td width="26%"><lt:Label key="op"/></td>
        </tr>
<%
Vector v = tu.list(sql, (curpage-1)*pagesize, curpage*pagesize-1);
TreasureMgr tmg = new TreasureMgr();
Iterator ir = v.iterator();
int i = 0;
while (ir.hasNext()) {
	tu = (TreasureUserDb)ir.next();
	i++;
%>
        <form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method="post">
          <tr align="center">
            <td height="22" bgcolor="#FFFFFF">
			<%
			String treasureCode = tu.getTreasureCode();
			TreasureUnit tun = tmg.getTreasureUnit(treasureCode);
			out.print(tun.getName());
			%>
			</td>
            <td height="22" bgcolor="#FFFFFF">
			<%=DateUtil.format(tu.getBuyDate(), "yy-MM-dd")%>
            </td>
            <td bgcolor="#FFFFFF"><%=tu.getAmount()%></td>
            <td height="22" bgcolor="#FFFFFF"><a href="?op=use&code=<%=StrUtil.UrlEncode(tu.getTreasureCode())%>&id=<%=id%>"><lt:Label res="res.label.forum.treasure" key="use"/></a></td>
          </tr>
        </form>
        <%}%>
      </table>
          <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
            <tr>
              <td height="23"><div align="right">
<%
	String querystr = "";
    out.print(paginator.getCurPageBlock(request, "?id=" + id + querystr));
%>
              </div></td>
            </tr>
          </table></td>
  </tr>
</table>
<%@ include file="inc/footer.jsp"%>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table>                                        
                               
</body>                                        
</html>                            
  