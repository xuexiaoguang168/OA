<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../inc/inc.jsp" %>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.Global"%>
<%@ page import="com.redmoon.forum.BoardManagerDb"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="pragma" content="no-cache">
<link rel="stylesheet" href="../../common.css">
<LINK href="default.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.forum.admin.manager_m" key="set_manager"/></title>
<script language="JavaScript">
<!--
function validate() {
	if  (document.addform.name.value=="")
	{
		alert("<lt:Label res="res.label.forum.admin.manager_m" key="input_name"/>");
		document.addform.name.focus();
		return false ;
	}
}

function checkdel(frm) {
 if(!confirm("<lt:Label key="confirm_del"/>"))
	 return;
 frm.op.value="del";
 frm.submit();
}
//-->
</script>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<%
if (!privilege.isMasterLogin(request)) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String boardcode = ParamUtil.get(request, "boardcode");
if (boardcode==null || boardcode.equals("")) { 
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, SkinUtil.ERR_ID)));
	return;
}
String boardname = ParamUtil.get(request, "boardname");
String ssort = ParamUtil.get(request, "sort");
int sort = 0;
if (StrUtil.isNumeric(ssort))
	sort = Integer.parseInt(ssort);
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head"><lt:Label res="res.label.forum.admin.manager_m" key="set_manager"/></td>
  </tr>
</table>
<br>
<table width="98%" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead"><lt:Label res="res.label.forum.admin.manager_m" key="board"/> - <%=boardname%></td>
  </tr>
  <tr> 
    <td valign="top"><table width="100%" border='0' cellspacing='0' cellpadding='0'>
        <tr > 
          <td width="100%" bgcolor="#eeeeee">
<%
BoardManagerDb bmd = new BoardManagerDb();
String id="",name="";
String op = ParamUtil.get(request, "op");
if (!op.equals(""))
{
	name = ParamUtil.get(request, "name");
	if (op.equals("add"))
	{
		UserDb user = new UserDb();
		user = user.getUserDbByNick(name);
		if (user==null || !user.isLoaded()) {
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "res.label.forum.admin.manager_m", "user_not_exist") + name));
		}
		else {
			bmd.setName(user.getName());
			bmd.setBoardCode(boardcode);
			bmd.setSort(sort);
			boolean re = bmd.create();
			if (!re)
				out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));	
		}
	}
	if (op.equals("edit")) {
		UserDb user = new UserDb();
		user = user.getUserDbByNick(name);
		if (user==null || !user.isLoaded()) {
			out.print(StrUtil.Alert(SkinUtil.LoadString(request, "res.label.forum.admin.manager_m", "user_not_exist") + name));		
			return;
		}
		else {
			bmd = bmd.getBoardManagerDb(boardcode, user.getName());
			bmd.setSort(sort);
			boolean re = bmd.save();
			if (!re)
				out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));
			else
				out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));			
		}
	}
	if (op.equals("del")) {
		UserDb user = new UserDb();
		user = user.getUserDbByNick(name);	
		bmd = bmd.getBoardManagerDb(boardcode, user.getName());
		boolean re = bmd.del();	
		if (!re)
			out.println(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_fail")));	
	}
}

	String sql = "SELECT boardcode,name FROM sq_boardmanager where boardcode="+StrUtil.sqlstr(boardcode) + " order by sort";
	Vector v = bmd.list(sql);
	Iterator ir = v.iterator();
	int i = 0;
	UserMgr um = new UserMgr();
	while (ir.hasNext()) { 
		bmd = (BoardManagerDb)ir.next();
	%>
	<table width="98%" align="center">
        <%
			name = bmd.getName();
			UserDb ud = um.getUser(name);
			sort = bmd.getSort();
			i++;
		%>
              <FORM METHOD=POST id="form<%=i%>" name="form<%=i%>" ACTION='manager_m.jsp'>
                <tr>
                  <td width='7%'> 
                  <lt:Label res="res.label.forum.admin.manager_m" key="nick"/></td>
                  <td width='26%'>
				  <input readonly type=hidden value="<%=ud.getNick()%>" name="name">
				  <%=ud.getNick()%>
                    <input name="boardcode" type="hidden" value="<%=boardcode%>">
                    <input name="boardname" type="hidden" value="<%=boardname%>">
                  <input type=hidden name=op value="edit"></td>
                  <td width='14%'><lt:Label res="res.label.forum.admin.manager_m" key="orders"/> 
                  <input name="sort" type=text class="singleboarder" value="<%=sort%>" size=6></td>
                  <td align=left> 
                    <INPUT TYPE=submit name='edit' value='<lt:Label key="op_modify"/>' > 
                    &nbsp;&nbsp;
                  <INPUT TYPE=button value='<lt:Label key="op_del"/>' name='op_del' onclick='checkdel(form<%=i%>)'>                  </td>
                </tr>
              </FORM>
              <%
		}%>
            </table>
        <tr> 
          <FORM METHOD=POST ACTION="manager_m.jsp" name="addform">
            <td height="23" colspan=3 align="center" bgcolor="#eeeeee"><table width="98%">
              <tr>
                <td width="7%" align="left"><lt:Label res="res.label.forum.admin.manager_m" key="nick"/></td>
              <td width="26%" align="left"><input type="text" size=30 name="name" style="border:1pt solid #636563;font-size:9pt">
                <input name="boardname" type="hidden" value="<%=boardname%>">
				<input type=hidden name=op value="add">
                <input type=hidden name=boardcode value="<%=boardcode%>">
              </td>
                <td width="14%" align="left"><lt:Label res="res.label.forum.admin.manager_m" key="orders"/>
                <input name="sort" type="text" class="singleboarder" size=6>                </td>
                <td align="left"><input type="submit" name="add" value="<lt:Label key="op_add"/>" onClick="return  validate()"></td>
              </tr>
            </table>
            </td>
          </FORM>
        </tr>
      </TABLE></td>
  </tr>
</table>
</body>                                        
</html>                            
  