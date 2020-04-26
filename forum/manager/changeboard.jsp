<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="org.jdom.*"%>
<%@ page import="org.jdom.output.*"%>
<%@ page import="org.jdom.input.*"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="com.redmoon.forum.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE><lt:Label res="res.label.forum.manager" key="move_board"/></TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<%@ include file="../inc/nocache.jsp"%>
<link href="../<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<STYLE>
TABLE {
	BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px
}
TD {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px
}
.style1 {color: #FFFFFF}
body {
	margin-left: 0px;
	margin-right: 0px;
}
</STYLE>
<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY topMargin=0>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/inc.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="topic" scope="page" class="com.redmoon.forum.MsgMgr" />
<%
	String querystring = StrUtil.getNullString(request.getQueryString());
	String privurl=request.getRequestURL()+"?"+StrUtil.UrlEncode(querystring,"utf-8");
	
	String op = ParamUtil.get(request, "op");
	long id = ParamUtil.getLong(request, "id");
	String boardcode = ParamUtil.get(request, "boardcode");
	String oldboardcode = ParamUtil.get(request, "oldboardcode");

	//安全验证
	if (!privilege.isUserLogin(request)) {
		response.sendRedirect("../index.jsp");
		return;
	}
	
	if (op.equals("change")) {
		boolean re = false;
		try {
			re = topic.ChangeBoard(request,id,boardcode);
			if (re) {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_success")));
			}
			else {
				out.println(StrUtil.Alert(SkinUtil.LoadString(request,"info_operate_fail")));
				boardcode = oldboardcode;
			}
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.p_center(e.getMessage(),"red"));
			boardcode = oldboardcode;
		}
	}
%>	  
  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="9black">
    <tr> 
      <td height="153" align="center" valign="middle"> 
        <div align="">
		<form name="form1" method="post" action="?op=change">
        <br>
        <lt:Label res="res.label.forum.manager" key="move_to"/>
              <select name="boardcode" onChange="if(this.options[this.selectedIndex].value==''){alert('<lt:Label res="res.label.forum.manager" key="you_selected_board_not"/>'); this.selectedIndex=oldIndex}">
                <option value="" selected><lt:Label res="res.label.forum.manager" key="select_board"/></option>
                <%
LeafChildrenCacheMgr dlcm = new LeafChildrenCacheMgr("root");
java.util.Vector vt = dlcm.getChildren();
Iterator ir = vt.iterator();
int oldIndex = 0;
while (ir.hasNext()) {
	Leaf leaf = (Leaf) ir.next();
	String parentCode = leaf.getCode();
%>
                <option style="BACKGROUND-COLOR: #f8f8f8" value="">╋ <%=leaf.getName()%></option>
                <%
	LeafChildrenCacheMgr dl = new LeafChildrenCacheMgr(parentCode);
	java.util.Vector v = dl.getChildren();
	Iterator ir1 = v.iterator();
	int i = 0;
	String selected = "";
	while (ir1.hasNext()) {
		Leaf lf = (Leaf) ir1.next();
		if (boardcode.equals(lf.getCode()))	{
			selected = "selected";
			oldIndex = i;
		}
		else
			selected = "";
		i++;
%>
        <option value="<%=lf.getCode()%>" <%=selected%>>　├『<%=lf.getName()%>』</option>
                <%}
}%>
              </select>
			  <script>
			  var oldIndex = <%=oldIndex%>;
			  </script>
              <input type="submit" name="Submit2" value="<%=SkinUtil.LoadString(request,"ok")%>">
			  <input type=hidden name=id value="<%=id%>">
			  <input type=hidden name=oldboardcode value="<%=boardcode%>">
          </form>
      </div>                
		</td>
    </tr>
</table>
<%@ include file="../inc/footer.jsp"%>
</BODY></HTML>
