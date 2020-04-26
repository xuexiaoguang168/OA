<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=Global.AppName%> -   <lt:Label res="res.label.forum.manager" key="toptic_op"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<%@ include file="../inc/nocache.jsp"%>
<link href="../<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
.style1 {color: #FFFFFF}
body {
	margin-left: 0px;
	margin-right: 0px;
}
</STYLE>
<script>
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);

	GetDate = showModalDialog("../../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
} 
</script>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY topMargin=0>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<%
	String querystring = StrUtil.getNullString(request.getQueryString());
	String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
	
	int id = 0;
	try {
		id = ParamUtil.getInt(request, "id");
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.p_center(e.getMessage(), "red"));
		return;
	}

	if (!privilege.isUserLogin(request)) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"info_please_login"), "../index.jsp"));
		return;
	}
	
	if (!privilege.canManage(request, id)) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.label.forum.manager","error_pvg") + "\\n" + SkinUtil.LoadString(request,"res.label.forum.manager","check_ok"), "../treasure_use.jsp?id="+id));
		return;
	}

	boolean re = false;
	String op = ParamUtil.get(request, "op");
	if (op.equals("changeColor")) {
		try {
			re = topic.ChangeColor(request);
			if (re) {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_success")));
			}
			else {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_fail")));
			}
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.p_center(e.getMessage(),"red"));
		}
	}
	if (op.equals("changeBold")) {
		try {
			re = topic.ChangeBold(request);
			if (re) {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_success")));
			}
			else {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_fail")));
			}
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.p_center(e.getMessage(),"red"));
		}
	}
	
	MsgDb md = new MsgDb();
	md = md.getMsgDb(id);
	String boardCode = md.getboardcode();
%>	  
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td height="153" align="center" valign="middle"> 
        <div align="">
		  <table width="100%"  border="0" cellspacing="1" cellpadding="1">
            <tr>
              <td align="center">
                <%
		Leaf lf = new Leaf();
		lf = lf.getLeaf(boardCode);
		%>
    <lt:Label res="res.label.forum.manager" key="board"/><a href="../listtopic.jsp?boardcode=<%=StrUtil.UrlEncode(boardCode)%>"><%=lf.getName()%></a>
  <%if (md.isBold()) out.print("<B>");%>
  <%
		String color = StrUtil.getNullString(md.getColor());
		if (color.equals("")) {%>
  <a href="../showtopic.jsp?rootid=<%=id%>"><%=md.getTitle()%></a>
  <%}else{%>
  <a href="../showtopic.jsp?rootid=<%=id%>"><font color="<%=color%>"><%=md.getTitle()%></font></a>
  <%}%>
  <%if (md.isBold()) out.print("</B>");%>
              </td>
            </tr>
          </table>
		  <table width="100%"  border="0" align="center" cellpadding="5">
            <tr>
              <td align="center"><form name="form1" method="post" action="?op=changeColor">
  <span class="stable"> &nbsp;
  <select name="color">
    <option value="" style="COLOR: black" selected><lt:Label res="res.label.forum.manager" key="clear_color"/></option>
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
  </select>
  <script>
		form1.color.value = "<%=color%>";
  </script>
  <input type=hidden name="id" value="<%=id%>">
  </span> &nbsp;  <lt:Label res="res.label.forum.manager" key="to_date"/>
<input name=colorExpire size=10 readonly value="<%=DateUtil.format(md.getColorExpire(), "yyyy-MM-dd")%>"><img src="../../util/calendar/calendar.gif" align=absMiddle style="cursor:hand" onClick="SelectDate('colorExpire','yyyy-mm-dd')">  
  <input type="submit" name="Submit" value="<%=SkinUtil.LoadString(request,"ok")%>">
  <br>
              </form></td>
            </tr>
            <tr>
              <td align="center"><form name="form2" method="post" action="?op=changeBold">
  <input type=hidden name="id" value="<%=id%>">
  <input type=checkbox name=isBold value="1" <%=md.isBold()?"checked":""%>>
  <lt:Label res="res.label.forum.manager" key="blod_display"/>
  <lt:Label res="res.label.forum.manager" key="to_date"/>
  <input name=boldExpire size=10 readonly value="<%=DateUtil.format(md.getBoldExpire(), "yyyy-MM-dd")%>">
  <img src="../../util/calendar/calendar.gif" align=absMiddle style="cursor:hand" onClick="SelectDate('boldExpire','yyyy-mm-dd')">
<input type="submit" name="Submit" value="<%=SkinUtil.LoadString(request,"ok")%>">
  <br>
              </form></td>
            </tr>
          </table>
        </div>                
	  </td>
    </tr>
</table>
<%@ include file="../inc/footer.jsp"%>
</BODY></HTML>
