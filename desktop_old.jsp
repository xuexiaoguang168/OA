<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "com.redmoon.oa.db.PageQuery"%>
<%@ page import = "com.redmoon.oa.db.Conn"%>
<%@ include file="inc/inc.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的办公桌</title>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="cfgparser" scope="page" class="fan.util.CFGParser"/>
<%
String user = privilege.getUser(request);
String pwd = privilege.getPwd(request);
int i = 0;
cfgparser.parse("config.xml");
Properties props = cfgparser.getProps();
String serveraddr = props.getProperty("serveraddr");
String serverport = props.getProperty("serverport");
String virtualpath = props.getProperty("virtualpath");

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

var filename1,document_id1;//全局变量，用于记录编辑中的文件名和文件id
function editdoc(filename,document_id)
{
	var user = "<%=user%>"
	var pwd = "<%=pwd%>"
	filename1 = filename;
	document_id1 = document_id;
	useword.OpenWordDoc("http://<%=serveraddr%>:<%=serverport%>/<%=virtualpath%>/getdoctomodify.jsp?user="+user+"&pwd="+pwd+"&filename="+filename+"&document_id="+document_id);
}

function uploaddoc() {
    var document_id = document_id1;
	var filename = filename1;
	var user = "<%=user%>"
	var pwd = "<%=pwd%>"
	var fieldstr = "\r\n--AaB03x\r\nContent-Disposition: form-data; name=\"filename\"\r\n\r\n"+filename+"\r\n--AaB03x--";
	fieldstr += "\r\n--AaB03x\r\nContent-Disposition: form-data; name=\"user\"\r\n\r\n"+user+"\r\n--AaB03x--";	
	fieldstr += "\r\n--AaB03x\r\nContent-Disposition: form-data; name=\"pwd\"\r\n\r\n"+pwd+"\r\n--AaB03x--";	
	fieldstr += "\r\n--AaB03x\r\nContent-Disposition: form-data; name=\"document_id\"\r\n\r\n"+document_id+"\r\n--AaB03x--";	
	useword.UploadDoc(fieldstr);
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
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
	
//String sql = "select id,title,mydate from notice where DATEDIFF(day, mydate, getdate())<=3 and opengroup like '%|public|%' order by mydate desc";
String sql = "select top 5 id,title,mydate from notice where opengroup like '%|public|%' order by mydate desc";
String id="",title="",mydate="",filename="",extname="",content="";
Conn conn = new Conn("ttoa");
ResultSet rs = null;
%>
<table width="570" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
	<td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
      <tr>
        <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/i_sound.gif" width="21" height="16" align="absmiddle"><strong> 公共通知</strong></td>
        <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="notice.jsp" class="desktopwhite">全部通知</a></span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2">
		<%
		rs = conn.executeQuery(sql);
		if (rs!=null && rs.next()) {
			do
			{
				id = rs.getString("id");
				title = rs.getString("title");
				mydate = rs.getString("mydate").substring(0,10);
			%>
			<table width="100%"  border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">
      <%if (curdate.equals(mydate)) { %>
	<B><a href="notice.jsp?#<%=id%>" title="<%=title%>"><%=fchar.truncate(title, 14)%></a></B>
  <%}else{%>
	<a href="notice.jsp?#<%=id%>" title="<%=title%>"><%=fchar.truncate(title, 14)%></a>
  <%}%>
	</td>
    <td width="30%">[<%=mydate%>]</td>
  </tr>
</table>
		<%  }while (rs.next());
		}
		else
			out.print("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>		</td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/sign_icon1.gif" align="absmiddle"><strong>&nbsp;部门通知</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="notice_depart.jsp" class="desktopwhite">全部通知</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
            <%
		String department_id = privilege.getDepartmentID(request);
		//sql = "select id,title,mydate from notice where DATEDIFF(day, mydate, getdate())<=3 and opengroup like "+fchar.sqlstr("%|"+department_id+"|%")+" order by mydate desc";
		sql = "select top 5 id,title,mydate from notice where opengroup like "+fchar.sqlstr("%|"+department_id+"|%")+" order by mydate desc";
		rs = conn.executeQuery(sql); 
		if (rs!=null && rs.next()) {
			do
			{
				id = rs.getString("id");
				title = rs.getString("title");
				mydate = rs.getString("mydate").substring(0,10);
			%>
            <table width="100%"  border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">
                    <%if (curdate.equals(mydate)) { %>
                    <a href="notice_depart.jsp?#<%=id%>" title="<%=title%>"><%=fchar.truncate(title, 14)%></a>
                    <%}else{%>
                    <a href="notice_depart.jsp?#<%=id%>" title="<%=title%>"><%=fchar.truncate(title, 14)%></a>
                    <%}%>
                </td>
                <td width="30%">[<%=mydate%>]</td>
              </tr>
            </table>
            <% }while (rs.next());
		}
		else
			out.print("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
          </td>
        </tr>
      </table>      
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">会议通知</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="notice_meeting.jsp" class="desktopwhite">全部通知</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
            <%
		sql = "select id,title,applydate from meeting where state = '1' and person like "+fchar.sqlstr("%|"+myname+"|%");
		rs = conn.executeQuery(sql) ; 
		i = 0;
		String applydate = "";
		if (rs!=null && rs.next()) {
			do
			{
				i++;
				id = rs.getString("id");
				title = rs.getString("title");
				applydate = rs.getString("applydate").substring(0,10);
			%>
            <table width="100%"  border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">&nbsp;<a href="notice_meeting.jsp?id=<%=id%>" title="<%=title+" 来:"+fromwhom%>"><%=fchar.truncate(title, 14)%></a>&nbsp;</td>
                <td width="30%">[<%=applydate%>]</td>
              </tr>
            </table>
            <% } while (rs.next());
		}
		else
			out.println("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
          </td>
        </tr>
      </table>      
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
      <tr>
        <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">短消息</strong></td>
        <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="msg.jsp" class="desktopwhite">全部消息</a></span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2"><%
		i = 0;
		//三天内发来的邮件
		//sql = "select id,title,fromwhom,mydate from email where DATEDIFF(day, mydate, getdate())<=3 and isdel=0 and towhom="+fchar.sqlstr(privilege.getUser(request));
		sql = "select top 5 id,title,fromwhom,mydate from email where isdel=0 and towhom="+fchar.sqlstr(privilege.getUser(request))+" order by mydate desc";		
		rs = conn.executeQuery(sql);
		if (rs!=null && rs.next()) {
			do
			{
				i++;
				id = rs.getString("id");
				title = rs.getString("title");
				fromwhom = rs.getString("fromwhom");
				mydate = rs.getString("mydate").substring(0,10);
			%>
            <table width="100%"  border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">&nbsp;<a href="msg_show.jsp?id=<%=id%>" title="<%=title+" 来:"+fromwhom%>"><%=fchar.truncate(title, 14)%></a>&nbsp;</td>
                <td width="30%">[<%=mydate%>]</td>
              </tr>
            </table>
            <% } while (rs.next());
		}
		else
			out.println("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
        </td>
      </tr>
    </table>
</td>
	<td width="10"></td>
    <td width="290" valign="top">      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
      <tr>
        <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/write.gif" width="16" height="14" align="absmiddle"><strong> 审批文件</strong></td>
        <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="listmeflowdoc.jsp" class="desktopwhite">全部文件</a></span></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td colspan="2">
          <%
		int ischecked=0, ischecking=0;
		sql = "select d.id,d.filename,d.title,d.extname,d.opengroup,d.uploaddate,d.username,f.document_id,f.color,f.ischecked,f.ischecking,f.sort,f.status,f.reason,d.filename,d.extname from document as d,doc_flow as f where d.id=f.document_id and f.person="+fchar.sqlstr(myname)+" and ischecking=1 order by uploaddate desc,checkdate desc";
		rs = conn.executeQuery(sql) ; 
		i = 0;
		String uploaddate="",color="";
		int sort = -1,status=0;
		String username = "", document_id="", reason="";
		if (rs!=null && rs.next()) {
			do
			{
				i++;
				id = rs.getString("id");
				title = rs.getString("title");
				username = rs.getString("username");
				uploaddate = rs.getString("uploaddate").substring(0,19);
				extname = rs.getString("extname");
				filename = rs.getString("filename");
				color = rs.getString("color");
				ischecked = rs.getInt("ischecked");
				ischecking = rs.getInt("ischecking");
				sort = rs.getInt("sort");
				status = rs.getInt("status");
				reason = fchar.getNullString(rs.getString("reason"));
			%>
          <table width="100%"  border="0" cellspacing="1" cellpadding="0">
            <tr>
              <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">
                  <%if (sort==-1) {
		  	if ( status==1) {%>
                  <a title="被打回原因：<%=reason%>" href="checkdoc_report.jsp?document_id=<%=id%>&reason=<%=URLEncoder.encode(reason, "GBK")%>"><%=fchar.truncate(title, 10)%></a><font color=red>(被打回)</font>
                  <%}
		  }else {
				if (ischecking==1) {
					if (status==1) {%>
                  <a href="checkdoc.jsp?filename=<%=URLEncoder.encode(filename+"."+extname,"GBK")%>&document_id=<%=id%>&title=<%=URLEncoder.encode(title,"GBK")%>&uploaddate=<%=uploaddate%>&color=<%=color%>&username=<%=URLEncoder.encode(username,"GBK")%>&sort=<%=sort%>"><%=fchar.truncate(title, 10)%></a><font color=red>(重批)</font>
                  <%		}else{
			  		%>
                  <a href="checkdoc.jsp?filename=<%=URLEncoder.encode(filename+"."+extname,"GBK")%>&document_id=<%=id%>&title=<%=URLEncoder.encode(title,"GBK")%>&uploaddate=<%=uploaddate%>&color=<%=color%>&username=<%=URLEncoder.encode(username,"GBK")%>&sort=<%=sort%>"><%=fchar.truncate(title, 10)%></a><font color=red>(请审批)</font>
                  <%		}
				}
		  }%>
              </td>
              <td width="30%">[<%=uploaddate.substring(0,10)%>]</td>
            </tr>
          </table>
          <% } while (rs.next());
		}
		else
			out.println("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
        </td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">请假审批</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="listleave_checkup.jsp" class="desktopwhite">全部请假</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2"><%
		sql = "select id,name,begindate,days,reason,type,mydate from leave where checkman="+fchar.sqlstr(myname)+" and checkupstate = '0'";
		int pagesize = 10;
		rs = conn.executeQuery(sql); 
		i = 0;
		String name = "",begindate ="",days = "",stype = "";
		if (rs!=null && rs.next()) {
			do
			{
				i++;
				id = rs.getString("id");
				name = rs.getString("name");
				begindate = rs.getString("begindate").substring(0,10);
				days = rs.getString("days");
				reason = rs.getString("reason");
				stype = rs.getString("type");
				if (stype.equals("evection"))
					stype = "出差";
				else
					stype = "其他";
				mydate = rs.getString("mydate");
			%>
              <table width="100%"  border="0" cellspacing="1" cellpadding="0">
                <tr>
                  <td width="70%" height="20">&nbsp;<a href="leave_checkup.jsp?id=<%=id%>&checkupstate=0" title="<%=name%>请假"><%=fchar.truncate(reason,14)%></a></td>
                  <td width="30%">[<%=begindate%>]</td>
                </tr>
              </table>
              <% } while (rs.next());
		}
		else
			out.println("&nbsp;");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<strong><img src="images/icn_news.gif" align="absmiddle">会议审批</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="listmeeting_checkup.jsp" class="desktopwhite">全部会议</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2">
            <%
		sql = "select id,title,applydate from meeting where state = '0' and checkperson = "+fchar.sqlstr(myname);
		rs = conn.executeQuery(sql) ; 
		i = 0;
		applydate = "";
		if (rs!=null && rs.next()) {
			do
			{
				i++;
				id = rs.getString("id");
				title = rs.getString("title");
				applydate = rs.getString("applydate").substring(0,10);
	     %>
            <table width="100%"  border="0" cellspacing="1" cellpadding="0">
              <tr>
                <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">&nbsp;<a href="notice_meeting.jsp?id=<%=id%>" title="<%=title+" 来:"+fromwhom%>"><%=fchar.truncate(title, 14)%></a>&nbsp;</td>
                <td width="30%">[<%=applydate%>]</td>
              </tr>
            </table>
            <% } while (rs.next());
		}
		else
			out.println("&nbsp;暂无");
		if (rs!=null) {
			rs.close(); rs = null;
		}%>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableframe">
        <tr>
          <td width="69%" height="27" background="images/top-left.gif">&nbsp;<img src="images/dot_10.gif" width="19" height="21" align="absmiddle"><strong> 日程安排</strong></td>
          <td width="31%" height="21" background="images/top-right.gif">&nbsp;<img src="images/icon.gif" width="10" height="10">&nbsp;<span class="style1"><a href="plan_list.jsp" class="desktopwhite">全部日程</a></span></td>
        </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="2"><%
		sql = "select top 5 id,username,title,mydate,zdrq from user_plan where username="+fchar.sqlstr(privilege.getUser(request))+" and DATEDIFF(day, mydate, getdate())=0";
		//sql = "select top 5 id,username,title,mydate,zdrq from user_plan where username="+fchar.sqlstr(privilege.getUser(request))+" order by mydate desc";		
		rs = conn.executeQuery(sql);
		String zdrq="";
		if (rs!=null && rs.next()) {
			do
			{
					i++;
					id = rs.getString(1);
					username = rs.getString(2);
					title = rs.getString(3);
					mydate = rs.getString(4).substring(0,10);
					zdrq = rs.getString(5).substring(0,10);
			%>
              <table width="100%"  border="0" cellspacing="1" cellpadding="0">
                <tr>
                  <td width="70%" height="20">&nbsp;<img src="images/Bullet12.gif">&nbsp;<a href="plan_show.jsp?id=<%=id%>" title="<%=title+" 制定日期："+zdrq%>"><%=fchar.truncate(title,14)%></a>&nbsp;</td>
                  <td width="30%">[<%=mydate%>]</td>
                </tr>
              </table>
              <% } while (rs.next());
		}
		else
			out.println("&nbsp;暂无");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
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
        <jsp:useBean id="task" scope="page" class="com.redmoon.oa.task.Task"/>
  	    <%
		String roottask = fchar.getNullStr(task.getTaskNotFinishedOfPerson(myname));
		task.clear();
		if (roottask.equals(""))
		{
			out.print(fchar.p_center("您目前没有任务！"));
			return;
		}
		
		String showisfinish = "0";
		sql = "select id,title,initiator,mydate,expression,type,recount,isfinish from task where id in ("+roottask+") ORDER BY mydate desc";
		rs=conn.executeQuery(sql); 
				
		String initiator="";
		int expression=0;
		int recount=0,isfinish=0,type=0;
		if (rs!=null && rs.next()) {
			do
			{
			  id = rs.getString("id");
			  title = rs.getString("title");
			  initiator = rs.getString("initiator");
			  mydate = rs.getString("mydate").substring(0,10);
			  expression = rs.getInt("expression");
			  type = rs.getInt("type");
			  recount = rs.getInt("recount");
			  isfinish = rs.getInt("isfinish");			
			  %>
              <table width="100%"  border="0" cellspacing="1" cellpadding="0">
                <tr>
                  <td width="70%" height="20"><%if (isfinish==1) {%>
                    <img src="images/task/icon-yes.gif" align="absmiddle">
                    <%}else if (isfinish==0){%>
                    <img src="images/task/icon-notyet.gif" align="absmiddle">
                    <%}else {%>
                    <img src="images/task/icon-no.gif" align="absmiddle">
                  <%}%>                  &nbsp;<a title="发起人：<%=initiator%>" href="task_show.jsp?showid=<%=id%>&rootid=<%=id%>"><%=fchar.truncate(title, 14)%></a></a>&nbsp;</td>
                  <td width="30%">[<%=mydate%>]</td>
                </tr>
              </table>
              <% } while (rs.next());
		}
		else
			out.println("&nbsp;暂无");
		if (rs!=null) {
			rs.close(); rs = null;
		}
		%>
          </td>
        </tr>
      </table>
      <%
		if (conn!=null) {
			conn.close();
			conn = null;
		}
		%>    <br>    </td></tr>
</table>
</body>
</html>
