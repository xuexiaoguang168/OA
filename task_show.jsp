<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.task.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>显示任务</TITLE>
<META http-equiv=Content-Type content=text/html; charset=utf-8 charset=utf-8>
<LINK href="common.css" rel=stylesheet>
<%@ include file="inc/nocache.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
String querystring = fchar.getNullString(request.getQueryString());
String privurl=request.getRequestURL()+"?"+java.net.URLEncoder.encode(querystring,"GBK");
%>
<SCRIPT language=JavaScript>
<!--
function checkclick(msg)
{
	if(confirm(msg))
	{
		event.returnValue=true;
	}
	else
	{
		event.returnValue=false;
	}
}

function SymError()
{
  return true;
}

window.onerror = SymError;

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}

function changefinish(obj,id,isfinish)
{
	location.href="task_finish.jsp?isfinish="+isfinish+"&taskid="+id;
}

function OfficeOperate() {
	alert(redmoonoffice.ReturnMessage.substr(0, 4));
}

// 编辑文件
function editdoc(id, attachId)
{
	rmofficeTable.style.display = "";
	redmoonoffice.AddField("taskId", id);
	redmoonoffice.AddField("attachId", attachId);
	redmoonoffice.Open("<%=Global.getRootPath()%>/task_getfile.jsp?taskId=" + id + "&attachId=" + attachId);
}
//-->
</SCRIPT>
<SCRIPT language=JavaScript src="forum/images/nereidFade.js"></SCRIPT>
<SCRIPT>
function checkclick(msg){if(confirm(msg)){event.returnValue=true;}else{event.returnValue=false;}}
function copyText(obj) {var rng = document.body.createTextRange();rng.moveToElementText(obj);rng.select();rng.execCommand('Copy');}
var i=0;
function formCheck(){i++;if (i>1) {document.form.submit1.disabled = true;}return true;}
function presskey(eventobject){if(event.ctrlKey && window.event.keyCode==13){i++;if (i>1) {alert('帖子发送中，请耐心等待！');return false;}this.document.form.submit();}}
</SCRIPT>
<META content="MSHTML 6.00.2800.1126" name=GENERATOR></HEAD>
<BODY text=#000000 bgColor=#ffffff leftMargin=0 topMargin=5 marginheight="0" marginwidth="0">
<%@ include file="task_inc_menu_top.jsp"%>
<br>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<%
int rootid = ParamUtil.getInt(request, "rootid");
String strshowid = ParamUtil.get(request, "showid");
int showid = -1;
if (!strshowid.equals(""))
	showid = Integer.parseInt(strshowid);
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String myname = privilege.getUser(request);

if (showid==-1)
	showid = rootid;

int islocked = 0;

TaskDb showTask = new TaskDb();
showTask = showTask.getTaskDb(showid);
if (showTask==null || !showTask.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "该任务已不存在！"));
	return;
}
String sql = "";
String title="",mydate="",content="",initiator="",showtitle="",filename="",extname="",person="";
int id;
int orders = 1,type=0;
int pagesize = 10;
int isfinish = 0;
int expression = 1;
int thisrootid = -1;// 这个任务项的rootid

