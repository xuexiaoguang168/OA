<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
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
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<%
	// 安全验证
	if (!privilege.isUserLogin(request)) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"info_please_login"), "../index.jsp"));
		return;
	}
	String boardcode = ParamUtil.get(request, "boardcode");
	if (boardcode.equals("")) {
		out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.label.forum.manager","board_code_can_not_null"), "../index.jsp"));
		return;
	}
	
	Leaf leaf = new Leaf();
	leaf = leaf.getLeaf(boardcode);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><%=Global.AppName%> - <lt:Label res="res.label.forum.manager" key="mgr_board"/> <%=leaf.getName()%></TITLE>
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
function form1_onsubmit() {
	form1.boardRule.value = getHtml();
	if (form1.boardRule.value.length>3000) {
		alert(<%=SkinUtil.LoadString(request,"res.label.forum.manager","board_rule_msg")%>);
		return false;
	}
}
</script>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY topMargin=0>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<%
	String op = ParamUtil.get(request, "op");
	if (op.equals("modify")) {
        if (!privilege.isManager(request, boardcode)) {
			out.print(StrUtil.Alert_Redirect(SkinUtil.LoadString(request,"res.label.forum.manager","error_user"), "../index.jsp"));
        }
		String boardRule = ParamUtil.get(request, "boardRule");
		leaf.setBoardRule(boardRule);
		if (leaf.update())
			out.print(StrUtil.Alert(SkinUtil.LoadString(request,"info_op_success")));
		else
			out.print(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_fail")));
		
	}
%>	  
  <table width="63%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#FFFBFF" class="tableframe_gray">
    <form name=form1 action="?op=modify" method="post" onSubmit="return form1_onsubmit()">
      <tr align="center" bgcolor="#FFFFFF">
        <td width="16%" height="22"><lt:Label res="res.label.forum.manager" key="board_name"/></td>
        <td width="84%" height="26" align="left"><a href="../listtopic.jsp?boardcode=<%=StrUtil.UrlEncode(boardcode)%>"><%=leaf.getName()%></a>
		<input type=hidden name=boardcode value="<%=boardcode%>">
		</td>
      </tr>
      <tr align="center" bgcolor="#FFFFFF">
        <td height="22" valign="top"><lt:Label res="res.label.forum.manager" key="mgr_board"/></td>
        <td height="22" align="left"><%
		String rpath = request.getContextPath();
		%>
            <textarea id="boardRule" name="boardRule" style="display:none"><%=leaf.getBoardRule().replaceAll("\"","'")%></textarea>
            <link rel="stylesheet" href="<%=rpath%>/editor/edit.css">
            <script src="<%=rpath%>/editor/DhtmlEdit.js"></script>
            <script src="<%=rpath%>/editor/editjs.jsp"></script>
            <script src="<%=rpath%>/editor/editor_s.jsp"></script>
            <script>
				setHtml(form1.boardRule);
			</script>
        </td>
      </tr>
      <tr align="center" bgcolor="#FFFFFF">
        <td height="22">&nbsp;</td>
        <td height="22" align="left">( <lt:Label res="res.label.forum.manager" key="board_rule_msg_clear"/> )</td>
      </tr>
      <tr align="center" bgcolor="#FFFFFF">
        <td height="30" colspan="2"><input type="submit" name="Submit" value="<%=SkinUtil.LoadString(request,"commit")%>">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="reset" name="Submit" value="<%=SkinUtil.LoadString(request,"reset")%>"></td>
      </tr>
    </form>
  </table>
  <%@ include file="../inc/footer.jsp"%>
</BODY></HTML>
