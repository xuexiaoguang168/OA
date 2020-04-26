<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../../../inc/inc.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.plugin.auction.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.Leaf"%>
<%@ page import="com.redmoon.forum.LeafChildrenCacheMgr"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="pragma" content="no-cache">
<LINK href="../../../admin/default.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>插件管理</title>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="cn.js.fan.module.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "forum.plugin"))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String code = "auction";
PluginMgr pm = new PluginMgr();
PluginUnit pu = pm.getPluginUnit(code);

String op = ParamUtil.get(request, "op");
if (op.equals("addBoard")) {
	AuctionBoardDb sb = new AuctionBoardDb();
	String boardCode = ParamUtil.get(request, "boardCode");
	AuctionSkin sv = new AuctionSkin();
	if (!boardCode.equals("")) {
		if (sb.create(boardCode, ""))
			out.print(StrUtil.Alert(sv.LoadString(request, "addBoardSucceed")));
		else
			out.print(StrUtil.Alert(sv.LoadString(request, "addBoardFail")));
	}
}
if (op.equals("del")) {
	AuctionBoardDb sb = new AuctionBoardDb();
	String boardCode = ParamUtil.get(request, "boardCode");
	sb = sb.getAuctionBoardDb(boardCode);
	AuctionSkin sv = new AuctionSkin();
	if (!boardCode.equals("")) {
		if (sb.del())
			out.print(StrUtil.Alert("操作成功！"));
		else
			out.print(StrUtil.Alert("操作失败！"));
	}
}
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理插件-<%=AuctionSkin.LoadString(request, "name")%></td>
  </tr>
</table>
<br>
<table width="98%" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead">管理 - <%=AuctionSkin.LoadString(request, "name")%></td>
  </tr>
  <tr> 
    <td valign="top"><table width="82%"  border="0" align="center">
      <tr>
        <td height="34" align="center"><img src="../../../../images/arrow.gif" width="5" height="7">&nbsp;<a href="order.jsp?">管理订单</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../../../images/arrow.gif" width="5" height="7">&nbsp;<a href="catalog_frame.jsp">管理商品目录</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../../../../images/arrow.gif" width="5" height="7">&nbsp;<a href="shop_list.jsp">管理商店</a></td>
      </tr>
    </table>
      <br>
      <table width="86%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="tableframe_gray">
      <tr align="center">
        <td width="19%" height="24" bgcolor="#EFEBDE">版面编码</td>
      <td width="35%" height="22" bgcolor="#EFEBDE">版面名称</td>
        <td width="46%" height="22" bgcolor="#EFEBDE">操作</td>
      </tr>
<%
AuctionBoardDb sb1 = new AuctionBoardDb();
Vector v = sb1.list();
Iterator ir = v.iterator();
Leaf leaf = null;
com.redmoon.forum.Directory dir = new com.redmoon.forum.Directory();
while (ir.hasNext()) {
	AuctionBoardDb sb = (AuctionBoardDb)ir.next();
	leaf = dir.getLeaf(sb.getBoardCode());
%>	  
      <tr align="center">
        <td height="22" bgcolor="#FFFFFF"><%=leaf==null?"该版块已不存在":leaf.getCode()%></td>
      <td height="22" bgcolor="#FFFFFF"><%=leaf==null?"":leaf.getName()%></td>
        <td height="22" bgcolor="#FFFFFF"><a href="boardProp.jsp?boardCode=<%=StrUtil.UrlEncode(leaf==null?"":leaf.getCode())%>">管理</a>&nbsp;&nbsp;&nbsp;<a href="manager.jsp?op=del&boardCode=<%=StrUtil.UrlEncode(sb.getBoardCode())%>">删除</a></td>
      </tr>
<%}%>	  
    </table>
      <br>
      <table width="86%"  border="0" align="center" cellpadding="0" cellspacing="0">
	  <form action="?op=addBoard" method=post>
        <tr>
          <td width="56%" align="right"><select name="boardCode" onChange="if(this.options[this.selectedIndex].value=='not'){alert('您选择的是区域，请选择版块！'); this.selectedIndex=0;}">
            <option value="" selected>请选择版块</option>
			<%
				leaf = dir.getLeaf(Leaf.CODE_ROOT);
				com.redmoon.forum.DirectoryView dv = new com.redmoon.forum.DirectoryView(leaf);
				dv.ShowDirectoryAsOptions(out, leaf, leaf.getLayer());
			%>
          </select>
          &nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td width="44%" align="left"><input type=submit value="设为支持<%=AuctionSkin.LoadString(request, "name")%>功能"></td>
        </tr></form>
      </table>
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
  