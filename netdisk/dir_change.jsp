<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="com.redmoon.oa.netdisk.*" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>转移</title>
<LINK href="../admin/default.css" type=text/css rel=stylesheet>
<script>

</script>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="docmanager" scope="page" class="com.redmoon.oa.netdisk.DocumentMgr"/>
<%
if (!privilege.isUserLogin(request))
{
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
int attachId = ParamUtil.getInt(request, "attachId");
Attachment att = new Attachment();
att = att.getAttachment(attachId);

LeafPriv lp = new LeafPriv(att.getDirCode());
if (!lp.canUserModify(privilege.getUser(request))) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}


int docId = att.getDocId();
Document doc = new Document();
doc = doc.getDocument(docId);
Leaf leaf = new Leaf();
leaf = leaf.getLeaf(doc.getDirCode());
// 只有本人才可以改父目录
if (!leaf.getRootCode().equals(privilege.getUser(request))) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("change")) {
	String newDirCode = ParamUtil.get(request, "newDirCode");
	if (!newDirCode.equals("")) {
		doc.changeAttachmentToDir(att, newDirCode);
		out.print(StrUtil.Alert_Redirect("修改成功！", "dir_list.jsp?op=editarticle&dir_code=" + StrUtil.UrlEncode(newDirCode)));
		return;
	}
}

if (op.equals("changeattachname")) {
	boolean re = false;
	try {
		String newname = ParamUtil.get(request, "newname").trim();
		if (newname.equals("")) {
			throw new ErrMsgException("文件名不能为空！");
		}	
		re = docmanager.updateAttachmentName(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert_Back(e.getMessage()));
	}
	if (re) {
		out.print(StrUtil.Alert_Back("修改成功！"));
	}
}
%>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">将<%=att.getName()%>转移至目录</TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="335" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="411" align="center"><table width="98%">
            <form name="form1" method="post" action="?op=change">
               <tr>
                <td width="243" align="center"><span class="unnamed2">
                  <select name="newDirCode">
							<%
								Leaf rootlf = leaf.getLeaf(privilege.getUser(request));
								DirectoryView dv = new DirectoryView(rootlf);
								dv.ShowDirectoryAsOptionsWithCode(out, rootlf, rootlf.getLayer());
							%>
					  </select>
							<script>
								form1.newDirCode.value = "<%=leaf.getCode()%>";
							</script>
                </span></td>
              </tr>
              <tr>
                <td align="left"></td>
              </tr>
              <tr>
                <td align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <input name="Submit" type="reset" class="singleboarder" value="重置"> 
				  <input name="attachId" value="<%=attachId%>" type=hidden>				  </tr>
            </form>
          </table></td>
        </tr>
      </table>
      </TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%"><%=att.getName()%> 重命名 </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="335" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="411" align="center"><table width="98%">
            <form name="form2" method="post" action="?op=changeattachname">
              <tr>
                <td width="243" align="center">
				请输入新名称
				  <input name="newname" value="<%=att.getName()%>">
				</td>
              </tr>
              <tr>
                <td align="left"></td>
              </tr>
              <tr>
                <td align="center"><input name="Submit2" type="submit" class="singleboarder" value="提交">
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  <input name="Submit2" type="reset" class="singleboarder" value="重置">
                  <input name="attachId" value="<%=attachId%>" type=hidden>
                  <input name="attach_id" value="<%=attachId%>" type=hidden>
                  <input name="doc_id" value="<%=docId%>" type=hidden>
                  <input name="page_num" value="1" type=hidden>
                </tr>
            </form>
          </table></td>
        </tr>
      </table></TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
</body>
</html>
