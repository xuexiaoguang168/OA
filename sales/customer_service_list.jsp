<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.visual.*"%>
<%@ page import = "com.redmoon.oa.flow.FormDb"%>
<%@ page import = "com.redmoon.oa.flow.FormField"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}

String op = ParamUtil.get(request, "op");
String formCode = "sales_customer_service";

String querystr = "";

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
<script src="<%=Global.getRootPath()%>/inc/flow_dispose_js.jsp"></script>
<script src="<%=Global.getRootPath()%>/inc/flow_js.jsp"></script>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="customer_service_inc_menu_top.jsp"%>
<%
String sql = "select id from " + fd.getTableNameByForm();		

String query = ParamUtil.get(request, "query");
if (!query.equals(""))
	sql = query;
else
	if (op.equals("search")) {
		Iterator ir = fd.getFields().iterator();
		String cond = "";
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
							cond += " and " + ff.getName() + " like " + StrUtil.sqlstr("%" + value + "%");
					}
				}
				else if (name_cond.equals("1")) {
					if (!value.equals("")) {
						if (cond.equals(""))
							cond += ff.getName() + "=" + StrUtil.sqlstr(value);
						else
							cond += " and " + ff.getName() + "=" + StrUtil.sqlstr(value);
					}
				}
			}
		}
		if (!cond.equals(""))
			sql = sql + " where " + cond;
	}
querystr = "query=" + StrUtil.UrlEncode(sql);
%>
<br>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr> 
    <td height="23" valign="middle" class="right-title">&nbsp;<%=fd.getName()%></td>
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

<table cellSpacing="1" width="57%" align="center" border="0">
  <form id="form2" name="form2" action="http://fserver2:8080/oa/sales/customer_service_list.jsp?op=search" method="post">
    <tbody>
      <tr>
        <td noWrap colSpan="3">
          <table width="100%" border="0" cellPadding="2" cellSpacing="0" class="tableframe">
            <tbody>
              <tr>
                <td colSpan="3" bgcolor="#C4DAFF"><b>表单数据信息（表单名称：客户服务）</b></td>
              </tr>
              <tr>
                <td width="29%">服务日期：</td>
                <td noWrap width="19%">从 <input size="10" name="contact_dateFromDate"> 
                  <img style="CURSOR: hand" onClick="SelectDate('contact_dateFromDate', 'yyyy-MM-dd')" src="http://fserver2:8080/oa/images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
                <td width="52%">至 <input size="10" name="contact_dateToDate"> 
                  <img style="CURSOR: hand" onClick="SelectDate('contact_dateToDate', 'yyyy-MM-dd')" src="http://fserver2:8080/oa/images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></td>
              </tr>
              <tr>
                <td width="29%">客户名称：</td>
                <td noWrap width="19%"><select name="customer_cond">
                    <option value="1" selected>等于</option>
                  </select></td>
                <td width="52%"><input name="customer" size="20"></td>
              </tr>
              <tr>
                <td width="29%">联系人：</td>
                <td noWrap width="19%"><select name="lxr_cond">
                    <option value="1" selected>等于</option>
                  </select></td>
                <td width="52%"><input name="lxr" size="20"></td>
              </tr>
              
              <tr>
                <td width="29%">服务类型：</td>
                <td noWrap width="19%"><select name="contact_type_cond">
                    <option value="1" selected>等于</option>
                  </select></td>
                <td width="52%"><input name="contact_type" size="20"></td>
              </tr>
              <tr>
                <td width="29%">客户满意度：</td>
                <td noWrap width="19%"><select name="satisfy_cond">
                    <option value="1" selected>等于</option>
                  </select></td>
                <td width="52%"><input name="satisfy" size="20"></td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
      <tr align="middle">
        <td noWrap align="center" colSpan="3" height="30"><input class="BigButton"  type="submit" value="查  询" name="submit"> 
          &nbsp;&nbsp;&nbsp;&nbsp;</td>
      </tr>
    </tbody>
  </form>
</table>

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47">&nbsp;</td>
          <td align="right" backgroun="images/title1-back.gif">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table> 
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="1">
        <tr align="center" bgcolor="#C4DAFF"> 
          <td width="26%" bgcolor="#C4DAFF">客户名称</td>
          <td width="20%" bgcolor="#C4DAFF">联系人</td>
          <td width="21%" bgcolor="#C4DAFF">客户满意度</td>
          <td width="16%" bgcolor="#C4DAFF">服务日期</td>
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
          <td width="26%" bgcolor="#EEEEEE"> <a href="customer_service_show.jsp?id=<%=id%>&formCode=<%=formCode%>"><%=fdao.getFieldValue("customer")%></a></td>
          <td width="20%" bgcolor="#EEEEEE"><%=fdao.getFieldValue("lxr")%></td>
          <td width="21%" bgcolor="#EEEEEE"><%=fdao.getFieldValue("satisfy")%></td>
          <td width="16%" bgcolor="#EEEEEE"><%=fdao.getFieldValue("contact_date")%></td>
          <td width="17%" bgcolor="#EEEEEE"><a href="customer_service_edit.jsp?id=<%=id%>&formCode=<%=StrUtil.UrlEncode(formCode)%>">编辑</a>&nbsp;&nbsp;<a href="../visual_del.jsp?id=<%=id%>&formCode=<%=formCode%>&privurl=<%=StrUtil.getUrl(request)%>">删除</a>&nbsp;&nbsp;		  </td>
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
			out.print(paginator.getCurPageBlock("?"+querystr));
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
