<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="../../../inc/inc.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.Conn"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.miniplugin.home.*"%>
<%@ page import="com.redmoon.forum.*"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<html><head>
<meta http-equiv="pragma" content="no-cache">
<LINK href="../../../admin/default.css" type=text/css rel=stylesheet>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>插件管理</title>
<script language="JavaScript">
<!--

//-->
</script>
<body bgcolor="#FFFFFF" topmargin='0' leftmargin='0'>
<jsp:useBean id="privilege" scope="page" class="cn.js.fan.module.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "forum.plugin"))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

HomeDb hd = new HomeDb();

String op = ParamUtil.get(request, "op");
if (op.equals("setHot")) {
	String hot = ParamUtil.get(request, "hot");
	hd.setHot(hot);
	if (hd.save())
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}
if (op.equals("setRecommandBoard")) {
	String recommandBoard = ParamUtil.get(request, "recommandBoard");
	hd.setRecommandBoard(recommandBoard);
	if (hd.save())
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}
if (op.equals("setRecommandMsg")) {
	String recommandMsg = ParamUtil.get(request, "recommandMsg");
	hd.setRecommandMsg(recommandMsg);
	if (hd.save())
		out.print(StrUtil.Alert("操作成功！"));
	else
		out.print(StrUtil.Alert("操作失败！"));
}
%>
<table width='100%' cellpadding='0' cellspacing='0' >
  <tr>
    <td class="head">管理首页</td>
  </tr>
</table>
<br>
<table width="98%" height="227" border='0' align="center" cellpadding='0' cellspacing='0' class="frame_gray">
  <tr> 
    <td height=20 align="left" class="thead">管理</td>
  </tr>
  <tr> 
    <td valign="top"><br>
      <table width="98%" align="center">
	  <form id=form1 name=form1 action="?op=setHot" method=post>
        <tr>
          <td width="88%" height="22"><strong>热点话题</strong>&nbsp;( 编号之间用，分隔 ) <br>
              <input type=text value="<%=StrUtil.getNullString(hd.getHot())%>" name="hot" style='border:1pt solid #636563;font-size:9pt' size=80>
            <br></td>
          <td width="12%"><input name="submit" type="submit" style="border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;" value=" 确 定 ">
            &nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td height="22" colspan="2"><%
							int[] v = hd.getHotIds();
							int hotlen = v.length;
							if (hotlen==0)
								out.print("无热点话题！");
							else {
								MsgDb md = new MsgDb();
								for (int k=0; k<hotlen; k++) {
									md = md.getMsgDb(v[k]);
									if (md.isLoaded()) {
										String color = StrUtil.getNullString(md.getColor());
										if (color.equals("")) {%>
										  <%=md.getId()%>:&nbsp;<a href="../../../showtopic.jsp?rootid=<%=md.getId()%>"><%=md.getTitle()%></a><BR>
										<%}else{%>
										  <%=md.getId()%>:&nbsp;<a href="../../../showtopic.jsp?rootid=<%=md.getId()%>"><font color="<%=color%>"><%=md.getTitle()%></font></a><BR>
										<%}%>
								<%	}
									else
										out.print("<font color=red>编号：" + v[k] + "的贴子不存在</red><BR>");
								}
							}%>			</td>
        </tr></form>
      </table>
      <br>
      <table width="98%" align="center">
        <form id=form1 name=form1 action="?op=setRecommandBoard" method=post>
          <tr>
            <td width="88%" height="22"><strong>社区纵横</strong>&nbsp;&nbsp;( 编号之间用，分隔 ) <br>
                <input type=text value="<%=StrUtil.getNullString(hd.getRecommandBoard())%>" name="recommandBoard" style='border:1pt solid #636563;font-size:9pt' size=80>
            <br></td>
            <td width="12%"><input name="submit2" type="submit" style="border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;" value=" 确 定 ">
            &nbsp;&nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td height="22" colspan="2"><%
							String[] vr = hd.getRecommandBoards();
							int rblen = vr.length;
							if (rblen==0)
								out.print("无推荐版块！");
							else {
								Directory dir = new Directory();
								Leaf lf = null;
								for (int k=0; k<rblen; k++) {
									lf = dir.getLeaf(vr[k]);
									if (lf!=null && lf.isLoaded()) {%>
								<%=lf.getCode()%>:&nbsp;<%=lf.getName()%><BR>
									<%}
									else
										out.print("<font color=red>编码：" + vr[k] + "的版块不存在</red><BR>");
								}
							}%>            </td>
          </tr>
        </form>
      </table>
      <br>
      <table width="98%" align="center">
        <form id=form1 name=form1 action="?op=setRecommandMsg" method=post>
          <tr>
            <td width="88%" height="22"><strong>社区推荐</strong>&nbsp;&nbsp;( 编号之间用，分隔 ) <br>
              <input type=text value="<%=StrUtil.getNullString(hd.getRecommandMsg())%>" name="recommandMsg" style='border:1pt solid #636563;font-size:9pt' size=80>
            <br></td>
            <td width="12%"><input name="submit3" type="submit" style="border:1pt solid #636563;font-size:9pt; LINE-HEIGHT: normal;HEIGHT: 18px;" value=" 确 定 ">
            &nbsp;&nbsp;&nbsp;</td>
          </tr>
          <tr>
            <td height="22" colspan="2"><%
							int[] mv = hd.getRecommandMsgs();
							int mlen = mv.length;
							if (mlen==0)
								out.print("无推荐话题！");
							else {
								MsgDb md = new MsgDb();
								for (int k=0; k<mlen; k++) {
									md = md.getMsgDb(mv[k]);
									if (md.isLoaded()) {
										String color = StrUtil.getNullString(md.getColor());
										if (color.equals("")) {%>
                <%=md.getId()%>:&nbsp;<a href="../../../showtopic.jsp?rootid=<%=md.getId()%>"><%=md.getTitle()%></a><BR>
                <%}else{%>
                <%=md.getId()%>:&nbsp;<a href="../../../showtopic.jsp?rootid=<%=md.getId()%>"><font color="<%=color%>"><%=md.getTitle()%></font></a><BR>
                <%}%>
                <%	}
									else
										out.print("<font color=red>编号：" + v[k] + "的贴子不存在</red><BR>");
								}
							}%>            </td>
          </tr>
        </form>
      </table>
      <br>
    <br>
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
  