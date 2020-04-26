<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.cloudwebsoft.framework.db.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
<title><lt:Label res="res.label.forum.admin.user_m" key="user_manage"/></title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style></head>
<body>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="fdate" scope="page" class="cn.js.fan.util.DateUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="prision" scope="page" class="com.redmoon.forum.life.prision.Prision"/>
<div id="newdiv" name="newdiv">
  <table width='100%' cellpadding='0' cellspacing='0' >
    <tr>
      <td class="head"><lt:Label res="res.label.forum.admin.user_m" key="user_manage"/></td>
    </tr>
  </table><br>
<%
//安全验证
if (!privilege.isMasterLogin(request))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = StrUtil.getNullString(request.getParameter("op"));
String privurl = request.getRequestURL()+"?"+request.getQueryString();
if (op.equals("setpolice")) {
	String username = ParamUtil.get(request, "username");
	int value = ParamUtil.getInt(request, "value");
	
	UserDb user = new UserDb();
	user = user.getUser(username);
	user.setIsPolice(value);
	if (user.save())
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	else
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));
}

		int pagesize = 20;
		String sql = "select name from sq_user ORDER BY RegDate desc";
		String username = ParamUtil.get(request, "username");
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		JdbcTemplate jt = new JdbcTemplate();
		ResultIterator ri = null;
		String type = ParamUtil.get(request, "type");
		String what = ParamUtil.get(request, "what");
		String groupCode = ParamUtil.get(request, "groupCode");
		if (op.equals("search")) {
			if (type.equals("userName")) {
				if (groupCode.equals(""))
					sql = "select name from sq_user where nick like "+StrUtil.sqlstr("%"+what+"%")+" ORDER BY RegDate desc";
				else
					sql = "select name from sq_user where nick like "+StrUtil.sqlstr("%"+what+"%")+" and group_code=" + StrUtil.sqlstr(groupCode) + " ORDER BY RegDate desc";									
				ri = jt.executeQuery(sql, curpage, pagesize);
			}
			else if (type.equals("arrested")) {
				if (groupCode.equals(""))
					sql = "select name from sq_user where nick like ? and releasetime>? ORDER BY RegDate desc";
				else
					sql = "select name from sq_user where nick like ? and releasetime>? and group_code=" + StrUtil.sqlstr(groupCode) + " ORDER BY RegDate desc";
				ri = jt.executeQuery(sql, new Object[] {"%" + what + "%", "" + new java.util.Date().getTime()}, curpage, pagesize);
			}
			else if (type.equals("invalid")) {
				if (groupCode.equals(""))
					sql = "select name from sq_user where nick like ? and isValid=0 ORDER BY RegDate desc";
				else
					sql = "select name from sq_user where nick like ? and isValid=0 and group_code=" + StrUtil.sqlstr(groupCode) + " ORDER BY RegDate desc";
				ri = jt.executeQuery(sql, new Object[] {"%" + what + "%"}, curpage, pagesize);
			}
			else if (type.equals("ispolice")) {
				if (groupCode.equals(""))
					sql = "select name from sq_user where nick like ? and ispolice=1 ORDER BY RegDate desc";
				else
					sql = "select name from sq_user where nick like ? and ispolice=1 and group_code=" + StrUtil.sqlstr(groupCode) + " ORDER BY RegDate desc";
				ri = jt.executeQuery(sql, new Object[] {"%" + what + "%"}, curpage, pagesize);
			}
			else if (type.equals("needCheck")) {
				if (groupCode.equals(""))
					sql = "select name from sq_user where nick like ? and check_status=" + UserDb.CHECK_STATUS_NOT + " ORDER BY RegDate desc";
				else
					sql = "select name from sq_user where nick like ? and check_status=" + UserDb.CHECK_STATUS_NOT + " and group_code=" + StrUtil.sqlstr(groupCode) + " ORDER BY RegDate desc";
				ri = jt.executeQuery(sql, new Object[] {"%" + what + "%"}, curpage, pagesize);
			}
		}
		else {
			ri = jt.executeQuery(sql, curpage, pagesize);
		}

