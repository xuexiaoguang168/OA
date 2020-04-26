<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.person.UserDb"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.Paginator"%>
<%@ page import="com.redmoon.oa.netdisk.*"%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="docmanager" scope="page" class="com.redmoon.oa.netdisk.DocumentMgr"/>
<jsp:useBean id="dir" scope="page" class="com.redmoon.oa.netdisk.Directory"/>
<%
String dir_code = ParamUtil.get(request, "dir_code");
String dir_name = "";

int id = 0;

Privilege privilege = new Privilege();
String userName = privilege.getUser(request);

String correct_result = "操作成功！";

Document doc = new Document();

Document template = null;
System.out.print("dir_list.jsp dir_code=" + dir_code + " id=" + id);

Leaf leaf = dir.getLeaf(dir_code);
dir_name = leaf.getName();

LeafPriv lp = new LeafPriv(dir_code);
if (!lp.canUserSee(privilege.getUser(request))) {
	out.print(StrUtil.Alert(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String strtemplateId = ParamUtil.get(request, "templateId");

String op = ParamUtil.get(request, "op");
String work = ParamUtil.get(request, "work"); // init modify

if (op.equals("editarticle")) {
	op = "edit";
	try {
		doc = docmanager.getDocumentByCode(request, dir_code, privilege);
		dir_code = doc.getDirCode();
		
	} catch (ErrMsgException e) {
		out.print(strutil.makeErrMsg(e.getMessage(), "red", "green"));
		return;
	}
}

if (doc!=null) {
	id = doc.getID();
	Leaf lfn = new Leaf();
	lfn = lfn.getLeaf(doc.getDirCode());
	dir_name = lfn.getName();
}
%>
<title><%=doc!=null?doc.getTitle():""%></title>
<script language=JavaScript src='formpost.js'></script>
<script language="JavaScript">
<!--
<%
if (doc!=null) {
	out.println("var id=" + doc.getID() + ";");
}
%>
	var op = "<%=op%>";
	var work = "<%=work%>";

	function SubmitWithFileDdxc() {
		addform.webedit.isDdxc = 1;
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();	
			return false;
		}
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.MTUpload();
		// 因为Upload()中启用了线程的，所以函数在执行后，会立即反回，使得下句中得不到ReturnMessage的值
		// 原因是此时服务器的返回信息还没收到
		// alert("ReturnMessage=" + addform.webedit.ReturnMessage);
	}

	function SubmitWithFileThread() {
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();			
			return false;
		}
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.Upload();
		// 因为Upload()中启用了线程的，所以函数在执行后，会立即反回，使得下句中得不到ReturnMessage的值
		// 原因是此时服务器的返回信息还没收到
		// alert("ReturnMessage=" + addform.webedit.ReturnMessage);
	}
	
	function SubmitWithoutFile() {
		if (document.addform.title.value.length == 0) {
			alert("请输入文章标题.");
			document.addform.title.focus();	
			return false;
		}
		addform.isuploadfile.value = "false";
		loadDataToWebeditCtrl(addform, addform.webedit);
		addform.webedit.UploadMode = 0;
		addform.webedit.UploadArticle();
		addform.isuploadfile.value = "true";
		if (addform.webedit.ReturnMessage == "<%=correct_result%>")
			doAfter(true);
		else
			doAfter(false);		
	}

	function ClearAll() {
		document.addform.title.value=""
		oEdit1.putHTML(" ");
	}
	
	function doAfter(isSucceed) {
		if (isSucceed) {
			if (op=="edit")
			{
				if (work=="modify")
					location.href = "dir_list.jsp?op=editarticle&dir_code=<%=StrUtil.UrlEncode(dir_code)%>";
				else
					location.href = "dir_list.jsp?op=editarticle&dir_code=<%=StrUtil.UrlEncode(dir_code)%>";
			}
			else {
				location.href = "dir_list.jsp?op=editarticle&dir_code=<%=StrUtil.UrlEncode(dir_code)%>";
		    }
		}
		else {
			alert(addform.webedit.ReturnMessage);
		}
	}
	
	function showvote(isshow)
	{
		if (addform.isvote.checked)
		{
			addform.vote.style.display = "";
		}
		else
		{
			addform.vote.style.display = "none";		
		}
	}

function window_onload() {
}

function displayCtlTable(btnObj) {
	if (ctlTable.style.display=="none") {
		ctlTable.style.display = "";
		btnObj.value = "隐 藏";
	}
	else {
		ctlTable.style.display = "none";
		btnObj.value = "上 传";
	}
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" onLoad="window_onload()" style="overflow:auto">
<%
String orderBy = ParamUtil.get(request, "orderBy");
if (orderBy.equals(""))
	orderBy = "name";
String sort = ParamUtil.get(request, "sort");
if (sort.equals(""))
	sort = "asc";	
%>
<TABLE width="100%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0>
  <TR valign="top" bgcolor="#FFFFFF">
    <TD width="" height="430" colspan="2" style="background-attachment: fixed; background-image: url(images/bg_bottom.jpg); background-repeat: no-repeat">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=head>
					&nbsp;&nbsp;
					<%
					Leaf dlf = new Leaf();
					if (doc!=null) {
						dlf = dlf.getLeaf(doc.getDirCode());
					}
					if (doc!=null && dlf.getType()==2) {%>
						<a href="cms/document_list_m.jsp?dir_code=<%=StrUtil.UrlEncode(dir_code)%>&dir_name=<%=StrUtil.UrlEncode(dir_name)%>"><%=dlf.getName()%></a>
					<%}else{%>
						<%=dir_name%>
					<%}%>
				&nbsp;
				<%
				UserDb ud = new UserDb();
				ud = ud.getUserDb(userName);
				String strDiskAllow = NumberUtil.round((double)ud.getDiskSpaceAllowed()/1024000, 3);
				String strDiskHas = NumberUtil.round((double)(ud.getDiskSpaceAllowed()-ud.getDiskSpaceUsed())/1024000, 3);
				%>
				&nbsp;磁盘份额：<%=strDiskAllow%>M &nbsp;剩余空间：<%=strDiskHas%>M&nbsp;&nbsp;				<a href="dir_priv_m.jsp?dirCode=<%=dir_code%>">共享管理</a></TD>
              </TR>
            </TBODY>
          </TABLE>
          <table border="0" cellspacing="0" width="100%" cellpadding="0" align="center">
	<form name="addform" action="fwebedit_do.jsp" method="post">
            <tr align="center">
              <td width="90%" align="left" valign="top" bgcolor="#F2F2F2" class="unnamed2">              </td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#FFFFFF"><table width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="D6D3CE">
                <tr>
                  <td width="40%" align="center"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#aaaaaa" borderColorDark="#ffffff" bgcolor="D6D3CE">
                      <tr>
                        <td style="cursor:hand" onClick="doSort('name')">&nbsp;名称&nbsp;&nbsp;
						  <%if (orderBy.equals("name")) {
							if (sort.equals("asc")) 
								out.print("<img src='images/arrow_up.gif' width=8px height=7px>");
							else
								out.print("<img src='images/arrow_down.gif' width=8px height=7px>");
						}%>
						</td>
                      </tr>
                  </table></td>
                  <td width="13%" bgcolor="#EAE9E6"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#aaaaaa" borderColorDark="#ffffff" bgcolor="D6D3CE">
                      <tr>
                        <td style="cursor:hand" onClick="doSort('file_size')">&nbsp;大小&nbsp;&nbsp;<span style="cursor:hand">
                          <%if (orderBy.equals("file_size")) {
							if (sort.equals("asc")) 
								out.print("<img src='images/arrow_up.gif' width=8px height=7px>");
							else
								out.print("<img src='images/arrow_down.gif' width=8px height=7px>");
						}%>
                        </span></td>
                      </tr>
                    </table></td>
                  <td width="20%" bgcolor="#EAE9E6"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#aaaaaa" borderColorDark="#ffffff" bgcolor="D6D3CE">
                      <tr>
                        <td style="cursor:hand" onClick="doSort('uploadDate')">&nbsp;上传时间                    &nbsp;<span style="cursor:hand">
                          <%if (orderBy.equals("uploadDate")) {
							if (sort.equals("asc")) 
								out.print("<img src='images/arrow_up.gif' width=8px height=7px>");
							else
								out.print("<img src='images/arrow_down.gif' width=8px height=7px>");
						}%>
                        </span></td>
                      </tr>
                  </table></td>
                  <td width="27%" bgcolor="#EAE9E6"><table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#aaaaaa" borderColorDark="#ffffff" bgcolor="D6D3CE">
                      <tr>
                        <td>&nbsp;操作</td>
                      </tr>
                  </table></td>
                </tr>
              </table>
			    <%if (!leaf.getParentCode().equals(Leaf.PARENT_CODE_NONE)) {%>
                <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="3%" align="center"><img src="images/parent.gif" width="20" height="20" align="absmiddle"></td>
                    <td width="37%"><a href="dir_list.jsp?op=editarticle&dir_code=<%=leaf.getParentCode()%>">上级目录</a></td>
                    <td width="13%">&nbsp;</td>
                    <td width="22%">&nbsp;</td>
                    <td width="25%">&nbsp;</td>
                  </tr>
                </table>
                <%}%>
                <%
				Iterator irch = leaf.getChildren().iterator();
				while (irch.hasNext()) {
					Leaf plf = (Leaf)irch.next();
				%>
                <table width="100%"  border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="3%" align="center"><img src="images/folder.gif" width="20" height="20" align="absmiddle"></td>
                    <td width="37%"><a href="dir_list.jsp?op=editarticle&dir_code=<%=plf.getCode()%>"><%=plf.getName()%></a></td>
                    <td width="13%">&nbsp;</td>
                    <td width="22%">&nbsp;</td>
                    <td width="25%">&nbsp;</td>
                  </tr>
                </table>
                <%}%>
                <%
String strcurpage = StrUtil.getNullString(request.getParameter("CPages"));
if (strcurpage.equals(""))
	strcurpage = "1";
if (!StrUtil.isNumeric(strcurpage)) {
	out.print(StrUtil.makeErrMsg("标识非法！"));
	return;
}

Attachment am = new Attachment();
int pagesize = 30;
int curpage = Integer.parseInt(strcurpage);
String sql = "SELECT id FROM netdisk_document_attach WHERE doc_id=" + doc.getID() + " and page_num=1 order by ";
sql += orderBy + " " + sort;
ListResult lr = am.listResult(sql, curpage, pagesize);
int total = lr.getTotal();
Paginator paginator = new Paginator(request, total, pagesize);
// 设置当前页数和总页数
int totalpages = paginator.getTotalPages();
if (totalpages==0)
{
	curpage = 1;
	totalpages = 1;
}
			  if (doc!=null) {
				  // Vector attachments = doc.getAttachments(1);
				  Vector attachments = lr.getResult();
				  Iterator ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	am = (Attachment) ir.next(); %>
					<table width="100%"  border="0" cellspacing="0" cellpadding="0" onMouseOver="this.style.backgroundColor='#FFD6DE'" onMouseOut="this.style.backgroundColor='#ffffff'">
                      <tr>
                        <td width="4%" align="center"><a title="打开文件" target=_blank href="netdisk_getfile.jsp?id=<%=doc.getID()%>&attachId=<%=am.getId()%>"><img src="images/<%=am.getIcon()%>" border="0"></a></td>
                        <td width="37%">&nbsp;
                          <a target=_blank title="打开文件" class="mainA" href="netdisk_getfile.jsp?id=<%=doc.getID()%>&attachId=<%=am.getId()%>"><%=am.getName()%></a></td>
                        <td width="13%"><%=NumberUtil.round((double)am.getSize()/1024, 1)%>KB</td>
                        <td width="19%"><%=DateUtil.format(am.getUploadDate(), "yyyy-MM-dd HH:mm")%></td>
                        <td width="27%">&nbsp;<a href="dir_change.jsp?attachId=<%=am.getId()%>"><img src="images/rename.gif" alt="重命名及移动文件" width="16" height="16" border="0" align="absmiddle"></a> &nbsp;<a href="javascript:delAttach('<%=am.getId()%>', '<%=doc.getID()%>')"><img src="images/del.gif" alt="删除" width="16" height="16" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a target="_blank" href="netdisk_downloadfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>"><img src="images/download.gif" alt="下载" width="16" height="16" border="0" align="absmiddle"></a>
                          <%if (!StrUtil.getNullStr(am.getPublicShareDir()).equals("")) {%>
                          <a href="netdisk_public_share.jsp?attachId=<%=am.getId()%>"><font color="#FF0000">已发布</font></a>
                          <%}else{%>
                          <a href="netdisk_public_share.jsp?attachId=<%=am.getId()%>"><img src="images/share_public.gif" alt="发布" width="16" height="16" border="0" align="absmiddle"></a>
                        <%}%></td>
                      </tr>
                </table>
			  <%}
			  }
			  %></td>
            </tr>
            <tr>
              <td align=center bgcolor="#FFFFFF">
			    <table width="100%" border="0" cellspacing="0" cellpadding="0" name-"ctlTable" id="ctlTable" style="display:none">
                  <tr>
                    <td><table  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                      <tr>
                        <td bgcolor="#FFFFFF"><%
Calendar cal = Calendar.getInstance();
String year = "" + (cal.get(cal.YEAR));
String month = "" + (cal.get(cal.MONTH) + 1);
com.redmoon.oa.Config cfg = new com.redmoon.oa.Config();
String filepath = cfg.get("file_netdisk") + "/" + userName + "/" + year + "/" + month;
%>
                            <object classid="CLSID:DE757F80-F499-48D5-BF39-90BC8BA54D8C" codebase="<%=request.getContextPath()%>/activex/webedit.cab#version=4,0,1,1" width=400 height=173 align="middle" id="webedit">
                              <param name="Encode" value="utf-8">
                              <param name="MaxSize" value="<%=Global.MaxSize%>">
                              <!--上传字节-->
                              <param name="ForeColor" value="(0,0,0)">
                              <param name="BgColor" value="(245,248,247)">
                              <param name="ForeColorBar" value="(255,255,255)">
                              <param name="BgColorBar" value="(0,0,255)">
                              <param name="ForeColorBarPre" value="(0,0,0)">
                              <param name="BgColorBarPre" value="(200,200,200)">
                              <param name="FilePath" value="<%=filepath%>">
                              <param name="Relative" value="1">
                              <!--上传后的文件需放在服务器上的路径-->
                              <param name="Server" value="<%=request.getServerName()%>">
                              <param name="Port" value="<%=request.getServerPort()%>">
                              <param name="VirtualPath" value="<%=Global.virtualPath%>">
                              <param name="PostScript" value="<%=Global.virtualPath%>/netdisk/dir_list_do.jsp">
                              <param name="PostScriptDdxc" value="<%=Global.virtualPath%>/ddxc.jsp">
                              <param name="SegmentLen" value="204800">
                          </object></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td align="center" height="40">&nbsp;
                      <input name="notuploadfile" type="button" class="singleboarder" value=" 上 传 " onClick="return SubmitWithoutFile()">
&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="remsg" type="button" class="singleboarder" onClick='alert(webedit.ReturnMessage)' value="返回信息">
&nbsp;<span class="p14">
<input type="hidden" name=isuploadfile value="true">
<input type="hidden" name=id value="<%=doc!=null?""+doc.getID():""%>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="title" value="<%=leaf.getName()%>">
<input type="hidden" name="dir_code" value="<%=dir_code%>">
<input type="hidden" name="examine" value="<%=Document.EXAMINE_PASS%>">
</span></td>
                  </tr>
              </table>		      </td>
            </tr>
        </form>
      </table>
   
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="30" align="right">共 <b><%=paginator.getTotal() %></b> 个　每页显示 <b><%=paginator.getPageSize() %></b> 个　页次 <b><%=paginator.getCurrentPage() %>/<%=paginator.getTotalPages() %></b>
                  <%
	String querystr = "op=editarticle&orderBy=" + orderBy + "&sort=" + sort + "&dir_code=" + StrUtil.UrlEncode(dir_code);
    out.print(paginator.getCurPageBlock("?"+querystr));
%>
                  <input name="button" type="button" class="button1" onClick="displayCtlTable(this)" value="上 传">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
          </table>
		  <table width="100%"  border="0">
          
          <tr>
            <form name="form3" action="?" method="post"><td align="center">
			<input name="newname" type="hidden">
			</td></form>
          </tr>
      </table>
	</TD>
  </TR>
</TABLE>

<iframe id="hideframe" name="hideframe" src="fwebedit_do.jsp" width=0 height=0></iframe>
</body>
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

function changeAttachName(attach_id, doc_id, nm) {
	var obj = findObj(nm);
	// document.frames.hideframe.location.href = "fwebedit_do.jsp?op=changeattachname&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id + "&newname=" + obj.value
	form3.action = "dir_list_do.jsp?op=changeattachname&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id;
	form3.newname.value = obj.value;
	form3.submit();
}

function delAttach(attach_id, doc_id) {
	if (!window.confirm("您确定要删除吗？")) {
		return;
	}
	document.frames.hideframe.location.href = "dir_list_do.jsp?op=delAttach&page_num=1&doc_id=" + doc_id + "&attach_id=" + attach_id
}

var curOrderBy = "<%=orderBy%>";
var sort = "<%=sort%>";
function doSort(orderBy) {
	if (orderBy==curOrderBy)
		if (sort=="asc")
			sort = "desc";
		else
			sort = "asc";
	window.location.href = "?dir_code=<%=StrUtil.UrlEncode(dir_code)%>&op=editarticle&orderBy=" + orderBy + "&sort=" + sort;
}
</script>
</html>