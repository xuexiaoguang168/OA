<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.visual.*"%>
<%@ page import = "com.redmoon.oa.flow.FormDb"%>
<%@ page import = "com.redmoon.oa.flow.FormField"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String formCode = "sales_linkman";

FormDb fd = new FormDb();
fd = fd.getFormDb(formCode);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=fd.getName()%>列表</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%> 
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%
String priv = "sales.user";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
String action = ParamUtil.get(request, "action"); // action为manage时表示为销售总管理员方式
if (action.equals("manage")) {
	if (!privilege.isUserPrivValid(request, "sales"))
	{
		out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
}
%>
<%@ include file="linkman_inc_menu_top.jsp"%>
<%
String querystr = "";

FormDb customerfd = new FormDb();
customerfd = customerfd.getFormDb("sales_customer");

String sql = "select id from " + fd.getTableNameByForm();		

String query = ParamUtil.get(request, "query");
if (!query.equals(""))
	sql = query;
else
	if (op.equals("search")) {
		Iterator ir = fd.getFields().iterator();
		String cond = "";
		if (action.equals("")) {
			sql = "select a.id from " + fd.getTableNameByForm() + " a, " + customerfd.getTableNameByForm() + " b";
			cond = "a.customer=b.customer and b.sales_person=" + StrUtil.sqlstr(privilege.getUser(request));
		}
		
		while (ir.hasNext()) {
			FormField ff = (FormField)ir.next();
			String value = ParamUtil.get(request, ff.getName());
			String name_cond = ParamUtil.get(request, ff.getName() + "_cond");
			if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {
				String fDate = ParamUtil.get(request, ff.getName() + "FromDate");
				String tDate = ParamUtil.get(request, ff.getName() + "ToDate");
				if (!fDate.equals("")) {
					if (cond.equals(""))
						cond += ff.getName() + ">=" + StrUtil.sqlstr(fDate);
					else
						cond += " and " + ff.getName() + ">=" + StrUtil.sqlstr(fDate);
				}
				if (!tDate.equals("")) {
					if (cond.equals(""))
						cond += ff.getName() + "<=" + StrUtil.sqlstr(tDate);
					else
						cond += " and " + ff.getName() + "<=" + StrUtil.sqlstr(tDate);
				}
			}
			else {
				if (name_cond.equals("0")) {
					if (!value.equals("")) {
						if (cond.equals(""))
							cond += ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
						else
						    if(ff.getName().equals("customer"))
								cond += " and a." + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
							else
								cond += " and " + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
							
					}
				}
				else if (name_cond.equals("1")) {
					if (!value.equals("")) {
						if (cond.equals(""))
							cond += ff.getName() + "=" + StrUtil.sqlstr(value);
						else
					        if(ff.getName().equals("customer"))
								cond += " a.and " + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
							else
								cond += " and " + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
					}
				}
			}
		}
		if (!cond.equals(""))
			sql = sql + " where " + cond;	
	}
	else {
		if (action.equals("")) {
			sql = "select a.id from " + fd.getTableNameByForm() + " a, " + customerfd.getTableNameByForm() + " b";
			sql += " where a.customer=b.customer and b.sales_person=" + StrUtil.sqlstr(privilege.getUser(request));
		}
	}
querystr = "query=" + StrUtil.UrlEncode(sql);	
//out.print(sql);
%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr> 
    <td height="23" valign="middle" class="right-title">&nbsp;
	
	<%=fd.getName()%>
	</td>
  </tr>
  <tr> 
    <td valign="top" background="workplan/images/tab-b-back.gif">
<%
		int pagesize = 10;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
			
		FormDAO fdao = new FormDAO();
		
		ListResult lr = fdao.listResult(formCode, sql, curpage, pagesize);
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
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47">&nbsp;</td>
          <td align="right" backgroun="images/title1-back.gif">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table> 
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
        <tr align="center" bgcolor="#C4DAFF">
          <td width="19%" bgcolor="#C4DAFF">联系人</td> 
          <td width="21%" bgcolor="#C4DAFF">客户</td>
          <td width="15%" bgcolor="#C4DAFF">手机</td>
          <td width="16%" bgcolor="#C4DAFF">办公电话</td>
          <td width="12%" bgcolor="#C4DAFF">网址</td>
          <td width="17%" bgcolor="#C4DAFF">操作</td>
        </tr>
      <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			fdao = (FormDAO)ir.next();
			i++;
			int id = fdao.getId();
		%>
        <tr align="center" bgcolor="#EEEEEE">
          <td width="19%" bgcolor="#EEEEEE"><a href="customer_show.jsp?id=<%=id%>&formCode=<%=formCode%>"><%=fdao.getFieldValue("linkmanName")%></a></td> 
          <td width="21%" bgcolor="#EEEEEE"> <a href="customer_show.jsp?id=<%=id%>&formCode=<%=formCode%>"><%=fdao.getFieldValue("customer")%></a></td>
          <td width="15%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("mobile")%></a></td>
          <td width="16%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("telNoWork")%></a></td>
          <td width="12%" bgcolor="#EEEEEE"><a href=../visual_show.jsp?id=<%=id%>&formCode=<%=formCode%>><%=fdao.getFieldValue("EMAIL")%></a></td>
          <td width="17%" bgcolor="#EEEEEE"><a href="linkman_edit.jsp?id=<%=id%>&formCode=<%=StrUtil.UrlEncode(formCode)%>">编辑</a>&nbsp;&nbsp;<a href="../visual_del.jsp?id=<%=id%>&formCode=<%=formCode%>&privurl=<%=StrUtil.getUrl(request)%>">删除</a>&nbsp;&nbsp;
            <%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
<a href="../message_oa/send_sms.jsp?mobile=<%=fdao.getFieldValue("mobile")%>">短讯</a>
<%}%></td>
        </tr>
      <%
		}
%>
      </table>
      <br>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
        <tr> 
          <td width="1%" height="23">&nbsp;</td>
          <td height="23" valign="baseline"> 
            <div align="right"> 
            <%
			out.print(paginator.getCurPageBlock("?action=" + action + "&" + querystr));
			%>
              &nbsp;</div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td height="9">&nbsp;</td>
  </tr>
</table>
</body>
</html>
