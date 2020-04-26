<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.OnlineInfo"%>
<%@ page import="cn.js.fan.db.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>管理导读</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<%@ include file="../inc/nocache.jsp"%>
<LINK href="../../common.css" type=text/css rel=stylesheet>
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
.style1 {color: #FFFFFF}
.style2 {
	font-size: medium;
	font-weight: bold;
}
</STYLE>
<SCRIPT>
function loadonline(boardcode){
	var targetImg =eval("document.all.followImg000");
	var targetDiv =eval("document.all.followDIV000");
	if (targetImg.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg)){
		if (targetDiv.style.display!='block')
		{
			targetDiv.style.display="block";
			targetImg.src="../images/minus.gif";
			advance.innerText="关闭在线列表";
			if (targetImg.loaded=="no")
				document.frames["hiddenframe"].location.replace("online.jsp?boardcode="+boardcode);
		}
		else
		{
			targetDiv.style.display="none";
			targetImg.src="../images/plus.gif";
			advance.innerText="查看在线列表"
		}
	}
}
////////////////////展开帖子
function loadThreadFollow(b_id,t_id,getstr){
	var targetImg2 =eval("document.all.followImg" + t_id);
	var targetTR2 =eval("document.all.follow" + t_id);
	if (targetImg2.src.indexOf("nofollow")!=-1){return false;}
	if ("object"==typeof(targetImg2)){
		if (targetTR2.style.display!="")
		{
			targetTR2.style.display="";
			targetImg2.src="../images/minus.gif";
			if (targetImg2.loaded=="no"){
				document.frames["hiddenframe"].location.replace("listtree.jsp?id="+b_id+getstr);
			}
		}else{
			targetTR2.style.display="none";
			targetImg2.src="../images/plus.gif";
		}
	}
}
</SCRIPT>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY topMargin=2>
<%@ include file="../inc/inc.jsp"%>
<p align=center class="style2"><br>
  <br>
暂不提供本功能！</p>
<%
if (true)
	return;
%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="Topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<jsp:useBean id="guide" scope="page" class="com.redmoon.forum.Guide" />
<%
	String querystring = StrUtil.getNullString(request.getQueryString());
	String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
	
	String what = StrUtil.UnicodeToGB(StrUtil.getNullString(request.getParameter("what")));
	String op = StrUtil.getNullString(request.getParameter("op"));
	String boardcode = StrUtil.getNullString(request.getParameter("boardcode"));
	String boardname = StrUtil.UnicodeToGB(StrUtil.getNullString(request.getParameter("boardname")));
	String id = StrUtil.getNullString(request.getParameter("id"));
	String strhit = StrUtil.getNullString(request.getParameter("hit"));
	String title = StrUtil.UnicodeToGB(StrUtil.getNullString(request.getParameter("title")));
	String color = StrUtil.getNullString(request.getParameter("color"));
	String sort = StrUtil.getNullString(request.getParameter("sort"));
	String guideboardcode = boardcode;
	if (op.equals("add")) {
		if (boardcode.equals("") || boardname.equals(""))
		{
			out.println(StrUtil.Alert("参数不全，请检查！"));
		}
		else {
			boolean re = false;
			try {
				re = guide.AddGuideOfBoard(guideboardcode,title,id,boardcode,boardname,strhit,"");
			}
			catch (cn.js.fan.util.ErrMsgException e) {
				out.println(StrUtil.Alert(e.getMessage()));
			}
			if (re)
				out.println(StrUtil.Alert("置为导读成功！"));
		}
	}
	if (op.equals("del"))
	{
		guide.del(guideboardcode,id);
		out.println(StrUtil.Alert("导读删除成功！"));
	}
	if (op.equals("sort")) {
		guide.Sort(guideboardcode);
		out.println(StrUtil.Alert("重新排序成功！"));
	}
	if (op.equals("modify"))
	{
		if (!StrUtil.isNumeric(sort))
			out.print(StrUtil.Alert("序号必须为数字！"));
		else {
			int intsort = Integer.parseInt(sort);
			guide.modifyGuideOfBoard(guideboardcode,id,boardcode,boardname,strhit,color,title,intsort);
			out.println(StrUtil.Alert("导读修改成功！"));
		}
	}
	if (op.equals("generateguide"))
	{
		guide.generateGuideXMLFileOfBoard(boardcode, boardname);
		out.println(StrUtil.Alert("生成论坛导读成功！"));
	}
%>	  
<table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="#edeced" class="p9">
  <tr align="center" bgcolor="#0078bf"> 
    <td height="21" colspan="8"><span class="style1"><%=boardname%>-导读管理</span></td>
  </tr>
  <tr align="center"> 
    <td width="5%" height="23">编号</td>
    <td width="32%" height="23">标题</td>
    <td width="9%" height="23">论坛编码</td>
    <td width="18%">论坛名称</td>
    <td width="9%">点击数</td>
    <td width="11%" height="23">颜色</td>
    <td width="5%">序号</td>
    <td width="11%">操作</td>
  </tr>
