<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.archive.*"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.oa.flow.*"%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<title>档案列表</title>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String action = ParamUtil.get(request, "action");

String cond = ParamUtil.get(request, "cond");
String what = ParamUtil.get(request, "what");

String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
}
%>
<TABLE width="98%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0 class="main">
  <TR valign="top" bgcolor="#FFFFFF">
    <TD width="" height="430" colspan="2" style="background-attachment: fixed; background-image: url(../images/bg_bottom.jpg); background-repeat: no-repeat">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=right-title>
				  &nbsp;档案列表 </TD>
              </TR>
            </TBODY>
          </TABLE>
          <table width="58%" border="0" align="center">
		  <form name=form1 action="?op=search" method=post>
            <tr>
              <td align="center">按
			    <select name="cond">
			  <option value="name">姓名</option>	
			  <option value="idcard">身份证</option>
			  <option value="xuelie">学历</option>
			  <option value="zhiwu">职务</option>
			    </select>
			    <input name="what">			  
			    <input type=submit value="搜索">	
				<script>
				form1.cond.value = "<%=cond.equals("")?"name":cond%>";
				</script>
				<a href="?action=invalid">显示已禁用用户</a></td>
            </tr>
		  </form>
          </table>
          <table border="0" cellspacing="1" width="100%" cellpadding="2" align="center">
            <tr align="center" bgcolor="#F2F2F2">
              <td width="15%" height="20" align=center>用户名</td>
              <td width="24%" align=center>真实姓名</td>
              <td width="19%" align=center>出生日期</td>
              <td width="28%" align=center>身份证</td>
              <td width="14%" align=center>操作</td>
            </tr>
        </table>
		<table width="100%"  border="0">
          <tr>
			<td>
<%
			UserArchiveDb uad = new UserArchiveDb();
			String sql = "select a.name from " + uad.getTableName() + " a, users u where a.name=u.name and u.isValid=1";
			if (action.equals("invalid"))
				sql = "select a.name from " + uad.getTableName() + " a, users u where a.name=u.name and u.isValid=0";
			
			if (op.equals("search")) {
				if (cond.equals("name")) {
					sql += " and a.name like " + StrUtil.sqlstr("%" + what + "%");
				}
				if (cond.equals("idcard")) {
					sql += " and a.IDCard like " + StrUtil.sqlstr("%" + what + "%");
				}
				if (cond.equals("xuelie")) {
					sql += " and a.xueLi like " + StrUtil.sqlstr("%" + what + "%");
				}
				if (cond.equals("zhiwu")) {
					sql += " and a.zhiWu like " + StrUtil.sqlstr("%" + what + "%");
				}
			}
			
			int pagesize = 10;
			Paginator paginator = new Paginator(request);
			int curpage = paginator.getCurPage();
						
			ListResult lr = uad.listResult(sql, curpage, pagesize);
			int total = lr.getTotal();
			Vector v = lr.getResult();
	        Iterator ir = null;
			if (v!=null)
				ir = v.iterator();

			paginator.init(total, pagesize);
			//设置当前页数和总页数
			int totalpages = paginator.getTotalPages();
			if (totalpages==0)
			{
				curpage = 1;
				totalpages = 1;
			}
			
			while (ir!=null && ir.hasNext()) {
				uad = (UserArchiveDb)ir.next();
			%>
			<table border="0" cellspacing="1" width="100%" cellpadding="2" align="center">
              <tr align="center">
                <td width="15%" height="20" align=center><%=uad.getName()%></td>
                <td width="24%" align=center><%=uad.getRealName()%></td>
                <td width="19%" align=center><%=DateUtil.format(uad.getBirthday(), "yyyy-MM-dd HH:mm")%></td>
                <td width="28%" align=center><%=uad.getIDCard()%></td>
                <td width="14%" align=center><a href="user_archive_modify.jsp?name=<%=StrUtil.UrlEncode(uad.getName())%>">维护</a></td>
              </tr>
            </table>
			<%
			}
			%>
			<table width="98%" border="0" class="p9">
              <tr>
                <td align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <%
				String querystr = "op=" + op + "&action=" + action + "&cond=" + StrUtil.UrlEncode(cond) + "&what=" + StrUtil.UrlEncode(what);
				out.print(paginator.getCurPageBlock("?"+querystr));
				%>
                  &nbsp;&nbsp;
                </b></td>
              </tr>
            </table></td>
          </tr>
        </table>
	</TD>
  </TR>
</TABLE>
</body>
<script>
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}
</script>
</html>