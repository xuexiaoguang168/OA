<%@ page contentType="text/html;charset=utf-8" language="java" errorPage="" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="cn.js.fan.module.cms.plugin.teach.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%
int id = 0;
String dirCode = ParamUtil.get(request, "dir_code");
boolean isDirArticle = false;
Leaf lf = new Leaf();

if (!dirCode.equals("")) {
	lf = lf.getLeaf(dirCode);
	if (lf!=null) {
		if (lf.getType()==1) {
			id = lf.getDocID();
			isDirArticle = true;
		}
	}
}

if (id==0) {
	try {
		id = ParamUtil.getInt(request, "id");
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.makeErrMsg(e.getMessage()));
		return;
	}
}
Document doc = null;
DocumentMgr docmgr = new DocumentMgr();
doc = docmgr.getDocument(id);
if (!doc.isLoaded()) {
	out.print(StrUtil.makeErrMsg("该文章不存在！"));
	return;
}

TeachDocumentDb tdd = new TeachDocumentDb();
tdd = tdd.getTeachDocumentDb(doc.getID());

if (!isDirArticle)
	lf = lf.getLeaf(doc.getDirCode());

String CPages = ParamUtil.get(request, "CPages");
int pageNum = 1;
if (StrUtil.isNumeric(CPages))
	pageNum = Integer.parseInt(CPages);

String op = ParamUtil.get(request, "op");
String view = ParamUtil.get(request, "view");
String sCurSpeed = ParamUtil.get(request, "curSpeed");
if (sCurSpeed.equals(""))
	sCurSpeed = "1"; // 普通速度
int curSpeed = 1;
if (StrUtil.isNumeric(sCurSpeed))
	curSpeed = Integer.parseInt(sCurSpeed);