<%
	java.util.List list = guide.getGuide(guideboardcode);
	Iterator ir = null;
	if (list!=null)
		ir = list.iterator();
	int n = 0;
	while (ir!=null && ir.hasNext())
	{
		n++;
		Element a = (Element)ir.next(); //得到第i个元素
		boardcode = a.getAttribute("boardcode").getValue();
		boardname = a.getAttribute("boardname").getValue();
		id = a.getAttribute("id").getValue();
		title = a.getChild("title").getText();
		strhit = a.getAttribute("hit").getValue();
		color = a.getAttribute("color").getValue();
		Attribute st = a.getAttribute("sort");
		if (st==null)
			sort = "0";
		else
			sort = st.getValue();
%>
  <tr align="center"> 
    <form name="form<%=n%>" action="../manager/?op=modify" method=post>
      <td width="5%" height="39"> <%=id%></td>
      <td width="32%" height="39" align="left"> 
        <input type="text" name="title" value="<%=title%>" size="30">
         <input type=hidden name="id" value="<%=id%>"> 
      </td>
      <td width="9%" height="39"><%=boardcode%> <input type=hidden name="boardcode" value="<%=boardcode%>"> 
      </td>
      <td width="18%" height="39"><%=boardname%> <input type=hidden name="boardname" value="<%=boardname%>"></td>
      <td width="9%" height="39"><%=strhit%> <input type=hidden name="hit" value="<%=strhit%>"></td>
      <td width="11%" height="39"><SELECT name="color" onchange="if(this.value!='0')msg.style.color=colortable[this.value-1];else msg.style.color='';msg.focus();">
          <option value="" STYLE="COLOR: black" selected>颜色</option>
          <option style="BACKGROUND: #000088" value="#000088"></option>
          <option style="BACKGROUND: #0000ff" value="#0000ff"></option>
          <option style="BACKGROUND: #008800" value="#008800"></option>
          <option style="BACKGROUND: #008888" value="#008888"></option>
          <option style="BACKGROUND: #0088ff" value="#0088ff"></option>
          <option style="BACKGROUND: #00a010" value="#00a010"></option>
          <option style="BACKGROUND: #1100ff" value="#1100ff"></option>
          <option style="BACKGROUND: #111111" value="#111111"></option>
          <option style="BACKGROUND: #333333" value="#333333"></option>
          <option style="BACKGROUND: #50b000" value="#50b000"></option>
          <option style="BACKGROUND: #880000" value="#880000"></option>
          <option style="BACKGROUND: #8800ff" value="#8800ff"></option>
          <option style="BACKGROUND: #888800" value="#888800"></option>
          <option style="BACKGROUND: #888888" value="#888888"></option>
          <option style="BACKGROUND: #8888ff" value="#8888ff"></option>
          <option style="BACKGROUND: #aa00cc" value="#aa00cc"></option>
          <option style="BACKGROUND: #aaaa00" value="#aaaa00"></option>
          <option style="BACKGROUND: #ccaa00" value="#ccaa00"></option>
          <option style="BACKGROUND: #ff0000" value="#ff0000"></option>
          <option style="BACKGROUND: #ff0088" value="#ff0088"></option>
          <option style="BACKGROUND: #ff00ff" value="#ff00ff"></option>
          <option style="BACKGROUND: #ff8800" value="#ff8800"></option>
          <option style="BACKGROUND: #ff0005" value="#ff0005"></option>
          <option style="BACKGROUND: #ff88ff" value="#ff88ff"></option>
          <option style="BACKGROUND: #ee0005" value="#ee0005"></option>
          <option style="BACKGROUND: #ee01ff" value="#ee01ff"></option>
          <option style="BACKGROUND: #3388aa" value="#3388aa"></option>
          <option style="BACKGROUND: #000000" value="#000000"></option>
        </SELECT> <script language="JavaScript">
		form<%=n%>.color.value="<%=color%>"
		</script> </td>
      <td width="5%" height="39"><input type="text" name="sort" size=3 value="<%=sort%>"> </td>
      <td width="11%" height="39"><input name="Submit3" type="submit" class="singleboarder" value="修改"> 
        <a href="guide.jsp?op=del&id=<%=id%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>" class=mainA> 删除</a></td>
    </form>
  </tr>
  <%
		}%>
