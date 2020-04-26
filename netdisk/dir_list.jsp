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
<style>
.skin0 {
padding-top:2px;
cursor:default;
font:menutext;
position:absolute;
text-align:left;
font-family: "宋体";
font-size: 9pt;
width:80px;              /*宽度，可以根据实际的菜单项目名称的长度进行适当地调整*/
background-color:menu;    /*菜单的背景颜色方案，这里选择了系统默认的菜单颜色*/
border:1 solid buttonface;
visibility:hidden;        /*初始时，设置为不可见*/
border:2 outset buttonhighlight;
}

/*定义菜单条的显示样式*/
.menuitems {
padding:2px 1px 2px 10px;
}
.STYLE1 {color: #FFFFFF}
</style>
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

Leaf leaf = dir.getLeaf(dir_code);
if (leaf==null || !leaf.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "该目录已不存在！"));
	return;
}

dir_name = leaf.getName();

LeafPriv lp = new LeafPriv(dir_code);
if (!lp.canUserSee(privilege.getUser(request))) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request, "pvg_invalid")));
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

String action = ParamUtil.get(request, "action");
if (action.equals("changeName")) {
	boolean re = false;
	try {
		re = docmanager.updateAttachmentName(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
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
function OfficeOperate() {
	alert(redmoonoffice.ReturnMessage.substring(0, 4)); // 防止后面跟乱码
}

// 编辑文件
function editdoc(id, attachId)
{
	rmofficeTable.style.display = "";
	redmoonoffice.AddField("id", id);
	redmoonoffice.AddField("attachId", attachId);
	redmoonoffice.Open("<%=Global.getRootPath()%>/netdisk/netdisk_office_get.jsp?id=" + id + "&attachId=" + attachId);
}

<%
if (doc!=null) {
	out.println("var id=" + doc.getID() + ";");
}
%>
var id = "<%=id%>"; // 用于右键菜单
var curAttachId = "";
var curAttachName = "";

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

function checkWebEditInstalled() {
	var bCtlLoaded = false;
	try	{
		if (typeof(addform.webedit.AddField)=="undefined")
			bCtlLoaded = false;
		if (typeof(addform.webedit.AddField)=="unknown") {
			bCtlLoaded = true;
		}
	}
	catch (ex) {
	}
	if (!bCtlLoaded) {
		if (confirm("您还没有安装WebEdit在线编辑控件！请点击确定按钮下载安装！")) {
			window.open("activex/oa_client.EXE");
		}
	}	
}

function checkOfficeEditInstalled() {
	var bCtlLoaded = false;
	try	{
		if (typeof(redmoonoffice.AddField)=="undefined")
			bCtlLoaded = false;
		if (typeof(redmoonoffice.AddField)=="unknown") {
			bCtlLoaded = true;
		}
	}
	catch (ex) {
	}
	if (!bCtlLoaded) {
		if (confirm("您还没有安装Office在线编辑控件！请点击确定按钮下载安装！")) {
			window.open("activex/oa_client.EXE");
		}
	}	
}

function window_onload() {
	checkOfficeEditInstalled();
	checkWebEditInstalled();
}

function displayCtlTable(btnObj) {
	if (ctlTable.style.display=="none") {
		ctlTable.style.display = "";
		addform.webedit.height = "173px";
		btnObj.value = "隐 藏";
	}
	else {
		ctlTable.style.display = "none";
	
		//addform.webedit.height = "0px";
			//alert("test")
		btnObj.value = "上 传";
	}
	    
}

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
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" onLoad="window_onload()" style="overflow:auto">
<%
if (!privilege.isUserLogin(request))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
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
                    <td width="37%"><a href="dir_list.jsp?op=editarticle&dir_code=<%=leaf.getParentCode()%>" onMouseUp="curAttachId=''">上级目录</a></td>
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
                    <td width="37%"><a href="dir_list.jsp?op=editarticle&dir_code=<%=plf.getCode()%>" onMouseUp="curAttachId=''"><%=plf.getName()%></a></td>
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
long fileLength = -1;
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
				  	am = (Attachment) ir.next(); 
					fileLength = (long)am.getSize()/1024; 
					if(fileLength == 0 && (long)am.getSize() > 0)
						fileLength = 1;  
					%>
					<table width="100%"  border="0" cellspacing="0" cellpadding="0" onMouseOver="this.style.backgroundColor='#FFD6DE'" onMouseOut="this.style.backgroundColor='#ffffff'">
                      <tr>
                        <td width="4%" align="center"><a title="打开文件" target=_blank href="netdisk_getfile.jsp?id=<%=doc.getID()%>&attachId=<%=am.getId()%>"><img src="images/<%=am.getIcon()%>" border="0"></a></td>
                        <td width="37%">&nbsp;
                          <span id="span<%=am.getId()%>" name="span<%=am.getId()%>"><a target=_blank title="打开文件" class="mainA" href="netdisk_getfile.jsp?id=<%=doc.getID()%>&attachId=<%=am.getId()%>" onmouseup='onMouseUp("<%=am.getId()%>", "<%=am.getName()%>")'><%=am.getName()%></a></span></td>
                        <td width="13%"><%=fileLength%>KB</td>
                        <td width="19%"><%=DateUtil.format(am.getUploadDate(), "yyyy-MM-dd HH:mm")%></td>
                        <td width="27%">&nbsp;<a href="dir_change.jsp?attachId=<%=am.getId()%>"><img src="images/rename.gif" alt="重命名或移动文件" width="16" height="16" border="0" align="absmiddle"></a> &nbsp;<a href="javascript:delAttach('<%=am.getId()%>', '<%=doc.getID()%>')"><img src="images/del.gif" alt="删除" width="16" height="16" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a target="_blank" href="netdisk_downloadfile.jsp?id=<%=am.getDocId()%>&attachId=<%=am.getId()%>"><img src="images/download.gif" alt="下载" width="16" height="16" border="0" align="absmiddle"></a>
                          <%if (!StrUtil.getNullStr(am.getPublicShareDir()).equals("")) {%>
                          <a href="netdisk_public_share.jsp?attachId=<%=am.getId()%>"><img src="images/share_public_yes.gif" alt="已发布" width="16" height="16" border="0" align="absmiddle"></a>
                          <%}else{%>
                          <a href="netdisk_public_share.jsp?attachId=<%=am.getId()%>"><img src="images/share_public.gif" alt="发布" width="16" height="16" border="0" align="absmiddle"></a>
                        <%}%>
                        <%if (am.getExt().equals("doc") || am.getExt().equals("xls")) {%>
                        <a href="javascript:editdoc('<%=id%>', '<%=am.getId()%>')" title="编辑Office文件"><img src="images/btn_edit_office.gif" width="16" height="16" border="0" align="absmiddle"></a>
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
                            <div style="width:400;height:0"><object classid="CLSID:DE757F80-F499-48D5-BF39-90BC8BA54D8C" codebase="<%=request.getContextPath()%>/activex/webedit.cab#version=4,0,1,1" width=400 height=0 align="middle" id="webedit">
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
                          </object></div></td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td align="center" height="40">
					                      <input name="notuploadfile" type="button" class="singleboarder" value="上传大文件" onClick="return SubmitWithFileThread()">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
		  <table id="rmofficeTable" name="rmofficeTable" style="display:none" width="29%"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr>
              <td height="22" align="center" bgcolor="#E3E3E3"><strong>&nbsp;编辑Office文件</strong></td>
            </tr>
            <tr>
              <td align="center" bgcolor="#FFFFFF"><div style="width:316;height:43"><object id="redmoonoffice" classid="CLSID:D01B1EDF-E803-46FB-B4DC-90F585BC7EEE" 
codebase="<%=request.getContextPath()%>/activex/rmoffice.cab#version=2,0,0,1" width="316" height="43" viewastext="viewastext">
                  <param name="Encode" value="utf-8" />
                  <param name="BackColor" value="0000ff00" />
                  <param name="Server" value="<%=Global.server%>" />
                  <param name="Port" value="<%=Global.port%>" />
                  <!--设置是否自动上传-->
                  <param name="isAutoUpload" value="1" />
                  <!--设置文件大小不超过1M-->
                  <param name="MaxSize" value="<%=Global.FileSize%>" />
                  <!--设置自动上传前出现提示对话框-->
                  <param name="isConfirmUpload" value="1" />
                  <!--设置IE状态栏是否显示信息-->
                  <param name="isShowStatus" value="0" />
                  <param name="PostScript" value="<%=Global.virtualPath%>/netdisk/netdisk_office_upload.jsp" />
                </object></div>
                  <!--<input name="remsg" type="button" onclick='alert(redmoonoffice.ReturnMessage)' value="查看上传后的返回信息" />--></td>
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
<div id="ie5menu" class="skin0" onMouseover="highlightie5(event)" onMouseout="lowlightie5(event)" onClick="jumptoie5(event)" style="display:none">
<div class="menuitems" url="javascript:openFile()">打开</div>
<div class="menuitems" url="javascript:changeName()">重命名</div>
<div class="menuitems" url="javascript:move()">移动文件</div>
<div class="menuitems" url="javascript:del()">删除</div>
<div class="menuitems" url="javascript:download()">下载</div>
<div class="menuitems" url="javascript:publicShare()">发布</div>
<hr width=100%>
<div class="menuitems" url="dir_list.jsp?op=editarticle&dir_code=<%=StrUtil.UrlEncode(dir_code)%>">刷新</div>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<form name=form10 action="?">
<tr><td>&nbsp;
<input name="op" type="hidden" value="editarticle">
<input name="action" type="hidden">
<input name="dir_code" type="hidden" value="<%=dir_code%>">
<input name="newname" type="hidden">
<input name="attach_id" type="hidden">
<input name="doc_id" type="hidden" value="<%=id%>">
<input name="page_num" type="hidden" value="1">
<input name="CPages" type="hidden" value="<%=curpage%>"></td></tr>
</form>
</table>
<iframe id="hideframe" name="hideframe" src="fwebedit_do.jsp" width=0 height=0></iframe>
</body>
<script>
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
<script language="JavaScript1.2">

//set this variable to 1 if you wish the URLs of the highlighted menu to be displayed in the status bar
var display_url=0

var ie5=document.all&&document.getElementById
var ns6=document.getElementById&&!document.all
if (ie5||ns6)
var menuobj=document.getElementById("ie5menu")

function showmenuie5(e){
if (curAttachId=="")
	return;
//Find out how close the mouse is to the corner of the window
var rightedge=ie5? document.body.clientWidth-event.clientX : window.innerWidth-e.clientX
var bottomedge=ie5? document.body.clientHeight-event.clientY : window.innerHeight-e.clientY

//if the horizontal distance isn't enough to accomodate the width of the context menu
if (rightedge<menuobj.offsetWidth)
//move the horizontal position of the menu to the left by it's width
menuobj.style.left=ie5? document.body.scrollLeft+event.clientX-menuobj.offsetWidth : window.pageXOffset+e.clientX-menuobj.offsetWidth
else
//position the horizontal position of the menu where the mouse was clicked
menuobj.style.left=ie5? document.body.scrollLeft+event.clientX : window.pageXOffset+e.clientX

//same concept with the vertical position
if (bottomedge<menuobj.offsetHeight)
menuobj.style.top=ie5? document.body.scrollTop+event.clientY-menuobj.offsetHeight : window.pageYOffset+e.clientY-menuobj.offsetHeight
else
menuobj.style.top=ie5? document.body.scrollTop+event.clientY : window.pageYOffset+e.clientY

menuobj.style.visibility="visible"
return false
}

function hidemenuie5(e){
menuobj.style.visibility="hidden"
}

function highlightie5(e){
var firingobj=ie5? event.srcElement : e.target
if (firingobj.className=="menuitems"||ns6&&firingobj.parentNode.className=="menuitems"){
if (ns6&&firingobj.parentNode.className=="menuitems") firingobj=firingobj.parentNode //up one node
firingobj.style.backgroundColor="highlight"
firingobj.style.color="white"
if (display_url==1)
window.status=event.srcElement.url
}
}

function lowlightie5(e){
var firingobj=ie5? event.srcElement : e.target
if (firingobj.className=="menuitems"||ns6&&firingobj.parentNode.className=="menuitems"){
if (ns6&&firingobj.parentNode.className=="menuitems") firingobj=firingobj.parentNode //up one node
firingobj.style.backgroundColor=""
firingobj.style.color="black"
window.status=''
}
}

function jumptoie5(e){
var firingobj=ie5? event.srcElement : e.target
if (firingobj.className=="menuitems"||ns6&&firingobj.parentNode.className=="menuitems"){
if (ns6&&firingobj.parentNode.className=="menuitems") firingobj=firingobj.parentNode
if (firingobj.getAttribute("target"))
window.open(firingobj.getAttribute("url"),firingobj.getAttribute("target"))
else
window.location=firingobj.getAttribute("url")
}
}

if (ie5||ns6){
menuobj.style.display=''
document.oncontextmenu=showmenuie5
document.onclick=hidemenuie5
}

function onMouseUp(attachId, attachName) {
	// 左键
	curAttachId = attachId;
	curAttachName = attachName;
	if (event.button==1) {
		// alert(id + "_" + attachId);
	}
	// 右键
	if (event.button==2) {
		// alert(id + "_" + attachId);
	}
}

var spanInnerHTML = "";
function changeName() {
	if (curAttachId!="") {
		spanObj = findObj("span" + curAttachId);
		spanInnerHTML = spanObj.innerHTML;
		spanObj.innerHTML = "<input name='newName' class=singleboarder size=22 value='" + curAttachName + "' onblur=\"doChange('" + curAttachId + "',this.value,'" + curAttachName + "'," + spanObj.name + ")\" onKeyDown=\"if (event.keyCode==13) this.blur()\">";
		addform.newName.focus();
		addform.newName.select();
	}
}

function doChange(attachId, newName, oldName, spanObj) {
	if (newName!=oldName) {
		form10.action.value = "changeName";
		form10.attach_id.value = attachId;
		form10.newname.value = newName;
		form10.submit();
	}
	else {
		spanObj.innerHTML = spanInnerHTML;
	}
	curAttachId = "";
}

function move() {
	window.location.href = "dir_change.jsp?attachId=" + curAttachId;
}

function del() {
	delAttach(curAttachId, id);
}

function openFile() {
	window.open("netdisk_getfile.jsp?id=" + id + "&attachId=" + curAttachId);
}

function download() {
	window.open("netdisk_downloadfile.jsp?id=" + id + "&attachId=" + curAttachId);
}

function publicShare() {
	window.location.href = "netdisk_public_share.jsp?attachId=" + curAttachId;
}
</script>
</html>