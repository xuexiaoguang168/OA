<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.module.cms.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>测试board无限级目录</title>
<LINK href="../common.css" type=text/css rel=stylesheet>
<LINK href="default.css" type=text/css rel=stylesheet>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.fan.redmoon.Privilege"/>
<%
if (!privilege.isAdmin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String root_code = ParamUtil.get(request, "root_code");
if (root_code.equals(""))
{
	root_code = "root";
}
Leaf leaf = new Leaf(root_code);
String root_name = leaf.getName();
int root_layer = leaf.getLayer();
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理&nbsp;<%=root_name%>&nbsp;&nbsp;<a href="dir_sub.jsp?root_code=<%=StrUtil.UrlEncode(root_code)%>">树形模式</a></td>
  </tr>
</table>
<br>
<TABLE class="frame_gray"  
cellSpacing=0 cellPadding=0 width="95%" align=center>
  <TBODY>
    <TR>
      <TD height=200 valign="top" bgcolor="#FFFBFF">
<table class="tbg1" cellspacing=0 cellpadding=0 width="100%" align=center onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" 
border=0>
          <tbody>
            <tr>
              <td width="6%" height="13" align=left nowrap>&nbsp;              </td>
            <td width="79%" align=left nowrap><a href="document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(root_code)%>&dir_name=<%=StrUtil.UrlEncode(root_name)%>"><%=root_name%></a>&nbsp;&nbsp;&nbsp;&nbsp; </td>
              <td width="15%" align=right nowrap>&nbsp;
			  </td>
            </tr>
          </tbody>
        </table>
<%
ResultIterator ri = leaf.getAllChild();
ResultRecord rs = null;
String code="",name="",add_date="",description="";
int layer = 1;
int i = 0;

		//写跟贴
		while (ri.hasNext())
		{
		  rs = (ResultRecord) ri.next();
		  i++;
		  code = rs.getString("code");
		  name = rs.getString("name");
		  layer = rs.getInt("layer");
		  add_date = rs.getString("add_date");
		  description = rs.getString("description");
	  %>
        <table class="tbg1" cellspacing=0 cellpadding=0 width="100%" align=center onMouseOver="this.className='tbg1sel'" onMouseOut="this.className='tbg1'" 
border=0>
          <tbody>
            <tr>
              <td width="6%" height="13" align=left nowrap>&nbsp;			  </td>
            <td width="79%" align=left nowrap><%for (int k=1; k<=layer-root_layer-1; k++){%>
              <img src="" width=18 height=1>
              <%}%>
              <img src="images/i_plus-2-3.gif" align="absmiddle"> <a href="document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(code)%>&dir_name=<%=StrUtil.UrlEncode(name)%>"><%=name%></a>&nbsp;&nbsp;&nbsp;&nbsp; </td>
              <td width="15%" align=right nowrap>&nbsp;
			  </td>
            </tr>
          </tbody>
        </table>
      <%
		}
%></TD>
    </TR>
  </TBODY>
</TABLE>
</body>
</html>