</table>
<table width="100%" border="0" align="center" bgcolor="#0078bf" class="p9">
  <form name="form_search" method="post" action="../manager/?">
    <tr> 
      <td width="9%" align="center"><span class="style1">贴子标题 </span></td>
      <td width="21%" align="left"> <input name="what" type="text" class="singleboarder" > 
      </td>
      <td width="70%" align="left"><input name="Submit" type="submit" class="singleboarder" value="搜索贴子">
        &nbsp;<a href="guide.jsp?op=sort&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>"><font color=white>重新排序</font></a> <input type=hidden name="boardcode" value="<%=boardcode%>">
        <input type=hidden name="boardname" value="<%=boardname%>">
        <a href="guide.jsp?op=generateguide&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>"><font color=white>重新生成<%=boardname%>导读</font></a></td>
    </tr>
  </form>
</table>
<%
		if (boardcode==null)
		{
			out.println(StrUtil.makeErrMsg("请选择版面！"));
			return;
		}
		String sql;
		if (what.equals(""))
			sql = "select f.id,topic,f.name,lydate,recount,hit,expression,f.type,iselite,islocked,level,boardcode,b.name as boardname,f.isguide from sq_message as f,sq_forumboard as b where f.boardcode="+StrUtil.sqlstr(boardcode)+" and f.boardcode=b.code and f.rootid=-1 ORDER BY f.isguide desc,f.hit desc,f.level desc,f.lydate desc";
		else
			sql = "select f.id,topic,f.name,lydate,recount,hit,expression,f.type,iselite,islocked,level,boardcode,b.name as boardname,f.isguide from sq_message as f,sq_forumboard as b where f.boardcode="+StrUtil.sqlstr(boardcode)+" and f.topic like "+StrUtil.sqlstr("%"+what+"%")+" and f.boardcode=b.code and f.rootid=-1 ORDER BY f.isguide desc,f.hit desc,f.level desc,f.lydate desc";
		
		int pagesize = 10;
		ResultRecord rr = null;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();
		PageConn pageconn = new PageConn("forum", curpage, pagesize);
		ResultIterator ri = pageconn.getResultIterator(sql);
		paginator.init(pageconn.getTotal(), pagesize);
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}
%>
  <table width="100%" border="0" class="p9">
    <tr>
    <td align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 
      条　页次 <b><%=curpage %>/<%=totalpages %></b></td>
    </tr>
  </table>
  <TABLE borderColor=#edeced cellSpacing=0 cellPadding=1 width="100%" align=center 
border=1>
    <TBODY>
      <TR bgColor=#0078bf height=25> 
        <TD colSpan=3 align=middle noWrap bgcolor="#0078bf"><FONT color=#ffffff>主题列表 <B>(点 <IMG 
      src="../images/plus.gif"> 即可展开贴子列表)</B></FONT></TD>
        <TD noWrap align=middle width=91><FONT color=#ffffff>作者</FONT></TD>
        <TD noWrap align=middle width=55><FONT color=#ffffff>字[回]</FONT></TD>
        <TD noWrap align=middle width=55><FONT color=#ffffff>操作/点击</FONT></TD>
        <TD noWrap align=middle width=80><FONT color=#ffffff>日期</FONT></TD>
      </TR>
    </TBODY>
  </TABLE>
  <%		
