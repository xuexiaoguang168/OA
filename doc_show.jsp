<%@ page contentType="text/html;charset=utf-8" language="java" errorPage="" %>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="cn.js.fan.module.web.*"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%
com.redmoon.oa.pvg.Privilege privilege = new com.redmoon.oa.pvg.Privilege();

int id = 0;
String dirCode = ParamUtil.get(request, "dir_code");
boolean isDirArticle = false;
Leaf lf = new Leaf();

Document doc = null;
DocumentMgr docmgr = new DocumentMgr();

if (!dirCode.equals("")) {
	lf = lf.getLeaf(dirCode);
	if (lf!=null) {
		if (lf.getType()==1) {
			// id = lf.getDocID();
			doc = docmgr.getDocumentByCode(request, dirCode, privilege);
			id = doc.getID();
			isDirArticle = true;
		}
	}
}

if (id==0) {
	try {
		id = ParamUtil.getInt(request, "id");
		doc = docmgr.getDocument(id);
	}
	catch (ErrMsgException e) {
		out.print(SkinUtil.makeErrMsg(request, e.getMessage()));
		return;
	}
}

if (!doc.isLoaded()) {
	out.print(SkinUtil.makeErrMsg(request, "该文章不存在！"));
	return;
}
if (!isDirArticle)
	lf = lf.getLeaf(doc.getDirCode());

String CPages = ParamUtil.get(request, "CPages");
int pageNum = 1;
if (StrUtil.isNumeric(CPages))
	pageNum = Integer.parseInt(CPages);

