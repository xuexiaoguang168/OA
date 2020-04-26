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
<title>办公用品显示</title>
</head>

<body>
<%@ include file="officeequip_inc_menu_top.jsp"%>
<br>
<table width="840" border="0" align="center">
<tr>
  <td width="834" align="right"><%
String priv = "officeequip";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

		String sql;
		String myname = privilege.getUser(request);
		String querystr = "";
		String cond = "";
		sql = "select ot.id from office_equipment_op ot , office_equipment oe , office_equipment_type oet where ot.type = '1'" ;
		cond +=sql;
		String strTypeId=ParamUtil.get(request,"typeId");
		String strOfficeId=ParamUtil.get(request,"equipId");
		String person=ParamUtil.get(request,"person");
		String beginDate=ParamUtil.get(request,"beginDate");
		String endDate=ParamUtil.get(request,"endDate");
		if (!strTypeId.equals(""))
		    cond  += " and oe.typeId = " + strTypeId;
		if (!strOfficeId.equals(""))
		    cond  += " and ot.officeId = " + strOfficeId;
		if (!person.equals(""))
		    cond += "and ot.person like " + StrUtil.sqlstr("%" + person + "%") ;
		if (!beginDate.equals(""))
		    cond += " and "+ StrUtil.sqlstr(beginDate) + " < opDate ";	
		if (!endDate.equals(""))
		    cond += " and "+ StrUtil.sqlstr(endDate) + " > opDate ";	 	
		cond += " and ot.officeId = oe.id and oe.typeId = oet.id ";	 
		querystr +=  "&typeId=" + strTypeId + "&officeId=" + strOfficeId + "&person=" + person + "&beginDate=" + beginDate + "&endDate" + endDate;
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		OfficeOpDb ood = new OfficeOpDb();
		ListResult lr = ood.listResult(cond, curpage, pagesize);
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
  <td><table width="826" border="0" align="center" cellpadding="0">
    <tr align="center">
      <td width="98" class="right-title">        用品类别</td>
      <td width="141" class="right-title">用品名称</td>
      <td width="79" class="right-title">数量</td>

      <td width="84" class="right-title">借用人</td>
      <td width="141" class="right-title">借用时间</td>
	  <td width="178" class="right-title">操&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;作</td>
    </tr>
      <%
		OfficeDb od1 = new OfficeDb();
		OfficeTypeDb otdb = new OfficeTypeDb();
		int equipmentId,typeId;
		while (ir1!=null && ir1.hasNext()) {
		  ood = (OfficeOpDb)ir1.next();
		  equipmentId= ood.getOfficeId();
		  OfficeDb odb = od1.getOfficeDb(equipmentId);
		  typeId = odb.getTypeId();
		  otdb = otdb.getOfficeTypeDb(typeId);
	%>
     <tr align="center">
      <td height="28" bgcolor="#FFFFFF"><%=otdb.getName()%></td>
      <td bgcolor="#FFFFFF"><%=odb.getOfficeName()%></td>
      <td bgcolor="#FFFFFF"><%=ood.getCount()%></td>
   
      <td bgcolor="#FFFFFF"><%=ood.getPerson()%></td>
      <td bgcolor="#FFFFFF"><%=ood.getOpDate()%></td>
	  <td bgcolor="#FFFFFF"><a href="#" class="STYLE2" onClick="window.open('officeequip_return_show.jsp?id=<%=ood.getId()%>','','height=300, width=500, top=200,left=400, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no,status=no')">归还</a></td>
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
  <td align="center"><input type="button" class="button1" onClick="window.location.href='officeequip_return.jsp'"  value="借用查询"></td>
</tr>
</table>
</body>
</html>
