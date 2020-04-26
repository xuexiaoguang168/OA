<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*,
				 java.text.*,
				 com.redmoon.blog.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 com.redmoon.forum.plugin.auction.*,
				 com.redmoon.forum.person.*,
				 cn.js.fan.web.*,
				 cn.js.fan.module.pvg.*"
%>
<%@ page import="com.redmoon.forum.person.UserSet"%>
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
<HTML><HEAD><TITLE><%=Global.AppName%> - 商店列表</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link href="../../<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<META content="MSHTML 6.00.3790.259" name=GENERATOR>
<style type="text/css">
<!--
.style1 {	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</HEAD>
<BODY leftMargin=0 topMargin=0>
<%@ include file="../../inc/header.jsp"%>
<%
String privurl = ParamUtil.get(request, "privurl");
%>
<br>
<%
int pagesize = 10;
Paginator paginator = new Paginator(request);

AuctionShopDb asd = new AuctionShopDb();
String sql = asd.QUERY_LIST; // "select userName from " + asd.getTableName();
String action = ParamUtil.get(request, "action");
String kind = ParamUtil.get(request, "kind");
String value = ParamUtil.get(request, "value");
if (action.equals("search")) {
	if (kind.equals("userName")) {
		com.redmoon.forum.person.UserDb ud = new com.redmoon.forum.person.UserDb();
		String nicks = ud.getNicksLike(value);	
		sql = "select userName from " + asd.getTableName() + " where userName in (" + nicks + ")";
	}
	else
		sql = "select userName from " + asd.getTableName() + " where shopName like " + StrUtil.sqlstr("%" + value + "%");
}
int total = asd.getObjectCount(sql);
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
    <td height=20 align="center" class="thead style1">商店列表</td>
  </tr>
  <tr>
    <td valign="top"><table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name=formsearch action="?action=search" method="post">
        <tr>
          <td align="center"> 按
            <select name="kind">
                <option value="shopName">商店名称</option>
                <option value="userName">用户名</option>
              </select>
              <input name="value">
            &nbsp;
            <input name="submit" type="submit" value="搜索商店"></td>
        </tr>
      </form>
    </table>
      <br>
        <table width="86%" height="24" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right"><div>找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></div></td>
          </tr>
        </table>
      <table width="86%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#666666">
          <tr align="center" bgcolor="#F1EDF3">
            <td width="26%" height="22">商店名称</td>
            <td width="21%" height="22">用户</td>
            <td width="16%">开店日期</td>
          </tr>
<%
com.redmoon.forum.person.UserMgr um = new com.redmoon.forum.person.UserMgr();		  
Vector v = asd.list(sql, (curpage-1)*pagesize, curpage*pagesize-1);
Iterator ir = v.iterator();
int i = 0;
while (ir.hasNext()) {
	asd = (AuctionShopDb)ir.next();
	i++;
%>
          <form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method="post">
            <tr align="center">
              <td height="22" bgcolor="#FFFFFF"><a target=_blank href="../../plugin/auction/shop.jsp?userName=<%=StrUtil.UrlEncode(asd.getUserName())%>"><%=asd.getShopName()%></a>              </td>
              <td height="22" bgcolor="#FFFFFF"><a href="../../../userinfo.jsp?username=<%=StrUtil.UrlEncode(asd.getUserName())%>"><%=um.getUser(asd.getUserName()).getNick()%></a></td>
              <td bgcolor="#FFFFFF"><%=DateUtil.format(asd.getOpenDate(), "yy-MM-dd HH:mm:ss")%></td>
            </tr>
          </form>
          <%}%>
      </table>
      <table width="86%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
          <tr>
            <td height="23"><div align="right">
              <%
	String querystr = "action=" + action + "&kind=" + kind + "&value=" + StrUtil.UrlEncode(value);
    out.print(paginator.getCurPageBlock("?"+querystr));
%>
            </div></td>
          </tr>
    </table></td>
  </tr>
</table>
<br>
<%@ include file="../../inc/footer.jsp"%>
</BODY>
<script>
function DelShop(userName) {
	if (confirm("您确定要删除么？\n删除商店时将连同用户已发布的商品一起删除！")) {
		window.location.href = "?op=del&userName=" + userName;
	}
}
</script>
</HTML>
