<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.pvg.*"%>
<%@ page import="com.redmoon.oa.meeting.*"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.redmoon.oa.flow.*"%>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<jsp:useBean id="strutil" scope="page" class="cn.js.fan.util.StrUtil"/>
<title>会议室使用情况</title>
<script language=JavaScript src='../scripts/formpost.js'></script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<TABLE width="98%" BORDER=0 align="center" CELLPADDING=0 CELLSPACING=0 class="tableframe">
  <TR valign="top" bgcolor="#FFFFFF">
    <TD width="" height="430" colspan="2" style="background-attachment: fixed; background-image: url(../images/bg_bottom.jpg); background-repeat: no-repeat">
          <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
              <TR>
                <TD class=right-title>&nbsp;会议室使用情况</TD>
              </TR>
            </TBODY>
          </TABLE>
          <table border="0" cellspacing="1" width="100%" cellpadding="2" align="center">
            <tr align="center" bgcolor="#F2F2F2">
              <td width="15%" height="20" align=center>申请人</td>
              <td width="39%" align=center>议题</td>
              <td width="16%" align=center>开始时间</td>
              <td width="16%" align=center>结束时间</td>
              <td width="14%" align=center>操作</td>
            </tr>
        </table>
		<table width="100%"  border="0">
          <tr>
			<td>
			<%
			String boardroomId = ParamUtil.get(request, "boardroomId");
			String querystr = "";
			String sql = BoardroomSQLBuilder.getBoardroomSearchSql(boardroomId);
			querystr += "boardroomId=" + boardroomId;
			
			int pagesize = 10;
			Paginator paginator = new Paginator(request);
			int curpage = paginator.getCurPage();
				
			BoardroomApplyDb bad = new BoardroomApplyDb();		
			ListResult lr = bad.listResult(sql, curpage, pagesize);
			int total = lr.getTotal();
			Vector v = lr.getResult();
			Iterator ir = null;
			
			if (v!=null)
				ir = v.iterator();
				
			paginator.init(total, pagesize);
			// 设置当前页数和总页数
			int totalpages = paginator.getTotalPages();
			if (totalpages==0)
			{
				curpage = 1;
				totalpages = 1;
			}
			
			int i = 0;
			while (ir!=null && ir.hasNext()) {
				bad = (BoardroomApplyDb)ir.next();	
			%>
			<table border="0" cellspacing="1" width="100%" cellpadding="2" align="center">
              <tr align="center">
                <td width="15%" height="20" align=center><%=bad.getSqren()%></td>
                <td width="39%" align=center><%=bad.getMeetingTitle()%></td>
                <td width="16%" align=center><%=DateUtil.format(bad.getStart_date(), "yyyy-MM-dd HH:mm")%></td>
                <td width="16%" align=center><%=DateUtil.format(bad.getEnd_date(), "yyyy-MM-dd HH:mm")%></td>
                <td width="14%" align=center><a href="boardroom_apply_show.jsp?flowId=<%=bad.getFlowId()%>">详细信息</a></td>
              </tr>
            </table>
			<%
			}
			%>
			<table width="98%" border="0" class="p9">
              <tr>
                <td align="right">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%
				out.print(paginator.getCurPageBlock("listtopic.jsp?"+querystr));
				%>
                  &nbsp;&nbsp;
                </b></td>
              </tr>
            </table></td>
          </tr>
        </table>
	</TD>
  </TR>
</TABLE>
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
</script>
</html>