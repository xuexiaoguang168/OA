<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资产查询列表</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
</head>
<body>
<%
String priv = "oa.asset";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	AssetMgr am = new AssetMgr();
	boolean re = false;
	try {
		  re = am.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "asset_list.jsp"));

}%>
<%@ include file="asset_inc_menu_top.jsp"%>
<br>
<table width="100%" border="0">
  <tr>
    <td width="100%" align="right"><table width="90%" height="25" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="298" align="right" backgroun="images/title1-back.gif"><%
		String sql;
		String myname = privilege.getUser(request);
		sql = "select id from asset_info" ;
		String querystr = "";
		String cond = "";
		if (op.equals("search")) {
		    String name=ParamUtil.get(request,"name");
			String strTypeId=ParamUtil.get(request,"typeId");
			String number=ParamUtil.get(request,"number");
			if (!strTypeId.equals("all")){
			    if (cond.equals(""))
					cond = " where typeId=" + strTypeId;
				else
			        cond += " and  typeId=" + strTypeId;
					}
			if (!number.equals(""))
			    if (cond.equals(""))
					cond = " where number =" + StrUtil.sqlstr(number);
				else
					cond += " and number =" + StrUtil.sqlstr(number); 
			if (!name.equals(""))
			    if (cond.equals(""))
				   cond = " where name like " + StrUtil.sqlstr("%" + name + "%");
				else   
				   cond += " and name like " + StrUtil.sqlstr("%" + name + "%");
		    sql += cond;	
			querystr += "op=" + op + "&name=" + name + "&number=" + number+ "&typeId=" + strTypeId;
		}
		sql += " order by regDate desc";
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();	
		AssetDb adb = new AssetDb();
		ListResult lr = adb.listResult(sql, curpage, pagesize);
		int total = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir = null;
		if (v!=null)
			ir = v.iterator();
		paginator.init(total, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
        </td>
        <td width="299" align="right" backgroun="images/title1-back.gif"> 找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></b></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0"  bgcolor="#d4def6" >
      <tbody>
        <tr>
          <td width="12%"></td>
        </tr>
        <tr bgcolor="#66CCFF">
          <td align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">资产名称</td>
          <td width="7%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">资产编号</td>
          <td width="7%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">资产类别</td>
          <td width="6%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">资产型号</td>
          <td width="7%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">资产原值</td>
          <td width="8%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">月折旧额</td>
          <td width="5%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">领用人</td>
          <td width="7%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">领用时间</td>
          <td width="5%" align="middle" nowrap="nowrap" bgcolor="#66CCFF" class="right-title">操作</td>
        </tr>
      </tbody>
    </table>
        <table id="mainTable" cellspacing="0" bordercolordark="#ffffff" cellpadding="2" width="100%" bordercolorlight="#d9e3ed" border="1" frame="void">
          <%	
	  	int i = 0;
		AssetTypeDb atdb = new AssetTypeDb();
		while (ir!=null && ir.hasNext()) {
			adb = (AssetDb)ir.next();
			i++;
			int id = adb.getId();
			int typeId = adb.getTypeId();
			atdb = atdb.getAssetTypeDb(typeId);
		%>
		  <tbody>
            <tr bgcolor="#FFFFFF">
              <td width="12%" height="22" align="center" valign="top"><a href="#" class="STYLE2" onClick="window.open('asset_modify.jsp?id=<%=adb.getId()%>','','height=260, width=570, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')"><%=adb.getName()%></a></td>
              <td width="7%" valign="top"><%=adb.getNumber()%></td>
              <td width="7%" valign="top"><%=atdb.getName()%></td>
              <td width="6%" valign="top"><%=adb.getType()%></td>
              <td width="7%" valign="top"><%=adb.getPrice()%></td>
		      <td width="8%" valign="top">
			  <%
				double price = 0;
				if (atdb.getDepreciationYears() > 0)	
					price =  (adb.getPrice() - adb.getPrice() * StrUtil.toDouble(atdb.getDepreciationRate()))/atdb.getDepreciationYears() / 12;	
				else
				    price = 0;		
			  %>
			  <%=NumberUtil.round(price, 2)%>
			  </td>
              <td width="5%" valign="top"><%=adb.getKeeper()%></td>
              <td width="7%" valign="top">
			  <% if (adb.getStartDate()==null) {
			       out.print("");
				 }
				 else {
				   out.print(adb.getStartDate()); 
				 }
			  %>
			  </td>
              <td width="5%" valign="top"><a href="#" onClick="if (confirm('您确定要删除<%=adb.getName()%>吗？')) window.location.href='?op=del&id=<%=adb.getId()%>'">删除</a></td>
            </tr>
          </tbody>
		    <%}%>
      </table>
    </td>
  </tr>

  <tr>
    <td><div align="right">
      <%
		out.print(paginator.getCurPageBlock("?"+querystr));
	  %>
      &nbsp;</div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

</body>
</html>