CommentMgr cm = new CommentMgr();
if (op.equals("addcomment")) {
	try {
		cm.insert(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}

if (op.equals("vote")) {
	try {
		docmgr.vote(request,id);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<%=cfg.getProperty("Application.name")%>
 - <%=doc.getTitle()%></title>
<style type="text/css">
#floater {
	position: absolute;
	left: 0;
	top: 0;
	visibility: visible;
	z-index: 10;
	cursor:hand;
	width: 100%;
}
</style>
<link href="common.css" rel="stylesheet" type="text/css">
<script src="doc_show.js">
</script>
<script src="floater.js" LANGUAGE="javascript">
</script>
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

function window_onload() {
	eSentenceAry = parseContent(content, true);
	cSentenceAry = parseContent(content, false);
	show("yw");
	// 建立播放列表	
    <%
  	if (doc!=null) {
		  java.util.Vector attachments = doc.getAttachments(pageNum);
		  int size = attachments.size();
		  int speedCount = tdd.getSpeedCount();
		  if (curSpeed>speedCount)
		  	curSpeed = 1;
		  // 根据当前速度，判断列表应取哪些文件
		  int begin=0,end=size-1;
		  int fileCount = size/speedCount; // 一种语速所包含的语音文件数
		  begin = (curSpeed-1)*(fileCount);
		  end = curSpeed*fileCount-1;
          for (int i=begin; i<=end; i++) {
              Attachment am = (Attachment)attachments.get(i); %>
              mkList("../../../<%=am.getVisualPath() + "/" + am.getDiskName()%>", "<%=am.getName()%>");
		  <%}
    }%>
	
	// 示例
	// mkList("http://localhost:8080/zjrj/exobud/sample/dxh.wma","丁香花");
	// 初始化播放器
	initExobud();
	
	// 检测播放索引值
	setTimeout("updateTextColor()",1000);	
}

function updateTextColor()
{
	var spanEN = findObj("en_" + cActIdx);	
	var spanCN = findObj("cn_" + cActIdx);
	try {
		if (typeof(spanEN)=="object") {
			if (spanEN.innerHTML!=null)
				spanEN.innerHTML = "<font color=red>" + spanEN.innerHTML + "</font>";
		}
	}
	catch (e) {}
	try {
		if (typeof(spanCN)=="object") {
			spanCN.innerHTML = "<font color=blue>" + spanCN.innerHTML + "</font>";
		}
	}
	catch (e) {}
	setTimeout("updateTextColor()",1000);
}
</script>
<style type="text/css">
<!--
.STYLE1 {color: #FFFFFF}
-->
</style></head>
<body onLoad="window_onload()"><table ID="floater" name="floater" cellpadding="0" cellspacing="0">
      <tr>
        <td><table width="100%" border="0" align="center" cellspacing="0" class=p9>
          <tr>
            <td width="100%" height="26" background="images/bg.gif">&nbsp;<span >版式
              <select id="mode" name="mode" onChange="show(this.options[this.selectedIndex].value)" style="height:18">
                        <option value="yw">原文</option>
                        <option value="yiw">译文</option>
                        <option value="zydb">左右对比</option>
                        <option value="dldb">段落对比</option>
                        <option value="jzdb">句子对比</option>
            </select>
              语速：
              <select name=speedCount onChange="window.location.href='doc_show.jsp?id=<%=doc.getID()%>&curSpeed='+this.options[this.selectedIndex].value+''" style="height:18">
                <option value=1>普通</option>
                <option value=2>慢速</option>
                <option value=3>快速</option>
              </select>
              <script>
speedCount.value = "<%=curSpeed%>";
        </script></span>
  </td>
          </tr><tr><td bgcolor="#FFFFFF">
                <%@ include file="../../../exobud/exobud.jsp"%>
              </td>
          </tr>
        </table></td>
      </tr>
    </table>
<table width="100%" height="623"  border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#FFFFFF">
  <tr>
    <td width=""></td>
  </tr>
  <tr>
    <td height="86" align="center">
        <br>
        <br>
        <br>
        <br>
        <%if (doc.isLoaded()) {%>
        <b><font size="3"> <%=doc.getTitle()%></font></b>&nbsp;[<%=doc.getModifiedDate()%> 访问次数：<%=doc.getHit()%>]
      <%}else{%>
      未找到该文章！
      <%}%>
      <br>
      <br></td>
  </tr>
  <tr>
    <td valign="top"><%
	com.redmoon.oa.pvg.Privilege privilege = new com.redmoon.oa.pvg.Privilege();
    LeafPriv lp = new LeafPriv();
	lp.setDirCode(doc.getDirCode());
    if (!lp.canUserSee(privilege.getUser(request))) {
		out.print(StrUtil.makeErrMsg(privilege.MSG_INVALID) + "<BR><BR>");
	}
	else {
		if (doc!=null && pageNum==1) {
			// 使点击量增1
			doc.increaseHit();
		}
	%>
        <textarea name="textarea" cols="60" rows="10" id="content" style="display:none"><%if (doc.isLoaded()) {%><%=doc.RenderContent(request, pageNum)%><%}%>
                </textarea>
        <div id="contentView" style="width:100%"></div>
      <br>
        <br>
        <%
				if (doc!=null) {
					  java.util.Vector attachments = doc.getAttachments(pageNum);
					  java.util.Iterator ir = attachments.iterator();
					  while (ir.hasNext()) {
						Attachment am = (Attachment) ir.next(); %>
        <table width="569"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="91" align="right"><img src="../../../images/attach.gif"></td>
            <td width="478">&nbsp; <a target=_blank href="<%=am.getVisualPath() + "/" + am.getDiskName()%>"><%=am.getName()%></a> </td>
          </tr>
        </table>
      <%}
				}%>
        <%if (doc.getType()==1 && (op.equals("") || !op.equals("vote"))) {
					String[] voptions = doc.getVoteOption().split("\\|");
					int len = voptions.length; %>
        <table width="100%" >
          <form action="?op=vote" name=formvote method="post">
            <input type=hidden name=op value="vote">
            <input type=hidden name=id value="<%=doc.getID()%>">
            <%for (int k=0; k<len; k++) { %>
            <tr>
              <td width="5%"><%=k+1%>、 </td>
              <td width="73%"><input class="n" type=radio name=votesel value="<%=k%>">
                  <%=voptions[k]%> </td>
              <td>&nbsp;</td>
            </tr>
            <% } %>
            <tr>
              <td colspan="2" align="center"><input name="Submit" type="submit" class="singleboarder" value=" 投  票 ">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input name="btn" type="button" class="singleboarder" value="查看结果" onClick="window.location.href='doc_show.jsp?id=<%=id%>?view=result'"></td>
              <td width="22%">&nbsp;</td>
            </tr>
          </form>
        </table>
      <%}%>
        <br>
        <%if (view.equals("result") || op.equals("vote")) {
					String[] result = doc.getVoteResult().split("\\|");
					int len = result.length;
					int[] re = new int[len];
					int[] bfb = new int[len];
					int total = 0;
					for (int k=0; k<len; k++) {
						re[k] = Integer.parseInt(result[k]);
						total += re[k];
					}
					if (total!=0) {
						for (int k=0; k<len; k++) {
							bfb[k] = (int)Math.round((double)re[k]/total*100);
						}
					}
		%>
        <table class=p9 width="98%" border="0" cellpadding="0" cellspacing="1" height="100">
          <% for (int k=0; k<len; k++) { %>
          <tr bgcolor="#FEF2E9">
            <td width="5%"><%=k+1%>、</td>
            <td width="59%"><img src=images/bar.gif width=<%=bfb[k]*2%> height=10></td>
            <td width="17%" align="right"><%=re[k]%>人</td>
            <td width="19%" align="right"><%=bfb[k]%>%</td>
          </tr>
          <%}%>
          <tr bgcolor="#FEF2E9">
            <td colspan="4" align="center">共有<%=total%>人参加调查</td>
          </tr>
        </table>
      <%}%>
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="24" align="center">文章共<%=doc.getPageCount()%>页&nbsp;&nbsp;页码
              <%
					int pagesize = 1;
					int total = DocContent.getContentCount(doc.getID());
					int curpage,totalpages;
					Paginator paginator = new Paginator(request, total, pagesize);
					// 设置当前页数和总页数
					totalpages = paginator.getTotalPages();
					curpage	= paginator.getCurrentPage();
					if (totalpages==0)
					{
						curpage = 1;
						totalpages = 1;
					}
					
					String querystr = "op=edit&id=" + id;
					out.print(paginator.getCurPageBlock("?"+querystr));
					%></td>
          </tr>
        </table>
      <%}%>
        <br>
    </td>
  </tr>
</table>
</body>
</html>
