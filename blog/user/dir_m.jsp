<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.blog.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<LINK href="../../common.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><lt:Label res="res.label.blog.user.dir" key="title"/></title>
<script language="JavaScript">
<!--
function form1_onsubmit() {
	if (form1.catalogCode.value=="not") {
		alert("<lt:Label res="res.label.blog.user.dir" key="alert"/>");
		return false;
	}
}
//-->
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
.STYLE2 {color: #FFFFFF}
-->
</style>
<body topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="dir" scope="page" class="com.redmoon.blog.UserDirDb"/>
<%
if (!privilege.isUserLogin(request))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String userName = ParamUtil.get(request, "userName");
if (userName.equals("")) {
	out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.dir", "not_name")));
	return;
}
String user = privilege.getUser(request);
if (!userName.equals(user)) {
	if (!privilege.isMasterLogin(request)) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.dir", "not_priv")));
		return;
	}
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	String code = "";
	String dirName = "";
	String catalogCode = "";
	boolean re = false;
	try {
		code = ParamUtil.get(request, "code");
		dirName = ParamUtil.get(request, "dirName");
		catalogCode = ParamUtil.get(request, "catalogCode");
		boolean isValid = true;
		if (code.equals("") || dirName.equals("") || catalogCode.equals("")) {
			out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.dir", "code_name_alert")));
			isValid = false;
		}
		if (isValid) {
			UserDirDb asd = new UserDirDb();
			asd.setCode(code);
			asd.setDirName(dirName);
			asd.setCatalogCode(catalogCode);
			asd.setUserName(userName);
			re = asd.create();
		}
	}
	catch (ResKeyException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
}

if (op.equals("modify")) {
	String code = "";
	String dirName = "";
	String catalogCode = "";
	boolean re = false;
	try {
		code = ParamUtil.get(request, "code");
		dirName = ParamUtil.get(request, "dirName");
		catalogCode = ParamUtil.get(request, "catalogCode");
		boolean isValid = true;
		if (code.equals("") || dirName.equals("") || catalogCode.equals("")) {
			out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.dir", "code_name_alert")));
		}
		if (isValid) {
			UserDirDb asd = new UserDirDb();
			asd = asd.getUserDirDb(privilege.getUser(request), code);
			asd.setCode(code);
			asd.setDirName(dirName);
			asd.setCatalogCode(catalogCode);
			asd.setUserName(userName);
			re = asd.save();
		}
	}
	catch (ResKeyException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
}

if (op.equals("del")) {
	String code = "";
	boolean re = false;
	try {
		code = ParamUtil.get(request, "code");
		boolean isValid = true;
		if (code.equals("")) {
			out.print(StrUtil.Alert(SkinUtil.LoadString(request,"res.label.blog.user.dir", "code_name_alert")));
		}
		if (isValid) {
			UserDirDb asd = new UserDirDb();
			asd = asd.getUserDirDb(privilege.getUser(request), code);
			int count = asd.getMsgCountOfDir(userName, code);
			if (count>0) {
				String str = SkinUtil.LoadString(request,"res.label.blog.user.dir", "del_alert");
				str = StrUtil.format(str, new Object[] {Global.AppName});
				out.print(StrUtil.Alert(str));
			}
			else {
				asd.setCode(code);
				asd.setUserName(userName);
				re = asd.del();
			}
		}
	}
	catch (ResKeyException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert(SkinUtil.LoadString(request, "info_op_success")));
	}
}
%>
<br>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <table width="86%"  border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#666666" class="tableframe_gray">
      <tr align="center">
        <td width="22%" height="26" bgcolor="#617AA9"><span class="STYLE2"><lt:Label res="res.label.blog.user.dir" key="list_name"/></span></td>
        <td width="29%" height="26" bgcolor="#617AA9"><span class="STYLE2"><lt:Label res="res.label.blog.user.dir" key="class"/></span></td>
      <td width="30%" bgcolor="#617AA9"><span class="STYLE2"><lt:Label res="res.label.blog.user.dir" key="operate"/></span></td>
      </tr>
      <tr align="center" bgcolor="#FFFFFF">
        <td width="22%" height="22"><lt:Label res="res.label.blog.user.dir" key="my_article"/></td>
        <td width="29%" height="22"><lt:Label res="res.label.blog.user.dir" key="acquiescence"/></td>
      <td width="30%"><a href="listtopic.jsp?blogUserDir=<%=UserDirDb.DEFAULT%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label res="res.label.blog.user.dir" key="manage"/></a>&nbsp;&nbsp;&nbsp;<a href="../../forum/addtopic_new.jsp?addFlag=blog&boardcode=<%=com.redmoon.forum.Leaf.CODE_BLOG%>&blogUserDir=<%=UserDirDb.DEFAULT%>"><lt:Label res="res.label.blog.user.dir" key="issue_article"/></a></td>
      </tr>
<%
UserDirDb sb1 = new UserDirDb();
Vector v = sb1.list(userName);
Iterator ir = v.iterator();
int i = 2;
while (ir.hasNext()) {
	UserDirDb as = (UserDirDb)ir.next();
	i++;
%>
	<form id="form<%=i%>" name="form<%=i%>" action="?op=modify" method="post">
      <tr align="center" bgcolor="#FFFFFF">
        <td height="22"><input type=hidden name=code value="<%=as.getCode()%>">
        <input name=dirName value="<%=as.getDirName()%>" size=22></td>
        <td height="22">
		  <script>
		  var bcode<%=i%> = "<%=as.getCatalogCode()%>";
		  </script>
		  <select name="catalogCode" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' <lt:Label res="res.label.blog.user.dir" key="not_choose"/>'); this.value=bcode<%=i%>; return false;}">
                <option value="not" selected><lt:Label res="res.label.blog.user.dir" key="select_title"/></option>
                <%
				Directory directory = new Directory();
				Leaf lf = directory.getLeaf("root");
				DirectoryView dv = new DirectoryView(lf);
				dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
				%>
            </select>		
			<script>
			form<%=i%>.catalogCode.value = "<%=as.getCatalogCode()%>";
			</script>		</td>
      <td height="22"><input type=hidden name="userName" value="<%=userName%>">
      <input type="submit" name="Submit" value="<lt:Label key="op_modify"/>">
        <a href="listtopic.jsp?userName=<%=StrUtil.UrlEncode(userName)%>&blogUserDir=<%=StrUtil.UrlEncode(as.getCode())%>"><lt:Label res="res.label.blog.user.dir" key="manage"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="?op=del&code=<%=StrUtil.UrlEncode(as.getCode())%>&userName=<%=StrUtil.UrlEncode(userName)%>"><lt:Label key="op_del"/></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="../../forum/addtopic_new.jsp?addFlag=blog&boardcode=<%=com.redmoon.forum.Leaf.CODE_BLOG%>&blogUserDir=<%=StrUtil.UrlEncode(as.getCode())%>"><lt:Label res="res.label.blog.user.dir" key="issue_article"/></a></td>
      </tr></form>
