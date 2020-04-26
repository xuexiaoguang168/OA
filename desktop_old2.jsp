<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "com.redmoon.oa.person.*"%>
<%@ page import = "com.redmoon.oa.task.*"%>
<%@ page import = "com.redmoon.oa.message.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ include file="inc/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的办公桌</title>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<%
String user = privilege.getUser(request);
String pwd = privilege.getPwd(request);
int i = 0;

Calendar cal = Calendar.getInstance();
int curday = cal.get(cal.DAY_OF_MONTH);
int curmonth = cal.get(cal.MONTH)+1;
int curyear = cal.get(cal.YEAR);
String curdate = curyear+"-"+curmonth+"-"+curday;

String myname = privilege.getUser(request);
String fromwhom = "";
%>
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

//--------------展开任务----------------------------
function loadThreadFollow(b_id,t_id,getstr){
	var targetImg2 =eval("document.all.followImg" + t_id);
	var targetTR2 =eval("document.all.follow" + t_id);
	if (targetImg2.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg2)){
		if (targetTR2.style.display!="")
		{
			targetTR2.style.display="";
			targetImg2.src="sq/forum/images/minus.gif";
			if (targetImg2.loaded=="no"){
				document.frames["hiddenframe"].location.replace("task_tree.jsp?id="+b_id+getstr);
			}
		}else{
			targetTR2.style.display="none";
			targetImg2.src="sq/forum/images/plus.gif";
		}
	}
}
//-->
</script>

