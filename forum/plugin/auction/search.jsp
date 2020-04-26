<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.forum.plugin.auction.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<LINK href="../../../common.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Global.AppName%> - 搜索商品</title>
<script language="JavaScript">
<!--

//-->
</script>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<%@ include file="../../inc/header.jsp"%>
<jsp:useBean id="dir" scope="page" class="com.redmoon.forum.plugin.auction.Directory"/>
<%
String what = ParamUtil.get(request, "what");
%>
<br>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead"><table width="100%" border="0" class="p9">
          <form name="form_search" method="post" action="search.jsp" onSubmit="">
            <tr> 
              <td height="27" align="center">                <input value="" id="what" name="what" onFocus="" onBlur="" type="text" class="singleboarder" size=16>                &nbsp;
                <input type="image" value="images/default/search.gif" src="images/default/search.gif" align="middle" width="57" height="16">                </td>
              </tr>
          </form>
        </table>
	</td>
  </tr>
<%
int pagesize = 10;
Paginator paginator = new Paginator(request);

AuctionDb ad = new AuctionDb();

String sql = "select msgRootId from " + ad.getTableName() + " where name like " + StrUtil.sqlstr("%" + what + "%") + " order by beginDate desc";
int total = ad.getObjectCount(sql);
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
  <tr> 
    <td valign="top"><br>
      <table width="95%" height="24" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="right"><div>找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></div></td>
        </tr>
      </table>
      <table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFBFF" class="tableframe_gray">
      <tr align="center">
        <td width="18%" height="22">商品名称</td>
      <td width="16%" height="22">卖家姓名</td>
        <td width="17%" height="22">信用值</td>
      <td width="17%">价格</td>
        <td width="15%">销售日期</td>
        <td width="17%">操作</td>
      </tr>
<%
String querystr = "what=" + StrUtil.UrlEncode(what);
Vector v = ad.list(sql, (curpage-1)*pagesize, curpage*pagesize-1);
Iterator ir = v.iterator();
int i = 0;
UserDb user = new UserDb();
while (ir.hasNext()) {
	ad = (AuctionDb)ir.next();
	i++;
%>
      <tr align="center">
        <td height="28"><%=ad.getName()%>		</td>
        <td height="28">
		<%
		user = user.getUser(ad.getUserName());
		%>
		<a href="../../../userinfo.jsp?username=<%=StrUtil.UrlEncode(user.getName())%>"><%=user.getName()%></a>
		</td>
        <td height="28">
		<%=user.getCredit()%>
		</td>
      <td height="28"><%
	AuctionWorthDb aw = new AuctionWorthDb();
	long[] ary = aw.getWorthOfAuction(ad.getMsgRootId());
	if (ad.getSellType()==ad.SELL_TYPE_AUCTION) {
		aw = aw.getAuctionWorthDb((int)ary[0]);
	%>
底价：<%=aw.getMoneyName()%><%=aw.getPrice()%>&nbsp;<%=aw.getMoneyDanWei()%>
<%} else {
		int len = ary.length;
		for (int k=0; k<len; k++) {
			aw = aw.getAuctionWorthDb((int)ary[k]);
			%>
一口价：<%=aw.getMoneyName()%><%=aw.getPrice()%>&nbsp;<%=aw.getMoneyDanWei()%><BR>
<%}
	}%></td>
        <td>
	  <%=DateUtil.format(ad.getBeginDate(), "yy-MM-dd")%>
	  </td>
        <td height="28">        <a href="../../showtopic.jsp?rootid=<%=ad.getMsgRootId()%>">查看</a></td>
      </tr>
<%}%>	  
    </table>
      <table width="87%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr>
          <td height="23"><div align="right">
              <%
    out.print(paginator.getCurPageBlock("?"+querystr));
%>
          </div></td>
        </tr>
      </table>
      <br>
    </td>
  </tr>
</table>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table>                                        
                               
</body>                                        
</html>                            
  