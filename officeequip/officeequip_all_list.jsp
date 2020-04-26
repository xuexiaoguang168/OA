<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.SkinUtil"%>
<%@ page import = "com.redmoon.oa.officeequip.*"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="../common.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<title>办公用品资料</title>
</head>
<%
String op1 = ParamUtil.get(request, "op");
if (op1.equals("del")) {
	OfficeMgr om = new OfficeMgr();
	boolean re = false;
	try {
		re = om.del(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<body>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="811" border="0" align="center">
<tr>
  <td align="right"><%
String priv = "officeequip";
	if (!privilege.isUserPrivValid(request, priv))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
			String sql;
			String myname = privilege.getUser(request);
			sql = "select id from office_equipment" ;
			String querystr = "";
			String op = ParamUtil.get(request, "op");
			String cond = "";
			String strType = ParamUtil.get(request, "typeId");
			String equipType = ParamUtil.get(request, "equipId");
			String person = ParamUtil.get(request, "person");
			String beginDate = ParamUtil.get(request, "beginDate");
			String endDate = ParamUtil.get(request, "endDate");
			if (!strType.equals(""))
					cond = " where typeId = " + strType;
			if (!equipType.equals("")) {
				if (cond.equals(""))
						cond += " where typeId=" + strType;
					else
						cond += " and typeId=" + strType;
				}
				
				sql += cond;	
		querystr +=  "&typeId=" + strType ;
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		OfficeDb od = new OfficeDb();
		ListResult lr = od.listResult(sql, curpage, pagesize);
		int total1 = lr.getTotal();
		Vector v = lr.getResult();
	    Iterator ir1 = null;
		if (v!=null)
			ir1 = v.iterator();
		paginator.init(total1, pagesize);
		// 设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}

%>    &nbsp;找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></b></td>
</tr>
<tr align="center">
  <td><table width="810" border="0" align="center" cellspacing="1" class="tableframe">
    <tr align="center">
      <td width="117" bgcolor="#00CCFF" class="right-title">        用品类别</td>
      <td width="199" bgcolor="#00CCFF" class="right-title">用品名称</td>
	  <td width="115" bgcolor="#00CCFF" class="right-title">单位</td>
      <td width="92" bgcolor="#00CCFF" class="right-title">库存</td>
      <td width="92" bgcolor="#00CCFF" class="right-title">价格</td>
      <td width="83" bgcolor="#00CCFF" class="right-title">备注</td>
      <td width="84" bgcolor="#00CCFF" class="right-title">操作</td>
    </tr>
      <%
		
		//OfficeTypeDb otdb = new OfficeTypeDb();
		int equipmentId,typeId;
		while (ir1!=null && ir1.hasNext()) {
		  od = (OfficeDb)ir1.next();
		  int typeId1 = od.getTypeId();
		  OfficeTypeDb otdb = new OfficeTypeDb();
		  otdb = otdb.getOfficeTypeDb(typeId1);
	%>
	<tr align="center">
      <td bgcolor="#FFFFFF"><a href="officeequip_all_list.jsp?op=search&typeId=<%=otdb.getId()%>"><%=otdb.getName()%></a></td>
      <td bgcolor="#FFFFFF"><%=od.getOfficeName()%></td>
	  <td bgcolor="#FFFFFF"><%=od.getMeasureUnit()%></td>
      <td bgcolor="#FFFFFF"><%=od.getStorageCount()%></td>
      <td bgcolor="#FFFFFF"><%=od.getPrice()%></td>
      <td bgcolor="#FFFFFF"><%=od.getAbstracts()%></td>
      <td bgcolor="#FFFFFF"><a href="#" onClick="if (confirm('您确定要删除<%=od.getOfficeName()%>吗？')) window.location.href='?op=del&id=<%=od.getId()%>'">删除</a></td>
    </tr>
    <%}%>
  </table></td>
</tr>
<tr>
  <td align="right"><%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %></td>
</tr>


<tr>
  <td align="center"><input type="button" class="button1" onClick="window.location.href='officeequip_search.jsp'" value=" 查 询 "></td>
</tr>
</table>
</body>
</html>