%>
<table width="100%" border="0">
	<form id=formsearch name=formsearch action="?op=search" method=post>
        <tr>
        <td align="center"><lt:Label res="res.label.forum.admin.user_m" key="by"/> 
		  <select name="type">
		  <option value="userName"><lt:Label res="res.label.forum.admin.user_m" key="user_name"/></option>
		  <option value="arrested"><lt:Label res="res.label.forum.admin.user_m" key="user_in_prison"/></option>
		  <option value="invalid"><lt:Label res="res.label.forum.admin.user_m" key="user_invalid"/></option>
		  <option value="ispolice"><lt:Label res="res.label.forum.admin.user_m" key="user_police"/></option>
		  <option value="needCheck"><lt:Label res="res.label.forum.admin.user_m" key="user_need_check"/></option>
		  </select>
			<lt:Label res="res.label.forum.admin.user_m" key="user_group"/>
			<select name="groupCode">
            <%
			UserGroupDb ugroup = new UserGroupDb();
			Vector result = ugroup.list();
			Iterator ir = result.iterator();
			String opts = "";
			while (ir.hasNext()) {
				ugroup = (UserGroupDb) ir.next();
				opts += "<option value=" + ugroup.getCode() + ">" + ugroup.getDesc() + "</option>";
			}
			%>
			<option value=""><lt:Label res="res.label.forum.admin.user_m" key="all"/></option>
                <%=opts%>
          </select>		  
          <input name="what" type="text" class="singleboarder">
          &nbsp; 
          <input name="Submit" type="submit" class="singleboarder" value="<lt:Label res="res.label.forum.admin.user_m" key="search"/>">
          </td>
        </tr></form>
  </table>
<%if (op.equals("search")) {%>  
  <script>
  formsearch.type.value = "<%=type%>";
  formsearch.what.value = "<%=what%>";
  formsearch.groupCode.value = "<%=groupCode%>";
  </script>
<%}%>
  <div align="center"></div>
<%		
		int credit = 0;
			
		ResultRecord rr = null;
		// PageConn pageconn = new PageConn(Global.defaultDB, curpage, pagesize);
		paginator.init(jt.getTotal(), pagesize);
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}%>
  <table width="98%" border="0" align="center" class="p9">
    <tr>
      <td align="right"><%=paginator.getPageStatics(request)%></td>
    </tr>
  </table>    
  <TABLE width="98%" 
border=0 align=center cellPadding=2 cellSpacing=1 bgcolor="#edeced">
    <TBODY>
      <TR align=center bgColor=#f8f8f8> 
        <TD width=2% height=23 bgcolor="#E2E0DC"><font color="#525252">&nbsp;</font></TD>
        <TD width=22% bgcolor="#E2E0DC"><font color="#525252"><lt:Label res="res.label.forum.admin.user_m" key="user_name"/></font></TD>
        <TD width=5% height=23 bgcolor="#E2E0DC"><font color="#525252">
        <lt:Label res="res.label.forum.admin.user_m" key="gender"/></font></TD>
        <TD width=7% height=23 bgcolor="#E2E0DC"><font color="#525252">QQ</font></TD>
        <TD width=9% bgcolor="#E2E0DC"><lt:Label res="res.label.forum.admin.user_m" key="police"/></TD>
        <TD width=7% bgcolor="#E2E0DC"><font color="#525252"><lt:Label res="res.label.forum.admin.user_m" key="credit"/></font></TD>
        <TD width=10% height=23 bgcolor="#E2E0DC"><font color="#525252"><lt:Label res="res.label.forum.admin.user_m" key="reg_date"/></font></TD>
        <TD width=10% bgcolor="#E2E0DC"><lt:Label res="res.label.forum.admin.user_m" key="user_group"/></TD>
        <TD width=6% bgcolor="#E2E0DC"><lt:Label res="res.label.forum.admin.user_m" key="user_in_prison"/></TD>
        <TD width=11% bgcolor="#E2E0DC">IP</TD>
        <TD width=11% bgcolor="#E2E0DC"><lt:Label key="op"/></TD>
      </TR>
      <%		