String topic = "",name="",lydate="",expression="";
int level=0,iselite=0,islocked=0;
int i = 0,recount=0,hit=0,type=0,isguide=0;
while (ri.hasNext()) {
 	      rr = (ResultRecord)ri.next(); 
		  i++;
		  id = rr.getString("id");
		  topic = rr.getString("topic");
		  name = rr.getString("name");
		  lydate = rr.getString("lydate");
		  recount = rr.getInt("recount");
		  hit = rr.getInt("hit");
		  expression = rr.getString("expression");
		  type = rr.getInt("type");
		  iselite = rr.getInt("iselite");
		  islocked = rr.getInt("islocked");
		  level = rr.getInt("level");
		  boardcode = rr.getString("boardcode");
		  boardname = rr.getString("boardname");
		  isguide = rr.getInt("isguide");
	  %>
  <table bordercolor=#edeced cellspacing=0 cellpadding=1 width="100%" align=center border=1>
    <tbody>
      <tr> 
        <td noWrap align=middle width=30 bgcolor=#f8f8f8> <% if (level==100) { %> <IMG height=15 alt="" src="../images/f_top.gif" width=15 border=0> 
          <% } 
		else {
			if (iselite==1) { %> <IMG src="../images/topicgood.gif"> <% }
			else {
		%> <%if (recount>20){ %> <img alt="打开主题 (热门主题)" src="../images/f_hot.gif"> <%}
	  else if (recount>0) {%> <img alt="打开主题 (有回复的主题)" src="../images/f_new.gif"> <%}
	  else {%> <img alt="打开主题 (没有回复的主题)" src="../images/f_norm.gif"> <%}
	 	}
	 }%> </td>
        <td align=middle width=17 bgcolor=#ffffff> <% String urlboardname = StrUtil.UrlEncode(boardname,"utf-8"); %> <a href="../manager/showtopictree.jsp?boardcode=<%=boardcode%>&hit=<%=(hit+1)%>&boardname=<%=urlboardname%>&rootid=<%=id%>" target=_blank> 
          <% 
		  if (islocked==1) { %>
          <IMG height=15 alt="" src="../images/f_locked.gif" width=17 border=0> 
          <% }
		  else {
			  if (type==1) { %>
          <IMG height=15 alt="" src="../images/f_poll.gif" width=17 border=0> 
          <%}else { %>
          <img src="../images/brow/<%=expression%>.gif" border=0> 
          <%}
		  } %>
          </a></td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8> <%
		if (recount==0) {
		%> <img id=followImg<%=id%> title=展开回复" src="../images/minus.gif" loaded="no"> 
          <% }else { %> <img id=followImg<%=id%> title=展开回复 style="CURSOR: hand" 
      onClick=loadThreadFollow(<%=id%>,<%=id%>,"&boardcode=<%=boardcode%>&hit=<%=hit+1%>&boardname=<%=urlboardname%>") src="../images/plus.gif" loaded="no"> 
          <% } %> <!--<a href="showtopictree.jsp?boardcode=<%=boardcode%>&hit=<%=(hit+1)%>&boardname=<%=urlboardname%>&rootid=<%=id%>">（树形）<%=topic%></a>--> 
		  <a href="../showtopic.jsp?boardcode=<%=boardcode%>&hit=<%=hit%>&boardname=<%=urlboardname%>&rootid=<%=id%>"><%=topic%></a> 
		  <%
		//计算共有多少页回贴
		int allpages = (int)Math.ceil((double)recount/pagesize);
		if (allpages>1)
		{
		 	out.print("[");
			for (int m=1; m<=allpages; m++)
			{ %> <a href="../showtopic.jsp?boardcode=<%=boardcode%>&hit=<%=(hit+1)%>&boardname=<%=urlboardname%>&rootid=<%=id%>&CPages=<%=m%>"><%=m%></a> <% }
		  	out.print("]");
		 }%> </td>
        <td align=middle width=91 bgcolor=#ffffff> <% if (privilege.getUser(request).equals(name)) { %> <IMG height=14 src="../images/my.gif" 
            width=14> <% } %> <a href="../userinfo.jsp?username=<%=name%>"><%=name%></a> </td>
        <td align=middle width=55 bgcolor=#f8f8f8><font color=red>[<%=recount%>]</font></td>
        <td align=middle width=55 bgcolor=#ffffff>
		<%if (isguide==0) {%>
		<a href="guide.jsp?op=add&title=<%=StrUtil.UrlEncode(topic,"utf-8")%>&id=<%=id%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>&hit=<%=hit%>">置为导读[<%=hit%>]</a>
		<%}else if (isguide==2){%>
		社区导读
		<%}else{%>
		<a href="guide.jsp?op=del&id=<%=id%>&boardcode=<%=boardcode%>&boardname=<%=StrUtil.UrlEncode(boardname,"utf-8")%>" class=mainA>删除导读</a>[<%=hit%>]
		<%}%>
		</td>
        <td align=left width=80 bgcolor=#f8f8f8> <table cellspacing=0 cellpadding=2 width="100%" align=center border=0>
            <tbody>
              <tr> 
                <td width="10%">&nbsp;</td>
                <td><%=lydate.substring(0,19)%></td>
              </tr>
            </tbody>
          </table></td>
      </tr>
      <tr id=follow<%=id%> style="DISPLAY: none"> 
        <td noWrap align=middle width=30 bgcolor=#f8f8f8>&nbsp;</td>
        <td align=middle width=17 bgcolor=#ffffff>&nbsp;</td>
        <td onMouseOver="this.style.backgroundColor='#ffffff'" 
    onMouseOut="this.style.backgroundColor=''" align=left bgcolor=#f8f8f8 colspan="5"> 
          <div id=followDIV<%=id%> 
      style="WIDTH: 100%;BACKGROUND-COLOR: lightyellow" 
      onClick=loadThreadFollow(<%=id%>,<%=id%>,"&hit=<%=hit+1%>&boardname=<%=urlboardname%>")>正在读取关于本主题的跟贴，请稍侯……</div></td>
      </tr>
      <tr> 
        <td 
    style="PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; PADDING-TOP: 0px" 
    colspan=5> </td>
      </tr>
    </tbody>
  </table>
<%}%>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td width="2%" height="23">&nbsp;</td>
      <td width="76%" valign="baseline" height="23"> 
        <div align="right"> 
          <%
			String querystr = "what="+StrUtil.UrlEncode(what,"utf-8");
			out.print(paginator.getCurPageBlock("guide.jsp?"+querystr));
			%>
          &nbsp;</div>
    </td>
      
    <td width="22%" height="23">&nbsp; </td>
  </tr>
</table>            
</BODY></HTML>
