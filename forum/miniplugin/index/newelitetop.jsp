<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.miniplugin.index.*"%>
<table width="98%" border="1" align="center" cellpadding="4" cellspacing="0" borderColor="<%=skin.getTableBorderClr()%>">
    <TBODY>
      <tr> 
      <td width="33%" align="center" class="td_title">最新贴子</td>
      <td width="33%" align="center" class="td_title">最新精华</td>
      <td width="34%" align="center" class="td_title">最新固顶</td>
      </tr>
    </TBODY>
    <TBODY>
      <tr>
        <td>
		<%
		int n = 5;
		NewEliteTop net = new NewEliteTop();
		Iterator newir = net.listNewMsg(5).iterator();
		while (newir.hasNext()) {
			MsgDb msg = (MsgDb)newir.next();
		%>
			<table width="100%" border="0" cellspacing="0">
		  <tr><td><a href="showtopic.jsp?rootid=<%=msg.getId()%>"><%=StrUtil.getLeft(msg.getTitle(), 20)%></a></td>
		  </tr></table>
		<%}
		%>
		</td>
        <td><%
		n = 5;
		newir = net.listEliteMsg(5).iterator();
		while (newir.hasNext()) {
			MsgDb msg = (MsgDb)newir.next();
		%>
          <table width="100%" border="0" cellspacing="0">
            <tr>
              <td><a href="showtopic.jsp?rootid=<%=msg.getId()%>"><%=StrUtil.getLeft(msg.getTitle(), 20)%></a></td>
            </tr>
          </table>
        <%}
		%></td>
        <td><%
		n = 5;
		newir = net.listTopMsg(5).iterator();
		while (newir.hasNext()) {
			MsgDb msg = (MsgDb)newir.next();
		%>
          <table width="100%" border="0" cellspacing="0">
            <tr>
              <td><a href="showtopic.jsp?rootid=<%=msg.getId()%>"><%=StrUtil.getLeft(msg.getTitle(), 20)%></a></td>
            </tr>
          </table>
        <%}
		%></td>
      </tr>
    </TBODY>
</table>