String id="",name="",RegDate="",Gender="",OICQ="",State="",myface="",arrestreason="",arrestpolice="";
Date arresttime = null;
int layer = 1,ispolice=0,arrestday=0;
int i = 0;
String RealPic = "";
UserDb user = new UserDb();
UserGroupMgr ugm = new UserGroupMgr();
while (ri.hasNext()) {
 	    rr = (ResultRecord)ri.next(); 
		i++;
		name = rr.getString(1);
		user = user.getUser(name);
		RegDate = DateUtil.format(user.getRegDate(), "yyyy-MM-dd");
		Gender = user.getGender();
		if (Gender.equals("M"))
			Gender = "男";
		else if (Gender.equals("F"))
			Gender = "女";
		else
			Gender = "不详";
		
		OICQ = StrUtil.getNullString(user.getOicq());
		State = user.getState();
		if (State.equals("0"))
			State = "不详";
		RealPic = StrUtil.getNullString(user.getRealPic());
		myface = StrUtil.getNullString(user.getMyface());
		ispolice = user.getIsPolice();
		arrestday = user.getArrestDay();
		arrestreason = user.getArrestReason();
		arresttime = user.getArrestTime();
		arrestpolice = StrUtil.getNullString(user.getArrestPolice());
		credit = user.getCredit();
%>
      <TR align=center onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" class="tbg1"> 
        <TD height=23 align="left"> &nbsp; <%if (myface.equals("")) {%> <img src="../images/face/<%=RealPic%>" width=16 height=16> 
          <%}else{%> <img src="../../images/myface/<%=myface%>" width=16 height=16> 
          <%}%>	      </TD>
        <TD height=23 align="left"><a href="../../userinfo.jsp?username=<%=StrUtil.UrlEncode(StrUtil.toHtml(name))%>"><%=user.getNick()%></a>
          <input type=hidden name=username value="<%=name%>">
          <input type=hidden name=CPages value="<%=curpage%>"></TD>
        <TD width=5% height=23><%=Gender%></TD>
        <TD width=7% height=23><%=OICQ%></TD>
        <TD width=9%>
		<%
		if (ispolice>0)
			out.println("<font color=red>" + SkinUtil.LoadString(request, "yes") + "</font>[<a href='user_m.jsp?op=setpolice&value=0&CPages="+curpage+"&username="+StrUtil.UrlEncode(name,"utf-8")+"'>" + SkinUtil.LoadString(request, "no") + "</a>]");
		else
			out.println(SkinUtil.LoadString(request, "no") + "[<a href='user_m.jsp?op=setpolice&value=1&CPages="+curpage+"&username="+StrUtil.UrlEncode(name,"utf-8")+"'>" + SkinUtil.LoadString(request, "yes") + "</a>]");
		%>		</TD>
        <TD width=7%><%=credit%></TD>
        <TD width=10% height=23><%=RegDate%></TD>
        <TD width=10%>
		<%
		  UserGroupDb ugd = user.getUserGroupDb();
		  out.print(ugd.getDesc());
		%>		</TD>
        <TD width=6%><%
		Calendar c1 = fdate.add(arresttime, arrestday);//释放日期
		Calendar c2 = Calendar.getInstance();//当前日期
		if (fdate.compare(c1,c2)==1)
			out.println("<font color=red>" + SkinUtil.LoadString(request, "yes") + "</font>");
		else
			out.println(SkinUtil.LoadString(request, "no"));
		%>        </TD>
        <TD width=11%><%=user.getIp()%></TD>
        <TD width=11% height=23>&nbsp;          <a href="user_modify.jsp?username=<%=StrUtil.UrlEncode(name)%>&privurl=<%=privurl%>"><lt:Label res="res.label.forum.admin.user_m" key="manage"/></a></TD>
      </TR>
<%}%>
    </TBODY>
  </TABLE>
	
  <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td height="23" valign="baseline"> <div align="right"> 
          <%
	  String querystr = "op=" + op + "&username=" + StrUtil.UrlEncode(username) + "&type=" + type + "&what=" + StrUtil.UrlEncode(what) + "&groupCode=" + StrUtil.UrlEncode(groupCode);
 	  out.print(paginator.getPageBlock(request, "user_m.jsp?"+querystr));
	  %>
	</div>	  </td>
    </tr>
  </table>
</div>
</body>
<SCRIPT language=javascript>
<!--

//-->
</script>
</html>
