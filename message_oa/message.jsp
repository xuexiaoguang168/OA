<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="../inc/nocache.jsp"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.message.*"%>
<html>
<head>
<title>消息中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<LINK href="../common.css" type=text/css rel=stylesheet>
<script>
function selAllCheckBox(checkboxname){
	var checkboxboxs = document.all.item(checkboxname);
	if (checkboxboxs!=null)
	{
		// 如果只有一个元素
		if (checkboxboxs.length==null) {
			checkboxboxs.checked = true;
		}
		for (i=0; i<checkboxboxs.length; i++)
		{
			checkboxboxs[i].checked = true;
		}
	}
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request)) {
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String name = privilege.getUser(request);
%>
<table width="320" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#99CCFF" class="9black" height="260">
  <tr> 
    <td bgcolor="#CEE7FF" height="23">
      <div align="center"><b>消 息 中 心</b></div>
    </td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF" height="50"> 
        <table width="300" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr> 
            <td width="75"> 
              <div align="center"><img src="images/inboxpm.gif" width="40" height="40" border="0"></div>
            </td>
            <td width="75"> 
              <div align="center"><a href="listdraft.jsp"><img src="images/m_draftbox.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"><a href="send.jsp"><img src="images/newpm.gif" width="40" height="40" border="0"></a></div>
            </td>
            <td width="75"> 
              <div align="center"> 
                <img border="0" name="imageField" src="images/m_delete.gif" width="40" height="40" onClick="form1.submit()" style="cursor:hand">
              </div>
            </td>
          </tr>
        </table>
    </td>
  </tr>
  <tr> 
      <td bgcolor="#FFFFFF" height="152" valign="top">
		<table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%"  border="0">
  <form name="form1" method="post" action="delmsg.jsp">
              <tr>
                <td>
		<%
		MessageDb md = new MessageDb();
		
		String sql = "select id from oa_message where receiver="+StrUtil.sqlstr(name)+" and isDraft=0 order by isreaded asc,rq desc";
		int pagesize = 5;
		Paginator paginator = new Paginator(request);
		int curpage = paginator.getCurPage();

		int total = md.getObjectCount(sql);
		paginator.init(total, pagesize);
		//设置当前页数和总页数
		int totalpages = paginator.getTotalPages();
		if (totalpages==0)
		{
			curpage = 1;
			totalpages = 1;
		}

int id,type;
String title="",sender="",receiver="",rq="";
boolean isreaded = true;
int i = 0;
Iterator ir = md.list(sql, (curpage-1)*pagesize, curpage*pagesize-1).iterator();
while (ir.hasNext()) {
 	      md = (MessageDb)ir.next(); 
		  i++;
		  id = md.getId();
		  title = md.getTitle();
		  sender = md.getSender();
		  receiver = md.getReceiver();
		  rq = md.getRq();
		  type = md.getType();
		  isreaded = md.isReaded();
		 %>
                  <table width="310" border="0" cellspacing="1" cellpadding="3" align="center" class="p9">
                    <tr>
                      <td width="24" ><input type="checkbox" name="ids" value="<%=id%>">
                      </td>
                      <td width="210">&nbsp;<a href="showmsg.jsp?id=<%=id%>" class="9black2">
                        <%if (isreaded) {%>
                        <%=StrUtil.getLeft(title, 22)%>
                        <%}else{%>
                        <b><%=StrUtil.getLeft(title, 20)%></b>
                        <%}%>
                        </a> <font color="#666666"> [<%=sender%>]
                        <!-- <%=rq%>]-->
                      </font></td>
                      <td width="54" ><div align="center">
              <%
			    switch(type) {
			     case 0:
				  { out.print("个人消息");
				    break; }
				 case 1:
				  { out.print("公司消息");
				    break; }
				 case MessageDb.TYPE_SYSTEM:
				  { out.print("公共消息");
				    break; }
				 case 8:
				  { out.print("管 理 员");
                    break;}
				}
			  %>
                      </div></td>
                    </tr>
                  </table>
                  <%}%></td>
              </tr></form>
            </table>
            </td>
          </tr>
        </table>
<% if(paginator.getTotal()>0){ %>
        <table width="310" border="0" cellspacing="0" cellpadding="0" align="center" class="p9" height="24">
          <tr>
            <td height="24" valign="bottom"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20%">&nbsp;&nbsp;&nbsp;<a href="javascript:selAllCheckBox('ids')">全选</a></td>
    <td width="80%"><div align="right">共 <b><%=paginator.getTotal() %></b> 条　每页<b><%=paginator.getPageSize() %></b> 条　<b><%=curpage %>/<%=totalpages %></b> </div></td>
  </tr>
</table>
              <div align="right">
	  <%
	  String querystr = "";
 	  out.print(paginator.getCurPageBlock("message.jsp?"+querystr));
	  %>
	</div>
            </td>
          </tr>
        </table>
	<%}%>
      </td>
  </tr>
  <tr> 
    <td bgcolor="#CEE7FF" height="6"></td>
  </tr>
</table>
</body>
</html>
