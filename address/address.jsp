<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<%@ page import="cn.js.fan.web.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
.menutitle{
cursor:pointer;
margin-bottom: 5px;
background-color:#ECECFF;
color:#000000;
width:140px;
padding:2px;
text-align:center;
font-weight:bold;
/*/*/border:1px solid #000000;/* */
}

.submenu{
margin-bottom: 0.1em;
}
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%
String priv = "read";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String strtype = ParamUtil.get(request, "type");
int type = AddressDb.TYPE_USER;
if (!strtype.equals(""))
	type = Integer.parseInt(strtype);
String mode = ParamUtil.get(request, "mode");
String groupType = ParamUtil.get(request, "groupType");
if (!mode.equals("show")) {	
	if (type==AddressDb.TYPE_PUBLIC) {
		if (!privilege.isUserPrivValid(request, "admin.address.public")) {
			out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
	}
}
%>
<table width="98%" border="0">
  <tr>
    <td align="center"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="tableframe">
      <tr>
        <td colspan="2" valign="middle" class="right-title">&nbsp;<span>通 
          讯 录 </span></td>
      </tr>
      <tr>
        <td colspan="2" valign="top" bgcolor="#FFFFFF"><%
			String op = request.getParameter("op");
			if (op!=null)
			{
				AddressMgr am = new AddressMgr();
				boolean re = false;
				if (op.equals("add")) {
					try {
						re = am.create(request);
					}
					catch (ErrMsgException e) {
						out.print(StrUtil.Alert(e.getMessage()));
					}
					if (re) {
						out.print(StrUtil.Alert("操作成功！"));
					}
				}
				if (op.equals("del")) {
					try {
						re = am.del(request);
					}
					catch (ErrMsgException e) {
						out.print(StrUtil.Alert(e.getMessage()));
					}
					if (re) {
						out.print(StrUtil.Alert("操作成功！"));
					}
				}
			  }
			String sql = "select id from address where type=" + type;
			String myname = privilege.getUser(request);
			String group = ParamUtil.get(request, "groupType");
			String searchStr = "";
			
				if (op!=null && op.equals("search")){
				   String person = ParamUtil.get(request, "person");
				   String nickname = ParamUtil.get(request, "nickname");
				   String company = ParamUtil.get(request, "company");
				   String address = ParamUtil.get(request, "address");
				   String street = ParamUtil.get(request, "street");
				   String QQ = ParamUtil.get(request, "QQ");
				   String MSN = ParamUtil.get(request, "MSN");
				   int typeId = ParamUtil.getInt(request, "typeId");	
				   
				   searchStr += "&person=" + StrUtil.UrlEncode(person);
				   searchStr += "&nickname=" + StrUtil.UrlEncode(nickname);
				   searchStr += "&company=" + StrUtil.UrlEncode(company);
				   searchStr += "&address=" + StrUtil.UrlEncode(address);
				   searchStr += "&street=" + StrUtil.UrlEncode(street);
				   searchStr += "&QQ=" + StrUtil.UrlEncode(QQ);
				   searchStr += "&MSN=" + StrUtil.UrlEncode(MSN);
				   searchStr += "&typeId=" + typeId;				   
				   		   
				   if (type==AddressDb.TYPE_USER)
					   sql = "select id from address where userName=" + StrUtil.sqlstr(privilege.getUser(request)) + " and type=" + AddressDb.TYPE_USER;
				   else {
						sql = "select id from address where type=" + type;
				   }
				   if (!person.equals("")){
						sql += " and person like " + StrUtil.sqlstr("%" + person + "%");
				   }
				   if (!nickname.equals("")){
						sql += " and nickname like " + StrUtil.sqlstr("%" + nickname + "%");
				   }
				   if (!company.equals("")){
						sql += " and company like " + StrUtil.sqlstr("%" + company + "%");
				   }
				   if (!address.equals("")){
						sql += " and address like " + StrUtil.sqlstr("%" + address + "%");
				   }
				   if (!street.equals("")){
						sql += " and street like " + StrUtil.sqlstr("%" + street + "%");
				   }
				   if (!MSN.equals("")){
						sql += " and MSN like " + StrUtil.sqlstr("%" + MSN + "%");
				   }
				   if (!QQ.equals("")){
						sql += " and QQ like " + StrUtil.sqlstr("%" + QQ + "%");
				   }
				   if (typeId > 0){
                       sql += " and typeId = " + typeId;				   
				   }
				}
				else {
					if (!group.equals("") && !group.equals("0"))
						sql += " and typeId = " + group;
					if (type!=AddressDb.TYPE_PUBLIC)	 
						sql += " and userName=" + 	StrUtil.sqlstr(privilege.getUser(request)); 
				}


			int pagesize = 10;
			Paginator paginator = new Paginator(request);
			int curpage = paginator.getCurPage();
			AddressDb addr = new AddressDb();
			ListResult lr = addr.listResult(sql, curpage, pagesize);
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
                <td align="right"><div align="right" class="title1">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %> </div></td>
              </tr>
            </table>
            <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1">
              <tr align="center" bgcolor="#C4DAFF">
                <td>部门</td>
                <td>科室&nbsp;</td>
                <td>姓名</td>
                <td bgcolor="#C4DAFF">办公室电话</td>
                <td bgcolor="#C4DAFF">住宅电话</td>
                <td bgcolor="#C4DAFF">手机</td>
                <td>小灵通</td>
                <td>操作</td>
              </tr>
            <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			addr = (AddressDb)ir.next();
			i++;
			int id = addr.getId();
			String person = addr.getPerson();
			String mobile = addr.getMobile();
			String email = addr.getEmail();
			String qq = addr.getQQ();
			String job = addr.getJob();
			String adddate = DateUtil.format(addr.getAddDate(), "yyyy-MM-dd");
		%>
              <tr align="center" bgcolor="#EEEEEE">
                <td bgcolor="#EEEEEE"><%=addr.getDepartment()%></td>
                <td bgcolor="#EEEEEE"><%=addr.getCompany()%></td>
                <td bgcolor="#EEEEEE"><a href=address_list.jsp?id=<%=id%>&mode=show><%=person%></a></td>
                <td bgcolor="#EEEEEE"><%=addr.getOperationPhone()%></td>
                <td bgcolor="#EEEEEE"><%=addr.getTel()%></td>
                <td bgcolor="#EEEEEE"><%=mobile%>&nbsp;</td>
                <td bgcolor="#EEEEEE"><%=addr.getBeepPager()%>&nbsp;</td>
                <td bgcolor="#EEEEEE"><%if (type==AddressDb.TYPE_PUBLIC) {
		  		if (privilege.isUserPrivValid(request, "address.public")) {%>
                    <a href="address_modify.jsp?type=<%=addr.getType()%>&id=<%=id%>">编辑</a>&nbsp;&nbsp;<a href="address.jsp?op=del&type=<%=addr.getType()%>&id=<%=id%>">删除</a>
                    <%	}
		  }else{%>
                    <a href="address_modify.jsp?type=<%=addr.getType()%>&id=<%=id%>">编辑</a>&nbsp;&nbsp;<a href="address.jsp?op=del&type=<%=addr.getType()%>&id=<%=id%>">删除</a>
                <%}%><%
if (com.redmoon.oa.sms.SMSFactory.isUseSMS()) {
%>
&nbsp;&nbsp;<a href="../message_oa/send_sms.jsp?mobile=<%=mobile%>">短讯</a>
<%}%>				
				</td>
              </tr>
            <%}%>
            </table>
            <br>
            <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
              <tr>
                <td width="1%" height="23">&nbsp;</td>
                <td height="23" valign="baseline"><div align="right">
                    <%
						String querystr = "type=" + type + "&mode=" + mode + "&groupType=" + groupType;
						if (op!=null && op.equals("search")) {
							querystr += "&op=search" + searchStr;
						}						
						out.print(paginator.getCurPageBlock("?"+querystr));
					%>
                  &nbsp;</div></td>
              </tr>
              <tr>
                <td height="23">&nbsp;</td>
                <td height="23" align="right" valign="baseline"><input name="button" type="button" class="button1" onClick='importExcel()' value="导入outlook格式">
                &nbsp;&nbsp;
                <input type="button" class="button1" onClick='openExcel()' value="导出outlook格式"></td>
              </tr>
            </table></td>
        </tr>
    </table>     </td>
  </tr>
</table>
</body>
<script>
function openExcel() {
	var sql = "<%=sql%>";
	window.open("address_excel.jsp?sql=" + sql); 
}
</script>
<script>
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function importExcel() {
	var url = "import_excel.jsp?type=" + "<%=type%>" + "&group=" + "<%=group%>";
	//window.open("import_excel.jsp?type=" + type);
	openWin(url,360,80);
}
</script>
</html>