String op = ParamUtil.get(request, "op");
String view = ParamUtil.get(request, "view");
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
		response.sendRedirect("doc_show.jsp?id=" + id);
		return;		
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Global.AppName%> - <%=doc.getTitle()%></title>
<link rel="stylesheet" href="common.css" type="text/css">
</head>
<body>
<%
if (!privilege.isUserPrivValid(request, "read"))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

    LeafPriv lp = new LeafPriv();
	lp.setDirCode(doc.getDirCode());
    if (!lp.canUserSee(privilege.getUser(request))) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}
	else {
		if (doc!=null && pageNum==1) {
			// 使点击量增1
			doc.increaseHit();
		}
%>
<table width="100%"  border="0" align="center" cellpadding="3" cellspacing="0" class="tableframe">
  <tr>
    <td width="86%" class="right-title">&nbsp;
      <a href="doc_list.jsp?dir_code=<%=StrUtil.UrlEncode(lf.getCode())%>" class="title_white"><%=lf.getName()%></a></td>
    <td width="14%" align="center" class="right-title"><%
	if (lp.canUserModify(privilege.getUser(request))) {
	%>
      <a href="fwebedit.jsp?op=edit&id=<%=doc.getID()%>&dir_code=<%=StrUtil.UrlEncode(doc.getDirCode())%>&dir_name=<%=StrUtil.UrlEncode(lf.getName())%>" class="title_white">编辑</a>
      <%
	}
	%></td>
  </tr>
  <tr>
    <td height="79" colspan="2" align="center" bgcolor="#FFFFFF"><table cellSpacing="0" cellPadding="5" width="100%" align="center" border="0">
      <tbody>
        <tr>
          <td height="39" align="center"><%if (doc.isLoaded()) {%>
                <b><font size="3"> <%=doc.getTitle()%></font></b>&nbsp; </td>
        </tr>
        <tr>
          <td height="28" align="right" bgcolor="#e4e4e4"><%if (!doc.getAuthor().equals("")){%>
            作者：<%=doc.getAuthor()%>&nbsp;
            <%}%>
            &nbsp;&nbsp;日期：<%=doc.getModifiedDate()%>&nbsp;&nbsp;访问次数：<%=doc.getHit()%>
            <%}else{%>
            未找到该文章！
            <%}%>
            &nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
      </tbody>
    </table>
    <br></td>
  </tr>
  <tr>
    <td colspan="2" bgcolor="#FFFFFF">
			  <%
                java.util.Vector attachments = doc.getAttachments(pageNum);
                java.util.Iterator ir = attachments.iterator();
                String str = "";
				int m=0;
                while (ir.hasNext()) {
                    Attachment am = (Attachment)
                                    ir.next();
                    // 根据其diskName取出ext
                    String ext = StrUtil.getFileExt(am.getDiskName());
                    String link = am.getVisualPath() + "/" + am.getDiskName();
                    if (ext.equals("mp3") || ext.equals("wma")) {
                        // 使用realplay会导致IE崩溃
                        // str += "<div><OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=500 height=80><PARAM NAME=SRC VALUE='" + link + "'><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=500><PARAM NAME=SRC VALUE='" + link + "'><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT></div>";
                        if (m==0) {
                            str += "<table align=center width=500><object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=500 height=70><param name=ShowStatusBar value=-1><param name=Filename value='" +
                                    link + "'><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src='" +
                                    link +
                                    "'  width=500 height=70></embed></object></td></tr></table><BR>";
                        } else {
                            str += "<table align=center width=500><object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=500 height=70><param name=ShowStatusBar value=-1><param name=Filename value='" +
                                    link + "'><param name='AutoStart' value=0><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src='" +
                                    link +
                                    "'  width=500 height=70></embed></object></td></tr></table><BR>";
                        }
                    }else if (ext.equals("wmv") || ext.equals("mpg") || ext.equals("avi")) {
                        // 使用realplay会导致IE崩溃
                        // str += "<div><OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=500 height=80><PARAM NAME=SRC VALUE='" + link + "'><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=500><PARAM NAME=SRC VALUE='" + link + "'><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT></div>";
                        if (m==0) {
                            str += "<table align=center width=500><object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=500 height=400><param name=ShowStatusBar value=-1><param name=Filename value='" +
                                    link + "'><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src='" +
                                    link +
                                    "'  width=500 height=70></embed></object></td></tr></table><BR>";
                        } else {
                            str += "<table align=center width=500><object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=500 height=400><param name=ShowStatusBar value=-1><param name=Filename value='" +
                                    link + "'><param name='AutoStart' value=0><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src='" +
                                    link +
                                    "'  width=500 height=70></embed></object></td></tr></table><BR>";
                        }
                    } else if (ext.equals("rm") || ext.equals("rmvb")) {
                        if (m==0)
                            str += "<table align=center width=500><OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=500 height=380><PARAM NAME=SRC VALUE='" +
                                    link + "'><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=500><PARAM NAME=SRC VALUE='" +
                                    link + "'><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT></td></tr></table><BR>";
                        else
                            str += "<table align=center width=500><OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=500 height=380><PARAM NAME=SRC VALUE='" +
                                    link + "'><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=false></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=500><PARAM NAME=SRC VALUE='" +
                                    link + "'><PARAM NAME=AUTOSTART VALUE=0><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT></td></tr></table><BR>";
                    }
					m++;
                }
				out.print(str);
			  %>	
	
	<%if (doc.isLoaded()) {%>
        <%=doc.getContent(pageNum)%>
        <%}%>
        <br>
        <br>
        <%
			  if (doc!=null) {
				  //java.util.Vector attachments = doc.getAttachments(pageNum);
				  ir = attachments.iterator();
				  while (ir.hasNext()) {
				  	Attachment am = (Attachment) ir.next(); %>
        <table width="569"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="91" align="right"><img src=images/attach.gif></td>
            <td width="478">&nbsp;<a target=_blank href="doc_getfile.jsp?pageNum=<%=pageNum%>&id=<%=doc.getID()%>&attachId=<%=am.getId()%>"><%=am.getName()%></a>&nbsp;下载次数&nbsp;<%=am.getDownloadCount()%></td>
          </tr>
        </table>
      <%}
			  }
			  %>
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
                <input name="btn" type="button" class="singleboarder" value="查看结果" onClick="window.location.href='doc_show.jsp?id=<%=id%>&view=result'"></td>
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
          <%
		  int barId = 0;
		  for (int k=0; k<len; k++) { %>
          <tr bgcolor="#FEF2E9">
            <td width="5%"><%=k+1%>、</td>
            <td width="59%">
				  <img src="forum/images/vote/bar<%=barId%>.gif" width=<%=bfb[k]*2%> height=10>
			</td>
            <td width="17%" align="right"><%=re[k]%>人</td>
            <td width="19%" align="right"><%=bfb[k]%>%</td>
          </tr>
          <%
				barId ++;
				if (barId==10)
					barId = 0;		  
		  }%>
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
					out.print(paginator.getCurPageBlock("doc_show.jsp?"+querystr));
					%></td>
          </tr>
        </table>
      <table height="20" cellSpacing="0" cellPadding="5" width="99%" align="center" bgColor="#e4e4e4" border="0">
          <tbody>
            <tr>
              <td><%if (doc.getCanComment()) {%>
                  <img height="15" src="images/comment.gif" width="19" align="absMiddle"><a href="#comment">发表评论</a>
                  <%}%>
                  <img height="15" src="images/question.gif" width="19" align="absMiddle"><a target="_blank" href="jump.jsp?fromWhere=oa&toWhere=forum">提出问题</a></td>
            </tr>
          </tbody>
      </table>
      <br>
        <table width="98%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="5"></td>
            <td><%
ir = cm.getList(id);
while (ir.hasNext()) {
	Comment cmt = (Comment) ir.next();
%>
                <table width="480" >
                  <tr>
                    <td width="607" height="27"><span class="style1">评论</span>：</td>
                  </tr>
                </table>
              <table width="480" cellpadding="0" cellspacing="0" >
                  <tr>
                    <td height="43" align="center" class="tableframe_comment"><table width="99%" align="center" >
                        <tr>
                          <td height="22" bgcolor="#F2F2F2"><span class="style1"><a target="_blank" href="user_info.jsp?userName=<%=StrUtil.UrlEncode(cmt.getNick())%>"><%=cmt.getNick()%></a>&nbsp;发表于&nbsp;<%=cmt.getAddDate()%> </span></td>
                        </tr>
                        <tr>
                          <td><%=cmt.getContent()%></td>
                        </tr>
                    </table></td>
                  </tr>
              </table>
              <%	
}
%>
                <br>
                <%if (doc.isCanComment()) {%>
                <table width="44%" cellpadding="0" cellspacing="0" class="tableframe_gray" >
                  <tr>
                    <td><table width="100%" class="tableframe" >
                        <form name="form1" method="post" action="?op=addcomment">
                          <tr align="left" bgcolor="#CCCCCC">
                            <td height="24" colspan="3"><span class="style1">发表评论<a name="comment"></a></span></td>
                          </tr>
                          <tr>
                            <td height="24" colspan="2" align="left">姓&nbsp;名
                              <input type="text" name="nick" size="15" value="<%=privilege.getUser(request)%>" readonly="">
                                <input type="hidden" name="doc_id" value="<%=doc.getID()%>">
                                <input type="hidden" name="id" value="<%=doc.getID()%>">                            </td>
                            <td width="46%" align="left"> 
							<input name="link" type="hidden" value="<%=Global.AppName%>">							</td>
                          </tr>
                          <tr>
                            <td width="9%" align="center">内&nbsp;容 </td>
                            <td colspan="2" align="left"><textarea name="content" cols="45" rows="8"></textarea></td>
                          </tr>
                          <tr>
                            <td colspan="3" align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
                              &nbsp;&nbsp;&nbsp;&nbsp;
                              <input name="Submit" type="reset" class="singleboarder" value="重置"></td>
                          </tr>
                        </form>
                    </table></td>
                  </tr>
                </table>
              <%}%>
                <%}%>            </td>
          </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
