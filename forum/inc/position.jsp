<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="com.redmoon.forum.plugin.*"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="com.redmoon.forum.ui.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="ltpos" %>
<%
String pos_boardcode = ParamUtil.get(request, "boardcode");
if (!pos_boardcode.equals("")) {
	Leaf pos_curleaf = new Leaf();
	pos_curleaf = pos_curleaf.getLeaf(pos_boardcode);
	String pos_op = ParamUtil.get(request, "op");
%>
<table width='98%' height='25' border='0' class="tableframe_gray" align="center" cellpadding='0' cellspacing='0' rules='rows'>
<tbody><tr><td align='left' bgcolor="#EBECED">
		&nbsp;<img src="<%=request.getContextPath()%>/forum/images/userinfo.gif" width="9" height="9">
		<span id="pos_root" name="pos_root" style="display:none"><%=pos_curleaf.getMenuString(request, pos_curleaf.getLeaf(Leaf.CODE_ROOT))%></span>
		<a><ltpos:Label res="res.label.forum.inc.position" key="cur_position"/></a>&nbsp;<a href="<%=request.getContextPath()%>/forum/index.jsp" onmouseover='showmenu(event, pos_root.innerHTML, 0)'>
		<ltpos:Label res="res.label.forum.inc.position" key="forum_home"/></a>&nbsp;<B>&raquo;</B> 
            <%
		  	String pCode = pos_curleaf.getParentCode();
			String plink = "";
		  	while (!pCode.equals(Leaf.CODE_ROOT)) { 
				Leaf pleaf = pos_curleaf.getLeaf(pCode);
				// 防止当parentCode出错时，陷入死循环
				if (pleaf==null || !pleaf.isLoaded())
					break;
			%>
				<span id="posspan_<%=pleaf.getCode()%>" name="posspan_<%=pleaf.getCode()%>" style="display:none"><%=pos_curleaf.getMenuString(request, pleaf)%></span>
			<%
				if (pleaf.getType()==pleaf.TYPE_BOARD) {
					plink = "&nbsp;<a href='" + ForumPage.getListTopicPage(request, pCode) + "' onmousemove='showmenu(event, posspan_" + pleaf.getCode() + ".innerHTML, 0)'>" + pleaf.getName() + "</a>&nbsp;<B>&raquo;</B>" + plink;
				}
				else {
					plink = "&nbsp;<a href='index.jsp?boardField=" + StrUtil.UrlEncode(pCode) + "' onmousemove='showmenu(event, posspan_" + pleaf.getCode() + ".innerHTML, 0)'>" + pleaf.getName() + "</a>&nbsp;<B>&raquo;</B>" + plink;
		  		}
		  		pCode = pleaf.getParentCode();
		   }
		  %>
		  <%=plink%>&nbsp;<a href="<%=ForumPage.getListTopicPage(request, pos_boardcode)%>">	  
		  <%	
				out.print(pos_curleaf.getName());
		  %>
		  </a>
		  <%if (pos_op.equals("showelite")) {%>
		  <ltpos:Label res="res.label.forum.inc.position" key="elite_field"/>
		  <%}%>		</td>
</tr></tbody>
</table>
<%
} else if (!com.redmoon.forum.Privilege.isUserLogin(request)) { 
	String posprivurl = request.getRequestURL() + "?" + request.getQueryString();
%>
<table width='98%' height='25' class="tableframe_gray" border='0' align="center" cellpadding='0' cellspacing='0' rules='rows'>
<form action="<%=cn.js.fan.web.Global.getRootPath()%>/login.jsp" method=post>
<tbody><tr><td align='left' bgcolor="#EBECED">
		&nbsp;<img src="<%=cn.js.fan.web.Global.getRootPath()%>/forum/images/userinfo.gif" width="9" height="9">&nbsp;<ltpos:Label res="res.label.forum.inc.position" key="user_name"/>
		<input maxlength=15 size=10 name="name">
		<ltpos:Label res="res.label.forum.inc.position" key="pwd"/>
		<input type=password maxlength=15 size=10 name="pwd">
		<%
        com.redmoon.forum.Config cfg_pos = new com.redmoon.forum.Config();
        if (cfg_pos.getBooleanProperty("forum.loginUseValidateCode")) {
		%>
		<ltpos:Label res="res.label.forum.inc.position" key="validate_code"/>
        <input name="validateCode" type="text" size="1">
        <img src='../validatecode.jsp' border="0" align="absmiddle" style="cursor:hand" onclick="this.src='../validatecode.jsp'" alt="<ltpos:Label res="res.label.forum.index" key="refresh_validatecode"/>" />
        <%}%>
		<select name=covered>
		  <option value=0 selected type='checkbox' checked><ltpos:Label res="res.label.forum.inc.position" key="not_cover"/></option>
		  <option value=1><ltpos:Label res="res.label.forum.inc.position" key="cover"/></option>
        </select>		<input type='submit' name='Submit' value='<ltpos:Label res="res.label.forum.inc.position" key="commit"/>' class=singleboarder>
		<input type="hidden" name="privurl" value="<%=posprivurl%>">
		</td>
</tr></tbody>
</form>
</table>
<%}else{
	UserDb user = new UserDb();
	user = user.getUser(com.redmoon.forum.Privilege.getUser(request));
%>
<table width='98%' height='25' border='0' class="tableframe_gray" align="center" cellpadding='0' cellspacing='0' rules='rows'>
<tbody><tr><td align='left' bgcolor="#EBECED">
		&nbsp;<img src="<%=cn.js.fan.web.Global.getRootPath()%>/forum/images/userinfo.gif" width="9" height="9">&nbsp;<ltpos:Label res="res.label.forum.inc.position" key="user_name"/>		<%=user.getNick()%>&nbsp;		&nbsp;<ltpos:Label res="res.label.forum.inc.position" key="welcome"/><%=user.getLevelDesc()%>&nbsp;&nbsp;<ltpos:Label res="res.label.forum.inc.position" key="exprience"/><%=user.getExperience()%>&nbsp;&nbsp;<ltpos:Label res="res.label.forum.inc.position" key="credit"/><%=user.getCredit()%>&nbsp;&nbsp;
		<%
						ScoreMgr sm_pos = new ScoreMgr();
						ScoreUnit su_pos = sm_pos.getScoreUnit("gold");
						out.print(su_pos.getName());
						%>：<%=user.getGold()%>		
		</td>
</tr></tbody>
</table>
<%}%>
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
<table width="98%"  border="0" align="center">
  <tr>
    <td height="10"></td>
  </tr>
</table>