id = showTask.getId();
content = showTask.getContent();
initiator = showTask.getInitiator();
mydate = DateUtil.format(showTask.getMyDate(), "yyyy-MM-dd HH:mm:ss");
title = showTask.getTitle();
showtitle = title;
orders = showTask.getOrders();
type = showTask.getType();
isfinish = showTask.getStatus();
expression = showTask.getExpression();
filename = showTask.getFileName();
extname = showTask.getExt();
person = showTask.getPerson();
thisrootid = showTask.getRootId();
%>
<TABLE borderColor=#d3d3d3 cellSpacing=0 cellPadding=0 width="98%" align=center 
border=0>
  <TBODY>
  <TR bgColor=#c4d4e5>
    <TD bgColor=#C4DAFF height=25><TABLE width="100%" class="right-title">
          <TBODY>
            <TR> 
              <TD> 
                <%if (expression!=0) { %>
                <img align="absmiddle" src="forum/images/emot/em<%=expression%>.gif" border=0> 
                <%}%>
                <b>标题：</b> <%=fchar.toHtml(title)%></TD>
              <TD width="37%" align=left> 
                <%
			  boolean isinitiator = myname.equals(initiator)?true:false;//是否为发起人
			  boolean isperson = myname.equals(person)?true:false;//是否为承办人
			  boolean cannewtask = privilege.isUserPrivValid(request,"task");//是否能发起任务
			  %>
              <%if (type==TaskDb.TYPE_TASK && isfinish!=TaskDb.STATUS_DISCARD) { %>
                <%if (isperson && showTask.getParentId()!=TaskDb.NOPARENT) {%>
					<img src=images/task/icon-result.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=addresult&person=<%=StrUtil.UrlEncode(person)%>&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">汇报办理结果</a> 
                <%}%>
                <%if (isinitiator && showTask.getParentId()!=TaskDb.NOPARENT) {%>
					<img src=images/task/icon-hurry.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=hurry&person=<%=StrUtil.UrlEncode(person)%>&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">催办</a> 
                <%}%>
				<%if (showTask.getParentId()!=TaskDb.NOPARENT) {%>
					<%if (isperson && cannewtask) {%>
						<img src=images/task/icon-subtask.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=newsubtask&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">分配子任务</a>
					<%}%>
				<%}else{%>
					<%if (isinitiator && showTask.getStatus()==TaskDb.STATUS_NOTFINISHED) {%>
						<img src=images/task/icon-subtask.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=newsubtask&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">分配任务</a>
					<%}%>
				<%}%>
              <%}%>
              <%if (type==TaskDb.TYPE_SUBTASK && isfinish!=TaskDb.STATUS_DISCARD) { %>
				  <%if (isperson) {%>
					  <img src=images/task/icon-result.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=addresult&person=<%=StrUtil.UrlEncode(person)%>&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">汇报办理结果</a> 
				  <%}%>
				  <%if (isinitiator) {%>
					  <img src=images/task/icon-hurry.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=hurry&person=<%=StrUtil.UrlEncode(person)%>&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">催办</a> 
				  <%}%>
				  <%if (isperson && cannewtask) {%>
					  <img src=images/task/icon-subtask.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=newsubtask&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">分配子任务</a> 
				  <%}%>
              <%}%>
              <%if (type==TaskDb.TYPE_HURRY && isfinish!=TaskDb.STATUS_DISCARD) { //催办%>
				  <%if (isperson) {%>
					  <img src=images/task/icon-result.gif align="absmiddle">&nbsp;<a href="task_add.jsp?op=addresult&person=<%=StrUtil.UrlEncode(person)%>&parentid=<%=id%>&privurl=<%=privurl%>" class="title_white">汇报办理结果</a> 
				  <%}%>
              <%}%></TD>
            </TR>
          </TBODY>
        </TABLE> </TD>
</TR></TBODY></TABLE>
	  <table bordercolor=#d3d3d3 cellspacing=0 cellpadding=0 width="98%" align=center 
