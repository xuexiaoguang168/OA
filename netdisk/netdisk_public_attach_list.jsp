<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="com.redmoon.oa.netdisk.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>网络硬盘-公共文件列表</title>
<link href="../admin/default.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style type="text/css">
<!--
.style4 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="docmanager" scope="page" class="cn.js.fan.module.cms.DocumentMgr"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String dirCode = ParamUtil.get(request, "dir_code");

String op = ParamUtil.get(request, "op");
if (op.equals("del")) {
	PublicLeafPriv lp = new PublicLeafPriv(dirCode);
	if (lp.canUserManage(privilege.getUser(request))) {
		int delAttachId = ParamUtil.getInt(request, "attach_id");
		int delDocId = ParamUtil.getInt(request, "doc_id");
		Document doc = new Document();
		doc = doc.getDocument(delDocId);
		// 防止删除后反复刷新
		if (doc!=null && doc.isLoaded()) {	
			DocContent dc = doc.getDocContent(1);
			boolean re = dc.delAttachment(delAttachId);	
			if (re)
				out.print(StrUtil.Alert_Redirect("操作成功！", "netdisk_public_attach_list.jsp?dir_code=" + StrUtil.UrlEncode(dirCode)));
			else
				out.print(StrUtil.Alert("操作失败！"));
		}
	}
	else {
		out.print(StrUtil.Alert(cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	}
}
%>
<%
String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
if (strcurpage.equals(""))
	strcurpage = "1";
if (!StrUtil.isNumeric(strcurpage)) {
	out.print(StrUtil.makeErrMsg("标识非法！"));
	return;
}
int pagesize = 10;
int curpage = Integer.parseInt(strcurpage);

PublicLeaf plf = new PublicLeaf();
if (!dirCode.equals("")) {
	plf = plf.getLeaf(dirCode);
	if (plf==null || !plf.isLoaded()) {
		out.print(StrUtil.Alert("节点不存在！"));
		return;
	}
}
String sql = "select id from netdisk_document_attach";
if (!dirCode.equals("") && !dirCode.equals(PublicLeaf.ROOTCODE))
	sql += " where publicShareDir=" + StrUtil.sqlstr(dirCode);
else
	sql += " where publicShareDir<>''";
sql += " order by uploadDate desc";

Attachment att = new Attachment();
ListResult lr = att.listResult(sql, curpage, pagesize);
int total = lr.getTotal();
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}

Vector v = lr.getResult();
Iterator ir = null;
if (v!=null)
	ir = v.iterator();
%>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td height="28" class="head">全局共享 - <%=plf.getName()%></td>
    </tr>
  </tbody>
</table>
<br>
<table width="92%" border="0" align="center" class="p9">
  <tr>
    <td height="24" align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b></td>
  </tr>
</table>
<table style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" cellSpacing="0" cellPadding="3" width="95%" align="center">
  <tbody>
    <tr>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="8%">&nbsp;</td>
      <td class="thead" style="PADDING-LEFT: 10px" noWrap width="30%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">文件名</td>
      <td class="thead" noWrap width="13%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">大小</td>
      <td class="thead" noWrap width="14%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">发布者</td>
      <td class="thead" noWrap width="19%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">时间</td>
      <td class="thead" noWrap width="16%"><img src="../admin/images/tl.gif" align="absMiddle" width="10" height="15">操作</td>
    </tr>
    <%
long fileLength = -1;
UserMgr um = new UserMgr();
Directory dir = new Directory();
DocumentMgr dm = new DocumentMgr();
while (ir.hasNext()) {
 	Attachment am = (Attachment)ir.next();
	String[] depts = StrUtil.split(am.getPublicShareDepts(), ",");
	int len = 0;
	if (depts!=null)
		len = depts.length;
	boolean isValid = false;
	if (privilege.isUserPrivValid(request, com.redmoon.oa.pvg.PrivDb.PRIV_ADMIN))
		isValid = true;
	else {
		if (len>0) {
			DeptUserDb du = new DeptUserDb();
			for (int i=0; i<len; i++) {
				if (du.isUserOfDept(privilege.getUser(request), depts[i])) {
					isValid = true;
					break;
				}
			}
		}
		else
			isValid = true;
	}
	if (isValid) {
		Document doc = dm.getDocument(am.getDocId());
		if (doc==null) {
			// out.print("am.getId=" + am.getId());
			continue;
		}
		Leaf lf = dir.getLeaf(doc.getDirCode());
		fileLength = (long)am.getSize()/1024; 
		if(fileLength == 0 && (long)am.getSize() > 0)
			fileLength = 1;  
	%>
    <tr class="row" style="BACKGROUND-COLOR: #ffffff">
      <td style="PADDING-LEFT: 10px"><a href="netdisk_getfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>" target="_blank"><img src="../netdisk/images/<%=am.getIcon()%>" border="0"></a></td>
      <td style="PADDING-LEFT: 10px"><a href="netdisk_getfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>" target="_blank"><%=am.getName()%></a></td>
      <td><%=fileLength%>&nbsp;KB</td>
      <td><%
	  UserDb ud = um.getUserDb(lf.getRootCode());
	  out.print(ud.getRealName());
	  %>
      </td>
      <td><%=DateUtil.format(am.getUploadDate(), "yy-MM-dd HH:mm")%></td>
      <td><a href="netdisk_getfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>" target="_blank">打开</a>&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="netdisk_downloadfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>">下载</a>&nbsp;&nbsp;
        <%
	PublicLeafPriv lp = new PublicLeafPriv(am.getPublicShareDir());
	if (lp.canUserManage(privilege.getUser(request))) {%>
		<BR><a href="#" onClick="if (confirm('您确定要删除吗？')) window.location.href='?op=del&dir_code=<%=StrUtil.UrlEncode(dirCode)%>&doc_id=<%=am.getDocId()%>&attach_id=<%=am.getId()%>'">删除</a> &nbsp;&nbsp;<a href="netdisk_public_share.jsp?attachId=<%=am.getId()%>">修改</a>
	<%}%></td>
    </tr>
	<%}%>
<%}%>
  </tbody>
</table>
<table width="96%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="right">&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%
	String querystr = "dir_code=" + StrUtil.UrlEncode(dirCode) + "&op="+op;
    out.print(paginator.getCurPageBlock("?"+querystr));
%></td>
  </tr>
</table>
<hr noshade size=1>
</body>
<script language="javascript">
<!--
//-->
</script>
</html>