<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
<%
if (!privilege.isUserLogin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
	<td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
      <tr>
        <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/i_sound.gif" width="21" height="16" align="absmiddle"><strong> 公共通知</strong></td>
        <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="doc_list_notice.jsp?dir_code=notice" class="desktopwhite">全部通知</a></span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2"><table width=100% height="28" border=0 align="center" cellpadding="0" cellspacing="1" class="p9">
          <%@ taglib uri="/WEB-INF/tlds/DocListTag.tld" prefix="dl" %>
          <dl:DocListTag action="list" query="" dirCode="notice" start="0" end="5">
            <dl:DocListItemTag field="title" mode="detail">
              <tr>
                <td width="82%" height=22 align="left">&nbsp;&nbsp;<a href="doc_show_notice.jsp?id=$id">$title</a></td>
                <td width="18%" align="left">$modifiedDate</td>
                </tr>
            </dl:DocListItemTag>
          </dl:DocListTag>
        </table></td>
      </tr>
    </table>
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/i_sound.gif" width="21" height="16" align="absmiddle"><strong>工作流</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="flow_list_doingorreturn.jsp" class="desktopwhite">待办工作</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2"><table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="100%" align="center">
            <tbody>
<%
String sql = "select id from flow_my_action where (user_name=" + StrUtil.sqlstr(myname) + " or proxy=" + StrUtil.sqlstr(myname) + ") and is_checked=0 order by receive_date desc";
MyActionDb mad = new MyActionDb();
ListResult wflr = mad.listResult(sql, 1, 10);
Iterator wfir = wflr.getResult().iterator();
Leaf ft = new Leaf();
WorkflowDb wfd = null;
WorkflowMgr wfm = new WorkflowMgr();
while (wfir.hasNext()) {
 	mad = (MyActionDb)wfir.next(); 
	WorkflowActionDb wad = new WorkflowActionDb();
	wad = wad.getWorkflowActionDb((int)mad.getActionId());
	wfd = wfm.getWorkflowDb(wad.getFlowId());
	%>
              <tr class="row" style="BACKGROUND-COLOR: #ffffff">
                <td width="82%" height="22">&nbsp;<a href="flow_dispose.jsp?myActionId=<%=mad.getId()%>"><%=wfd.getTitle()%></a></td>
                <td width="18%"><%=DateUtil.format(wfd.getMydate(), "yy-MM-dd HH:mm")%> </td>
                </tr>
              <%}%>
            </tbody>
          </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/i_sound.gif" width="21" height="16" align="absmiddle"><strong> 新闻</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="doc_list.jsp?dir_code=news" class="desktopwhite">全部新闻</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2"><table width=100% height="28" border=0 align="center" cellpadding="0" cellspacing="1" class="p9">
              <%@ taglib uri="/WEB-INF/tlds/DocListTag.tld" prefix="dl" %>
              <dl:DocListTag action="list" query="" dirCode="news" start="0" end="5">
                <dl:DocListItemTag field="title" mode="detail">
                  <tr>
                    <td width="82%" height=22 align="left">&nbsp;&nbsp;<a href="doc_show.jsp?id=$id">$title</a></td>
                    <td width="18%" align="left">$modifiedDate</td>
                  </tr>
                </dl:DocListItemTag>
              </dl:DocListTag>
          </table></td>
        </tr>
      </table></td>
	<td width="10"></td>
    <td width="290" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/dot_10.gif" width="19" height="21" align="absmiddle"><strong> 日程安排</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="plan.jsp" class="desktopwhite">全部日程</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
		  <%
		// sql = "select id from user_plan where userName="+fchar.sqlstr(myname)+" and TO_DAYS(mydate)=TO_DAYS(NOW())";
		sql = "select id from user_plan where userName="+fchar.sqlstr(myname)+" order by mydate desc";
		PlanDb pd = new PlanDb();
		ListResult lr = pd.listResult(sql, 1, 5);
		Iterator ir = lr.getResult().iterator();
		while (ir.hasNext()) {
			pd = (PlanDb)ir.next();
			String mydate = DateUtil.format(pd.getMyDate(), "yy-MM-dd HH:mm");
		%>
		  <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr><td width="69%" height="22">&nbsp;<a href=plan_show.jsp?id=<%=pd.getId()%>><%=pd.getTitle()%></a></td>
		      <td width="31%"><%=mydate%></td>
		    </tr></table>
		  <%}%>
		  </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">任务督办</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="task.jsp" class="desktopwhite">全部任务</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
<%
TaskMgr tm = new TaskMgr();
Vector tasks = tm.getUserNotFinishedTask(myname);
if (tasks.size()==0) {
	// out.print(fchar.p_center("您目前没有参与到任何任务中！"));
}
Iterator taskir = tasks.iterator();
int id = 0;	
String title = "",initiator="",mydate="";
int expression=0;
int type=0,recount=0,isfinish=0;
i = 0;
while (taskir.hasNext())
{
  i++;
  TaskDb td = (TaskDb)taskir.next();
  id = td.getId();
  title = td.getTitle();
  initiator = td.getInitiator();
  mydate = DateUtil.format(td.getMyDate(), "yy-MM-dd HH:mm");
  expression = td.getExpression();
  type = td.getType();
  recount = td.getReCount();
  isfinish = td.getStatus();
%>
  <table cellspacing=0 cellpadding=0 width="100%" align=center>
    <tbody>
      <tr> 
        <td width="197" height="22" align=left bgcolor=#f8f8f8>&nbsp;<a href="task_show.jsp?showid=<%=id%>&rootid=<%=id%>"><%=StrUtil.getLeft(title, 30)%></a> </td>
        <td align=left width=89 bgcolor=#f8f8f8> 
          <table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
            <tbody>
              <tr> 
                <td><%=mydate%></td>
                </tr>
            </tbody>
        </table></td>
      </tr>
    </tbody>
  </table>
<%}%>		
		  </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
      <tr>
        <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">短消息</strong></td>
        <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="message_oa/message.jsp" class="desktopwhite">全部消息</a></span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2">
          <%
		MessageDb md = new MessageDb();
		
		sql = "select id from oa_message where receiver="+StrUtil.sqlstr(myname)+" and isDraft=0 order by isreaded asc,rq desc";

String sender="",receiver="",rq="";
boolean isreaded = true;
Iterator msgir = md.list(sql, 0, 9).iterator();
while (msgir.hasNext()) {
 	      md = (MessageDb)msgir.next(); 
		  i++;
		  id = md.getId();
		  title = md.getTitle();
		  sender = md.getSender();
		  receiver = md.getReceiver();
		  rq = md.getRq();
		  type = md.getType();
		  isreaded = md.isReaded();
		 %>
          <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="p9">
            <tr>
              <td width="70%"><a href="message_oa/showmsg.jsp?id=<%=id%>" class="9black2">
                <%if (isreaded) {%>
                <%=StrUtil.getLeft(title, 22)%>
                <%}else{%>
                <b><%=StrUtil.getLeft(title, 20)%></b>
                <%}%>
                </a> <font color="#666666"> [<%=sender%>]
                  <!-- <%=rq%>]-->
              </font></td>
              <td width="30%" >
                  <%=rq%>
              </td>
            </tr>
          </table>
          <%}%></td>
      </tr>
    </table></td></tr>
</table>
</body>
</html>