border=0>
  <tbody> 
  <tr> 
    <td valign=top align=left height=78> 
      <table cellspacing=0 cellpadding=3 width="100%" border=0>
          <tbody>
            <tr bgcolor=#ffffff> 
              <td valign=top align=left height=106> <table style="WORD-BREAK: break-all" 
            height="100%" cellspacing=0 cellpadding=0 width="99%" border=0>
                  <tbody>
                    <tr height=20> 
                      <td width="79%" colspan="3"> <a name=#content<%=id%>></a> 
                        <img src="forum/images/posttime.gif" border=0> 发布时间：<span title="<%=mydate%>"><%=mydate%></span> &nbsp;<!--[<a href="#<%=id%>">任务树中位置</a>]-->
						<% if (isinitiator) {%> 
                        &nbsp;&nbsp;[<a href="task_edit.jsp?privurl=<%=privurl%>&editid=<%=id%>">编辑</a>]
						&nbsp;
						[<a onClick="checkclick('您确定要删除吗?')" href="task_del.jsp?delid=<%=id%>&rootid=<%=rootid%>">	
                        删除</a>]<%}%>
						<%if (type==0 || type==1) {%>
							<input type="checkbox" name="isfinish" value="1"
							<%if(isfinish==TaskDb.STATUS_FINISHED){%>checked<%}%> onClick="changefinish(this,'<%=id%>','<%=TaskDb.STATUS_FINISHED%>')">
							完成 
							<input type="checkbox" name="isfinish2" value="0"
							<%if(isfinish==TaskDb.STATUS_NOTFINISHED){%>checked<%}%> onClick="changefinish(this,'<%=id%>','<%=TaskDb.STATUS_NOTFINISHED%>')">
							未完成 
							<input type="checkbox" name="isfinish3" value="2"
							<%if(isfinish==TaskDb.STATUS_DISCARD){%>checked<%}%> onClick="changefinish(this,'<%=id%>','<%=TaskDb.STATUS_DISCARD%>')">
							作废
						<%}%>						</td>
                    </tr>
                    <tr height=8> 
                      <td colspan="3"> <hr width="100%" color=#777777 size=1>                      </td>
                    </tr>
                    <tr valign=top> 
                      <td height="78" colspan="3"> <span id="topiccontent" name="topiccontent"> 
                <%
				if (thisrootid==-1 && !(initiator.equals(myname) || person.equals(myname)))//如果是根任务
					out.print("&nbsp;&nbsp;............");
				else {
					// content = fchar.toHtml(content);
					// out.println(fchar.ubb(content,true)); // 会使插入的表情出问题
					out.print(content);
				}
				%>
                        </span> </td>
                    </tr>
                    <tr valign=top> 
                      <td height="13" colspan="3"> 
                        <hr width="100%" color=#777777 size=1>                      </td>
                    </tr>
                    <tr valign=top height=15>
                      <td colspan="3">发起人：<%=initiator%> &nbsp;&nbsp;&nbsp;&nbsp;
					  <%if (showTask.getParentId()!=-1) {%>
					  承办人：<%=person%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <%}else{%>
					  根任务
					  <%}%>
					  &nbsp;&nbsp;发起时间：<%=mydate%></td>
                    </tr>
                    <tr valign=top height=15>
                      <td colspan="3">附件：
                        <%
					  java.util.Iterator attir = showTask.getAttachments().iterator();
					  while (attir.hasNext()) {
					  	Attachment att = (Attachment)attir.next();
						String ext = StrUtil.getFileExt(att.getDiskName());
					  %>
                         <div style="height:30px"><img src="images/attach.gif" align="absmiddle"><a target="_blank" href="task_getfile.jsp?taskId=<%=showTask.getId()%>&attachId=<%=att.getId()%>"><%=att.getName()%></a>&nbsp;&nbsp;
						 <!--
						 <%if (ext.equals("doc") || ext.equals("xls")) {%>
							<a href="javascript:editdoc('<%=showTask.getId()%>', '<%=att.getId()%>')" title="编辑Office文件"><img src="netdisk/images/btn_edit_office.gif" width="16" height="16" border="0" align="absmiddle"></a>
						 <%}%>
						 -->
						 </div>
                      <%}%>
		  <table id="rmofficeTable" name="rmofficeTable" style="display:none" width="29%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr>
              <td height="22" align="center" bgcolor="#E3E3E3"><strong>&nbsp;编辑Office文件</strong></td>
            </tr>
            <tr>
              <td align="center" bgcolor="#FFFFFF"><object id="redmoonoffice" classid="CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE" 
codebase="<%=request.getContextPath()%>/activex/rmoffice.cab#version=2,0,0,1" width="316" height="43" viewastext="viewastext">
                  <param name="Encode" value="utf-8" />
                  <param name="BackColor" value="0000ff00" />
                  <param name="Server" value="<%=Global.server%>" />
                  <param name="Port" value="<%=Global.port%>" />
                  <!--设置是否自动上传-->
                  <param name="isAutoUpload" value="1" />
                  <!--设置文件大小不超过1M-->
                  <param name="MaxSize" value="1024000" />
                  <!--设置自动上传前出现提示对话框-->
                  <param name="isConfirmUpload" value="1" />
                  <!--设置IE状态栏是否显示信息-->
                  <param name="isShowStatus" value="0" />
                  <param name="PostScript" value="<%=Global.virtualPath%>/task_office_upload.jsp" />
                </object>
                  <!--<input name="remsg" type="button" onclick='alert(redmoonoffice.ReturnMessage)' value="查看上传后的返回信息" />--></td>
            </tr>
          </table>					  
					  </td>
                    </tr>
                  </tbody>
                </table></td>
            </tr>
          </tbody>
        </table>
    </td>
  </tr>
  </tbody>
