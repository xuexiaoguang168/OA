<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.task.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<LINK href="common.css" type=text/css rel=stylesheet>
<title>树形显示</title>
</head>
<body>
<div id="newdiv" name="newdiv">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
//安全验证
String priv = "read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String myname = privilege.getUser(request);

String querystring = fchar.getNullString(request.getQueryString());
String privurl = fchar.getUrl(request);

String rootid = fchar.getNullString(request.getParameter("id"));
if (rootid.equals(""))
{
	out.println(fchar.makeErrMsg("缺少标识！"));
	return;
}

String sql = "select id from task where rootid="+rootid+" ORDER BY orders";
TaskDb td = new TaskDb();
ListResult lr = td.listResult(sql);
Iterator ir = lr.getResult().iterator();

String initiator="",lydate="",content="",title="",person="";
int id;
int layer = 1,expression=0,type=0,isfinish=0;
int i = 1;
boolean isshow = false;
int showlayer = 0;
if (ir.hasNext())
{
	// 跳过根任务
	ir.next();
}
//写跟贴
while (ir.hasNext())
{
	i++;
	td = (TaskDb)ir.next();
	id = td.getId();
    TaskDb parentTd = td.getTaskDb(td.getParentId());
	layer = td.getLayer();
	initiator = td.getInitiator();
	expression = td.getExpression();
	lydate = DateUtil.format(td.getMyDate(), "yyyy-MM-dd HH:mm:ss");
	title = td.getTitle();
	type = td.getType();
	person = td.getPerson();
	isfinish = td.getStatus();
	if (isshow)
	{
	  	if (layer<=showlayer)
		isshow = false;
	}
	
    if (initiator.equals(myname) || person.equals(myname) || myname.equals(parentTd.getInitiator()))// 可以看到所属的分支
	{
		isshow = true;
		showlayer = layer;
	}	
%>
<table cellspacing=0 cellpadding=0 width="100%" align=center 
border=0>
  <tbody> 
  <tr> 
    <td noWrap align=left bgcolor=#f8f8f8 height="13"> 
      <%
	int pagesize = 10;
	layer = layer-1;
	for (int k=1; k<=layer-1; k++)
	{ %>
      <img src="" width=18 height=1>
    <%}%>
          <img src="forum/images/bbs_dir/joinbottom.gif" width="18" height="16"> 
          <%
		  if (type==TaskDb.TYPE_TASK || type==TaskDb.TYPE_SUBTASK) {
			  if (isfinish==TaskDb.STATUS_FINISHED) {%>
			  <img src="images/task/icon-yes.gif"> 
			  <%}else if (isfinish==TaskDb.STATUS_NOTFINISHED){%>
			  <img src="images/task/icon-notyet.gif"> 
			  <%}else {%>
			  <img src="images/task/icon-no.gif"> 
			  <%}
		  }
	  if (isshow) 
	  {
		  if (type==0)
			out.println("<img src=images/task/icon-task.gif>");
		  else if (type==1)
			out.println("<img src=images/task/icon-subtask.gif>");
		  else if (type==2)
			out.println("<img src=images/task/icon-result.gif>");
		  else if (type==3)
			out.println("<img src=images/task/icon-hurry.gif>");
		  else
			out.println("<img src=images/task/icon-task.gif>");
	  %>	  
		  <%if (expression!=0) { %>
		  <img align="absmiddle" src="forum/images/emot/em<%=expression%>.gif" border=0>
		  <%}%>
		  <a href="task_show.jsp?rootid=<%=rootid%>&showid=<%=id%>"><%=title%></a>&nbsp;
		  <%if (type==0 || type==1 || type==3) {%>
			  [&nbsp;
			  <%
			  UserDb ud = new UserDb();
			  ud = ud.getUserDb(initiator);
			  out.print(ud.getRealName());
			  %>
			  →
			  <%
			  ud = ud.getUserDb(person);
			  out.print(ud.getRealName());
			  %>
			  <%=lydate%>&nbsp;]
		  <%}else if (type==2) {%>
		  	  [&nbsp;汇报人：<%
			  UserDb ud = new UserDb();
			  ud = ud.getUserDb(initiator);
			  out.print(ud.getRealName());
			  %>]
		  <%}%>		  
	   <%}
	   else
	   		out.print("............");
	   %>
	  </td>
  </tr>
  </tbody> 
</table>
<%
}%>
</div>
</body>
<SCRIPT language=javascript>
<!--
function trim(str){
    	var i = 0;
        while ((i < str.length)&&((str.charAt(i) == " ")||(str.charAt(i) == "　"))){i++;}
    	var j = str.length-1;
    	while ((j >= 0)&&((str.charAt(j) == " ")||(str.charAt(j) == "　"))){j--;}
    	if( i > j ) 
    		return "";
    	else
    		return str.substring(i,j+1);
}
if (trim(newdiv.innerHTML)!="")
{
	window.parent.followDIV<%=rootid%>.innerHTML = newdiv.innerHTML;
}
window.parent.followImg<%=rootid%>.loaded = "yes";
//-->
</script>
</html>
