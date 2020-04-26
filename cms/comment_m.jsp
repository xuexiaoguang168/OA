<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<html>
<head>
<title>管理登录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
.style1 {	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
int doc_id = ParamUtil.getInt(request, "doc_id");
Document doc = new Document();
doc = doc.getDocument(doc_id);

CommentMgr cm = new CommentMgr();
if (op.equals("del")) {
	try {
		if (cm.del(request, privilege))
			out.print(StrUtil.Alert("删除成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("delall")) {
	try {
		cm.delAll(request, privilege);
		out.print(StrUtil.Alert("删除成功！"));
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head">管理评论</td>
    </tr>
  </tbody>
</table>
<%
java.util.Iterator ir = cm.getList(doc_id);
%>
<br>
<br>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td width="82%" noWrap class="thead" style="PADDING-LEFT: 10px"><a href="../fwebedit.jsp?op=edit&id=<%=doc.getID()%>&dir_code=<%=StrUtil.UrlEncode(doc.getDirCode())%>"><%=doc.getTitle()%></a></td>
      <td width="18%" noWrap class="thead"><img src="images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
<%
while (ir.hasNext()) {
 	Comment cmt = (Comment)ir.next();
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px">&nbsp;
        <table width="98%" cellpadding="0" cellspacing="0" >
          <tr>
            <td height="43" align="center" class="tableframe_comment"><table width="99%" align="center" >
                <tr>
                  <td height="22" bgcolor="#F2F2F2"><span class="style1"><a href="cmt.getLink()"><a href="cmt.getLink()"><img border=0 src="images/arrow.gif" align="absmiddle"><%=cmt.getNick()%></a>&nbsp;发表于&nbsp;<%=cmt.getAddDate()%> </span></td>
                </tr>
                <tr>
                  <td><%=cmt.getContent()%></td>
                </tr>
            </table></td>
          </tr>
        </table>        
        <span class="tableframe_comment"> </span>        
      <td height="43" colspan="3" align="center"><span>[ <a onClick="if (!confirm('您确定要删除吗？')) return false" href="comment_m.jsp?op=del&doc_id=<%=doc_id%>&id=<%=cmt.getId()%>">删除</a> ] </span></td>
    </tr>
<%}%>
  </tbody>
</table>
<HR noShade SIZE=1>
<table width="100%" >
  <tr>
    <td align="right"><a href="comment_m.jsp?op=delall&doc_id=<%=doc_id%>">删除所有评论</a></td>
  </tr>
</table>
</body>
</html>