</table>
<%
sql = "select id from task where rootid="+rootid+" ORDER BY orders";
ListResult lr = showTask.listResult(sql);

int layer = 1;
int i = 1;
boolean isshow = false;
int showlayer = 0;
Iterator ir = lr.getResult().iterator();
if (ir.hasNext()) {
	// 写根任务
	TaskDb td = (TaskDb)ir.next();
	id = td.getId();
	title = td.getTitle();
	type = td.getType();
	expression = td.getExpression();
	initiator = td.getInitiator();
	person = td.getPerson();
	layer = td.getLayer();
	isfinish = td.getStatus();
	if (initiator.equals(myname) || person.equals(myname))
	{
		isshow = true;
		showlayer = layer;
	}
%>
<table bordercolor=#edeced cellspacing=0 cellpadding=1 width="98%" align=center border=1>
  <tbody> 
  <tr> 
    <td noWrap align=left bgcolor=#f8f8f8 height="21" width="3%"><img alt=在新窗口中浏览 src="forum/images/1.gif" 
border=0> </td>
      <td noWrap align=left bgcolor=#f8f8f8 height="21" width="97%"> <a name=#<%=id%>></a> 
        <%if (isfinish==1) {%>
        <img src="images/task/icon-yes.gif"> 
        <%}else if (isfinish==0){%>
        <img src="images/task/icon-notyet.gif"> 
        <%}else {%>
        <img src="images/task/icon-no.gif"> 
        <%}%>
        <%
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
		<% if (id!=showid) { %>
			<a href="task_show.jsp?rootid=<%=rootid%>&showid=<%=id%>"><%=title%></a> 
		<% } else { %>
		<font color=red><%=title%></font>
		<% }
	}else {%> 
	............
	<%}%>
      </td>
  </tr>
  </tbody> 
</table>
<%
}
		while (ir.hasNext())
		{
		  i++;
		  TaskDb td = (TaskDb)ir.next();
		  id = td.getId();
		  TaskDb parentTd = td.getTaskDb(td.getParentId());
		  layer = td.getLayer();
		  initiator = td.getInitiator();
		  mydate = DateUtil.format(td.getMyDate(), "yyyy-MM-dd");
		  title = td.getTitle();
		  type = td.getType();
		  isfinish = td.getStatus();
		  expression = td.getExpression();
 		  person = td.getPerson();
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
<table cellspacing=0 cellpadding=0 width="98%" align=center border=0 bgcolor=#f8f8f8 style="padding:0; margin:0">
  <tbody> 
  <tr> 
    <td height="13" align=left noWrap bgcolor=#f8f8f8 style="padding:0; margin:0">  
    <img src="" width=30 height=1>
	<%
	layer = layer-1;
	for (int k=1; k<=layer-1; k++)
	{ %>
      <img src="forum/images/bbs_dir/line.gif" width=18 height="22">
      <% }%>
        <img src="forum/images/bbs_dir/join.gif" width="18" height="22">
        <%if (type==0 || type==1) {
			if (isfinish==1) {%>
        <img src="images/task/icon-yes.gif"> 
        <%}else if (isfinish==0){%>
        <img src="images/task/icon-notyet.gif"> 
        <%}else {%>
        <img src="images/task/icon-no.gif"> 
        <%}
		}%>
        <%
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
	      <%
		  if (id!=showid) { %>
	      	<a href="task_show.jsp?rootid=<%=rootid%>&showid=<%=id%>"><%=title%></a> &nbsp;&nbsp;&nbsp;&nbsp;
          <% } else { %>
		  	<font color=red><%=title%></font><a name="#<%=showid%>"></a>&nbsp;&nbsp;<!--<a href="#content<%=showid%>">回到顶部</a>-->
		  <% }%>
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
			  <%=mydate%>&nbsp;]
		  <%}else if (type==2) {%>
		  	  [汇报人：<%
			  UserDb ud = new UserDb();
			  ud = ud.getUserDb(initiator);
			  out.print(ud.getRealName());
			  %>]
		  <%}%>  
	   <%
	   }
	   else
	   		out.print("............");
	   %>      </td>
    </tr>
  </tbody> 
</table>
<%	}%>
</BODY>
</HTML>
