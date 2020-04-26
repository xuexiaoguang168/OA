<%@ page contentType="text/html; charset=gb2312"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>发邮件</title>
<link href="../common.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="0" topmargin="5">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String to = fchar.getNullStr(fchar.UnicodeToGB(request.getParameter("to")));
%>
<table width="" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="23" valign="bottom" background="../images/tab-b6-top.gif">　　　　　<span class="right-title">发 
      邮 件</span></td>
  </tr>
  <tr>
    <td valign="top" background="../images/tab-b-back.gif">
	<table width="84%" border="0" align="center" cellpadding="0" cellspacing="2">
        <form id=form1 enctype="MULTIPART/FORM-DATA" name="form1" action="sendmail_do.jsp" method="post">
          <tr> 
            <td align="right">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td width="21%" align="right">收件人：</td>
            <td width="79%"><input class="p1" size="40" name="to" value="<%=to%>"></td>
          </tr>
          <tr> 
            <td align="right">主　题：</td>
            <td><input class="p1" size="40" name="subject"></td>
          </tr>
          <tr> 
            <td align="right">附　件：</td>
            <td><input id="filename1" type=file size=40 name=filename2></td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
            <td><input id="filename2" type=file size=40 name=filename22></td>
          </tr>
          <tr> 
            <td align="right">&nbsp;</td>
            <td><input id="filename3" type=file size=40 name=filename23></td>
          </tr>
          <tr> 
            <td align="right">正&nbsp;&nbsp;文：</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><textarea class="p1" id="content" name="content" rows="20" wrap="physical" cols="65"></textarea></td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="submit" name="Submit" value="提交">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="reset" name="Submit2" value="重置">
            </td>
          </tr>
        </form>
      </table> 
      <p>&nbsp;</p></td>
  </tr>
  <tr> 
    <td height="9"><img src="../images/tab-b-bot.gif" height="9"></td>
  </tr>
</table>
</body>
</html>