<%}%>	  
    </table>
      <br>
      <table width="86%"  border="0" align="center" cellpadding="3" cellspacing="0" class="frame_gray">
	  <form action="?op=add" method=post id=form1 name=form1 onSubmit="return form1_onsubmit()">
        <tr>
          <td width="192" align="right">
		  <script>
		  var bcode = "not";
		  </script>
		  <select name="catalogCode" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); this.value=bcode; return false;}">
                      <option value="not" selected><lt:Label res="res.label.blog.user.dir" key="select_title"/></option>
                <%
				Directory directory = new Directory();
				Leaf lf = directory.getLeaf("root");
				DirectoryView dv = new DirectoryView(lf);
				dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
				%>
            </select></td>
          <td width="636" align="left">
		  &nbsp;
		  <input name=code type="hidden" size=4 value="<%=cn.js.fan.util.RandomSecquenceCreator.getId(20)%>">
&nbsp;<lt:Label res="res.label.blog.user.dir" key="list_name"/>	
<input name=dirName size=8>
<input type="submit" name="Submit" value="<lt:Label key="op_add"/>"><input type=hidden name="userName" value="<%=userName%>"></td>
        </tr>
        <tr>
          <td height="22" colspan="2" align="center">(<lt:Label res="res.label.blog.user.dir" key="explain"/>)</td>
          </tr>
	  </form>
      </table>
      <br></td>
  </tr>
</table>
</td> </tr>             
      </table>                                        
       </td>                                        
     </tr>                                        
 </table>                                        
                               
</body>                                        
</html>                            
  