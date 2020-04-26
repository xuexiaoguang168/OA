<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="../inc/inc.jsp" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="wed, 26 Feb 1997 08:21:57 GMT">
<title>  </title>
<link rel="stylesheet" href="common.css">
<script language="JavaScript">
<!--
function validate()
{
	if  (document.addform.name.value=="")
	{
		alert(" ¼   Ϊ");
		document.addform.name.focus();
		return false ;
	}
}

function checkdel(frm)
{
 if(!confirm("  Ƿ  ퟀ���  "))
	 return;
 frm.op.value="del";
 frm.submit();
}
//-->
</script>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:setProperty name="privilege" property="defaulturl" value="../index.jsp"/>
<!-- 𣿶   :<jsp:getProperty name="privilege" property="defaulturl"   />-->
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="images/tab-b-top.gif"><span class="right-title">  
         ¼</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(fchar.makeErrMsg("     ʴ   "));
	return;
}
%>
      <table width="98%" border='0' align="center" cellpadding='0' cellspacing='0'>
        <tr> 
          <td width="110" height="310" colspan="2" valign="top"><table width="100%" border='0' cellspacing='0' cellpadding='0'>
              <tr > 
                <td width="100%" bgcolor="#F6F6F6"> <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/> 
<jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/> 
<%
String username = privilege.getUser(request);
String id="",name="";
int kind = 0;
String op = fchar.getNullString(request.getParameter("op"));
String sql = "";
if (!op.equals(""))
{
	boolean isvalid = true;
	id = request.getParameter("id");
	if (!fchar.isNumeric(id)) {
		out.print(" Ƿ!");
		isvalid = false;
	}
	name = fchar.UnicodeToGB(request.getParameter("name"));
	int rowcount = 0;
	if (op.equals("add") && isvalid)
	{
		sql = "insert into doc_type (id, name,kind,username) values ("+id+","+fchar.sqlstr(name)+",1,"+fchar.sqlstr(username)+")";
		rowcount = conn.executeUpdate(sql);
		if (rowcount==0)
			out.println(fchar.Alert("   δɹ ע    ퟀ���"));	
	}
	if (op.equals("edit") && isvalid)
	{
		sql = "update doc_type set name="+fchar.sqlstr(name)+" where id="+id;
		rowcount = conn.executeUpdate(sql);
		if (rowcount==0)
			out.println(fchar.Alert("   δɹ"));	
	}
	if (op.equals("del") && isvalid)
	{
		sql = "select id from document where typeid="+id;
		ResultSet rs = null;
		rs = conn.executeQuery(sql);
		boolean candel = true;
		if (rs!=null && rs.next()) {
			candel = false;
			out.print(fchar.Alert("     ļ ֹɾ!"));
		}
		if (rs!=null) {
			rs.close();
			rs = null;
		}
		if (candel) {
			sql = "delete doc_type where id="+id;
			rowcount = conn.executeUpdate(sql);
			if (rowcount==0)
				out.println(fchar.Alert("   δɹ"));	
		}
	}
}
ResultSet rs = null;
try {
	sql ="SELECT id,name FROM doc_type where username="+fchar.sqlstr(username);
	rs = conn.executeQuery(sql);
	if (rs==null)
		out.println("Ŀǰ   0");
	else { 
		int i = 0;
	%> 
                  <table width="456" align="left">
                    <% while (rs.next()){
			id = rs.getString(1);
			name = rs.getString(2);
			i++;
		%>
                    <FORM METHOD=POST id="form<%=i%>" name="form<%=i%>" ACTION='doctype_m.jsp'>
                      <tr> 
                        <td bgcolor=#F6F6F6 width='68%'> <INPUT TYPE=hidden name=op value="edit">	
                           
                            <input type=text name=id value="<%=id%>" size="5" readonly>
                           
                          <INPUT TYPE=text value="<%=name%>" name="name" style='border:1pt solid #636563;font-size:9pt' size=30>                          </td>
                        <td width="12%" align=center bgcolor=#F6F6F6> 
						<%if (kind==0) {%>
						<INPUT TYPE=submit name='edit' value=' ퟃ���' style='border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;'>
						<%}%> 
                        </td>
                        <td width="20%" align=center bgcolor=#F6F6F6> 
						<INPUT TYPE=button value=' ' name='del' style='border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;' onclick='checkdel(form<%=i%>)'> 
                        </td>
                      </tr>
                    </FORM>
                    <%
		}%>
                  </table>
                  <%}
}
catch (SQLException e) {
	out.println(e.getMessage());
}
finally {
	if (rs!=null) {
		rs.close(); rs = null;
	}
	if (conn!=null) {
		conn.close(); conn = null;
	}
}
%> 
              <tr> 
                <FORM METHOD=POST ACTION="doctype_m.jsp" name="addform">
                  <input type=hidden name=op value="add">
                  <td colspan=3 bgcolor="#F6F6F6"><table width="456" align="left">
                      <tr>
                        <td width="68%"> 
  <input type=text name=id value="" size="5">
   
<input type="text" size=30 name="name" style="border:1pt solid #636563;font-size:9pt"></td>
                        <td width="12%" align="center"><input type="submit" name="add" value=" " style="border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;" onClick="return  validate()"></td>
                        <td width="20%">&nbsp;</td>
                      </tr>
                    </table> 
                  </td>
                </FORM>
              </tr>
          </TABLE></td>
        </tr>
      </table></td>
  </tr>
  <tr> 
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>                                        
</html>                            
  