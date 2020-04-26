<%@ page contentType="text/html;charset=gb2312"%>
<html>
<head>
<title>审批流程管理</title>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="common.css" type="text/css">
<style type="text/css">
<!--
.flowspan {
	background: White;
	border: 1px solid Black;
	text-align: center;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 6px;
	padding-bottom: 6px;
	width: 200px;
	}
-->
</style>
<%@ include file="inc/nocache.jsp"%>

</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23" valign="bottom" background="images/tab-b-top.gif">　　　　　<span class="right-title">审 
      批 流 程</span></td>
  </tr>
  <tr>
    <td height="310" valign="top" background="images/tab-b-back.gif"><br>
      <%
String priv="upload";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String document_id = request.getParameter("document_id");
String title = fchar.UnicodeToGB(request.getParameter("title"));
if (document_id==null)
{
	out.println(fchar.makeErrMsg("文件标识为空！"));
	return;
}
%>
<jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/> <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/> 

      <table class=p9 width="80%" border="0" cellpadding="2" cellspacing="0" align="center">
          <tr bgcolor="#C4DAFF"> 
            <td width="100%" height="22" align="center" class="stable">审 批 流 程 
              状 态</td>
          </tr>
          <tr> 
            <td height="22" bgcolor="#F7F7F7" class="stable">文件标题 ：<%=title%> </td>
          </tr>
          <tr>
            <td align="center" bgcolor="#F7F7F7" class="stable"><%
		String sql,options="";
		boolean ischecked = false,ischecking=false;
		String checkdate = "";
		
		String[] arycolor = new String[17];
		arycolor[1] = "black";
        arycolor[2] = "blue";
        arycolor[3] = "Turquoise";
        arycolor[4] = "#00ff00";
        arycolor[5] = "Pink";
        arycolor[6] = "red";
        arycolor[7] = "yellow";
        arycolor[8] = "white";
        arycolor[9] = "DarkBlue";
        arycolor[10] = "Teal";
        arycolor[11] = "green";
        arycolor[12] = "Violet";
        arycolor[13] = "DarkRed";
        arycolor[14] = "#FFCC67";
        arycolor[15] = "#808080";
        arycolor[16] = "#C0C0C0";
		String color="red";
				
		sql = "select id,person,ischecked,color,ischecking,checkdate from doc_flow where document_id="+document_id+" and sort>-1 order by sort";
		ResultSet rs = conn.executeQuery(sql);
		//out.println("共有记录"+conn.getRows());
		while(rs.next())
		{
			ischecked = rs.getBoolean(3);
			color = arycolor[rs.getInt(4)];
			ischecking = rs.getBoolean(5);
			checkdate = rs.getString(6);
			if (checkdate!=null)
				checkdate = checkdate.substring(0,19);
			if (!ischecked)
			{
				if (!ischecking)
					out.print("<div><img src=images/nochecking.gif></img><br>"+rs.getString(2)+" <font style='BACKGROUND: "+color+"'>&nbsp;&nbsp;&nbsp;</font><br>未审批</div><img src=images/nextflow.gif>");
				else
					out.print("<div><img src=images/checking.gif></img><br>"+rs.getString(2)+" <font style='BACKGROUND: "+color+"'>&nbsp;&nbsp;&nbsp;</font><br><font color="+color+">审批中</font></div><img src=images/nextflow.gif>");
			}
			else
			{
				out.print("<div><img src=images/checked.gif></img><br>"+rs.getString(2)+" <font style='BACKGROUND: "+color+"'>&nbsp;&nbsp;&nbsp;</font><br><font color=red>已审批</font><br>审批时间:"+checkdate+"</div><img src=images/nextflow.gif>");
			}
		}
		if(conn.getRows()<=0)
		{
		out.println("<div class=flowspan>未设流程</div>");
		}
		else{
		out.println("<div><img src=images/endflow.gif></img></div>流程完成");
		}
		if (rs!=null) {
		rs.close();
		rs = null;
		}
		if (conn!=null) {
		conn.close();
		conn = null;
		}
		%></td>
          </tr>
      </table>
      
    </td>
  </tr>
  <tr>
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>