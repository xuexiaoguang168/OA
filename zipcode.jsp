<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�ޱ����ĵ�</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
</head>
<body leftmargin="0" topmargin="3">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil" />
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>
        <table width="100%" border="0" cellpadding="2" cellspacing="0" bgcolor="#C4DAFF" class="stable">
        <form name="form1" method="post" action="zipcode.jsp"> <tr> 
            <td height="20" class="stable">���С����š��ʱ��ѯ</td>
          </tr>
          <tr> 
            <td height="26" class="stable">��ѯ�ؼ��֣� 
              <input name="keyword" type="text" size=12 id="keyword"> 
              ��ѯѡ� <select name="searchmode" id="searchmode">
                <option value="1" selected>���ҳ����ʱ�</option>
                <option value="2">�ʱ���ҳ���</option>
                <option value="1">���ҳ�������</option>
                <option value="3">���Ų��ҳ���</option>
              </select> <input type="submit" name="Submit" value="�� ��"> <input type="reset" name="Submit2" value="�� д"> 
            </td>
          </tr></form>
        </table>
    </td>
  </tr>
  <tr>
    <td><table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#666666" bordercolordark="#FFFFFF" bgcolor="#d6d3ce">
      <tr>
        <td width="22%">
          <div align="center"><font color="#FF0000">ʡ������</font></div>
        </td>
        <td width="30%">
          <div align="center"><font color="#FF0000">��������</font></div>
        </td>
        <td width="26%">
          <div align="center"><font color="#FF0000">��������</font></div>
        </td>
        <td width="22%">
          <div align="center"><font color="#FF0000">�绰����</font></div>
        </td>
      </tr>
<%
String keyword = StrUtil.Unicode2GB(request.getParameter("keyword"));
if (keyword==null || keyword.trim().equals(""))
	;
else {
	Conn conn = new Conn(Global.defaultDB);
	try {
	 	  int searchmode = Integer.parseInt(request.getParameter("searchmode"));
		  String province = "";
		  String city = "";
		  String zip = "";
		  String yb = "";
		  String sql = "";
		  switch (searchmode)
		  {
		  	case 1:sql = "select province,city,postcode,qh from postcode where city="+fchar.sqlstr(keyword);
					break;
			case 2:sql = "select province,city,postcode,qh from postcode where postcode="+fchar.sqlstr(keyword);
					break;
			case 3:sql = "select province,city,postcode,qh from postcode where qh="+fchar.sqlstr(keyword);
					break;
			case 4:sql = "select province,city,postcode,qh from postcode where province="+fchar.sqlstr(keyword);
					break;
		  }
		  ResultSet rs = conn.executeQuery(sql);
		  if (rs!=null)
		  {
		  	while (rs.next())
			{ 
				province = rs.getString(1);
				city = rs.getString(2);
				zip = rs.getString(3);
				yb = rs.getString(4);
%>
      <tr>
        <td width='22%'><%=province%></td>
        <td width='30%' ><%=city%></td>
        <td width='26%' ><%=zip%></td>
        <td width='22%' ><%=yb%></td>
      </tr>
<% 			}
			rs.close();
			rs = null;
		  }
		}
		catch (Exception e) {
		  	out.print(e.getMessage());
		}
		finally {
			if (conn!=null) {
				conn.close();
				conn = null;
			}		  
		}
}

%>
    </table></td>
  </tr>
  <tr>
    <td align="center"><img src="images/chinamap.gif" width="469" height="367" border="0" usemap="#Map"></td>
  </tr>
</table>

<map name="Map">
<area shape="poly" coords="68,80" href="#">
<area shape="rect" coords="74,117,114,133" href="?searchmode=4&keyword=%D0%C2%BD%AE">
<area shape="rect" coords="76,217,117,232" href="?searchmode=4&keyword=%CE%F7%B2%D8">
<area shape="rect" coords="153,181,192,197" href="?searchmode=4&keyword=%C7%E0%BA%A3">
<area shape="rect" coords="224,135,288,152" href="?searchmode=4&keyword=%C4%DA%C3%C9%B9%C5">
<area shape="rect" coords="390,88,420,102" href="?searchmode=4&keyword=%BC%AA%C1%D6">
<area shape="rect" coords="368,112,396,128" href="?searchmode=4&keyword=%C1%C9%C4%FE">
<area shape="rect" coords="334,127,363,141" href="?searchmode=4&keyword=%B1%B1%BE%A9">
<area shape="rect" coords="318,131,332,160" href="?searchmode=4&keyword=%BA%D3%B1%B1">
<area shape="rect" coords="334,143,364,155" href="?searchmode=4&keyword=%CC%EC%BD%F2">
<area shape="rect" coords="293,154,309,182" href="?searchmode=4&keyword=%C9%BD%CE%F7">
<area shape="rect" coords="332,166,363,183" href="?searchmode=4&keyword=%C9%BD%B6%AB">
<area shape="rect" coords="245,159,264,188" href="?searchmode=4&keyword=%C4%FE%CF%C4">
<area shape="rect" coords="227,176,244,207" href="?searchmode=4&keyword=%B8%CA%CB%E0">
<area shape="rect" coords="205,227,243,245" href="?searchmode=4&keyword=%CB%C4%B4%A8">
<area shape="rect" coords="218,245,248,259" href="?searchmode=4&keyword=%D6%D8%C7%EC">
<area shape="rect" coords="270,192,286,222" href="?searchmode=4&keyword=%C9%C2%CE%F7">
<area shape="rect" coords="301,194,331,214" href="?searchmode=4&keyword=%BA%D3%C4%CF">
<area shape="poly" coords="339,210,349,203,364,236,351,237" href="?searchmode=4&keyword=%B0%B2%BB%D5">
<area shape="poly" coords="354,196,364,188,387,217,375,227" href="?searchmode=4&keyword=%BD%AD%CB%D5">
<area shape="rect" coords="292,225,323,242" href="?searchmode=4&keyword=%BA%FE%B1%B1">
<area shape="rect" coords="197,294,235,311" href="?searchmode=4&keyword=%D4%C6%C4%CF">
<area shape="rect" coords="250,271,279,286" href="?searchmode=4&keyword=%B9%F3%D6%DD">
<area shape="rect" coords="296,252,315,283" href="?searchmode=4&keyword=%BA%FE%C4%CF">
<area shape="rect" coords="331,250,347,280" href="?searchmode=4&keyword=%BD%AD%CE%F7">
<area shape="rect" coords="357,262,372,292" href="?searchmode=4&keyword=%B8%A3%BD%A8">
<area shape="rect" coords="266,300,298,318" href="?searchmode=4&keyword=%B9%E3%CE%F7">
<area shape="rect" coords="311,298,343,315" href="?searchmode=4&keyword=%B9%E3%B6%AB">
<area shape="rect" coords="306,347,337,363" href="?searchmode=4&keyword=%BA%A3%C4%CF">
<area shape="rect" coords="403,280,418,313" href="?searchmode=4&keyword=%CC%A8%CD%E5">
<area shape="rect" coords="370,233,396,249" href="?searchmode=4&keyword=%D5%E3%BD%AD">
<area shape="rect" coords="392,214,419,228" href="?searchmode=4&keyword=%C9%CF%BA%A3">
<area shape="rect" coords="384,47,424,62" href="?searchmode=4&keyword=%BA%DA%C1%FA%BD%AD">
</map>
</body>
</html>
