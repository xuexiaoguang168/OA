<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.meeting.*"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会议管理</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<style type="text/css">
<!--
.STYLE2 {color: #0033FF}
.STYLE3 {color: #FF0000}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<%@ include file="boardroom_inc_apply_top.jsp"%>
<br>
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="main">
  <tr> 
    <td width="840" height="23" valign="middle" class="right-title"><span>&nbsp;会议管理</span></td>
  </tr>
  <tr> 
    <td valign="top" background="images/tab-b-back.gif">
<%
		String sql = "";
		String result = ParamUtil.get(request, "result");
		String querystr = "";	
		String beginDate = "";
		String endDate = "";

		
		if (result.equals(BoardroomSQLBuilder.RESULT_APPLY)) {
		    sql = BoardroomSQLBuilder.getBoardroomApplySearchSql();
		}else{
		   	if (result.equals(BoardroomSQLBuilder.RESULT_USED)) {
		        sql = BoardroomSQLBuilder.getBoardroomUsedSearchSql();
		    }else{
			   	if (result.equals(BoardroomSQLBuilder.RESULT_DISAGREE)) {
		           sql = BoardroomSQLBuilder.getBoardroomDisagreeSearchSql();
		        }else{
				   if (result.equals(BoardroomSQLBuilder.RESULT_AGREE)) {
		              sql = BoardroomSQLBuilder.getBoardroomAgreeSearchSql();
		           }else{
	                  sql = BoardroomSQLBuilder.getBoardroomEndSearchSql();	   
		           } 
		        } 
			}   
		}
		querystr += "result=" + result;
		
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
%>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td width="47">&nbsp;</td>
          <td align="right" backgroun="images/title1-back.gif">找到符合条件的记录 <b><%=paginator.getTotal() %></b> 条　每页显示 <b><%=paginator.getPageSize() %></b> 条　页次 <b><%=curpage %>/<%=totalpages %></td>
        </tr>
      </table> 
      <form name="form1" action="vehicle_maintenance_add.jsp" method="post">
	    <table width="97%" border="0" align="center" cellpadding="2" cellspacing="0" >
          <tr align="center" bgcolor="#C4DAFF">
            <td width="19%" height="24" >会议名称</td>
            <td width="15%" bgcolor="#C4DAFF" >申请人</td>
            <td width="16%" bgcolor="#C4DAFF" >会议室</td>
            <td width="14%" >开始时间</td>
            <td width="12%" >结束时间</td>
            <td width="24%" >操作</td>
          </tr>
        </table>
	    <%	
	  	int i = 0;
		while (ir!=null && ir.hasNext()) {
			bad = (BoardroomApplyDb)ir.next();	
			if(bad.getStart_date() == null){
			  beginDate = "";
			}else{
			  beginDate = DateUtil.format(bad.getStart_date(), "yy-MM-dd HH:mm");
			}	
			if(bad.getEnd_date() == null){
			  endDate = "";
			}else{
			  endDate = DateUtil.format(bad.getEnd_date(), "yy-MM-dd HH:mm");
			}	
		%>
      <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#B6CFC5" bgcolor="#FFFFFF">
        <tr align="center" >
          <td width="19%" height="22"><%=bad.getMeetingTitle()%></td> 
          <td width="15%"><%=bad.getSqren()%></td>
		  <td width="16%">
		  <%
		  String mroom = bad.getHyshi();
		  if (mroom.equals(""))
		  	mroom = "尚未选定会议室！";
		  else {
			  BoardroomDb bd = new BoardroomDb();
			  bd = bd.getBoardroomDb(Integer.parseInt(mroom));
		  	  mroom = bd.getName();
		  }
		  %>
		  <%=mroom%>
		  </td>
		  <td width="14%"><%=beginDate%></td>
		  <td width="12%"><%=endDate%></td>
		  <td><a href="boardroom_apply_show.jsp?flowId=<%=bad.getFlowId()%>">详细信息</a></td>
		  </tr>
      </table>
      <%}%>	  
	  </form>
      <table width="98%" border="0" cellspacing="1" cellpadding="3" align="center">
        <tr> 
          <td width="1%" height="23">&nbsp;</td>
          <td height="23" valign="baseline"> 
            <div align="right">
             <%
			   out.print(paginator.getCurPageBlock("?"+querystr));
			 %>
            &nbsp;</div></td>
        </tr>
      </table>    </td>
  </tr>
</table>

</body>
</html>
