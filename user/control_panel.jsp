<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.security.*"%>
<html>
<head>
<title>控制面板</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<%@ include file="../inc/nocache.jsp" %>
<script>
function New(para_URL){var URL=new String(para_URL);window.open(URL,'','resizable,scrollbars')}
function CheckRegName(){
	var Name=document.form.RegName.value;
	window.open("checkregname.jsp?RegName="+Name,"","width=200,height=20");
}

function check_checkbox(myitem,myvalue)
{
     var checkboxs = document.all.item(myitem);
	 
	 var myary = myvalue.split("|");
	 
     if (checkboxs!=null)
     {
       for (i=0; i<checkboxs.length; i++)
          {
            if (checkboxs[i].type=="checkbox" )
              {
				for (k=0; k<myary.length; k++) {
				 if (checkboxs[i].value==myary[k])
	                 checkboxs[i].checked = true
				}
              }
          }
     }
}

</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="3">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%@ include file="user_inc_menu_top.jsp" %>
<div id="newdiv" name="newdiv">
<%
String username = privilege.getUser(request);
if (!SecurityUtil.isValidSqlParam(username)) {
	out.print(StrUtil.Alert("参数非法！"));
	return;
}
UserMgr um = new UserMgr();
UserDb user = um.getUserDb(username);
if (user==null || !user.isLoaded()) {
	out.print(StrUtil.Alert_Back("该用户已不存在！"));
	return;
}

UserSetupDb usd = new UserSetupDb();
usd = usd.getUserSetupDb(username);

String op = ParamUtil.get(request, "op");
if (op.equals("edit")) {
	int isMsgWinPopup = ParamUtil.getInt(request, "isMsgWinPopup");
	int isChatIconShow = ParamUtil.getInt(request, "isChatIconShow");
	int isChatSoundPlay = ParamUtil.getInt(request, "isChatSoundPlay");
	usd.setMsgWinPopup(isMsgWinPopup==1);
	usd.setChatIconShow(isChatIconShow==1);
	usd.setChatSoundPlay(isChatSoundPlay==1);
	usd.save();
}
%>
<br>
<table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor="#CCCCCC">
  <tr>
    <td align=center bgcolor="#FFFFFF"><table border=0 cellpadding=0 cellspacing=0 width=100%>
      <tr>
        <td height=24 class="right-title">&nbsp;控制面板</td>
      </tr>
    </table>
        <table width=100% border=0 cellpadding=2 cellspacing=0>
		<form name="form1" action="?op=edit" method="post">
          <tr>
            <td width="104" align=left class="stable">我的职级：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td width="366" class="stable"><%
			com.redmoon.oa.basic.RankDb rd = new com.redmoon.oa.basic.RankDb();
			rd = rd.getRankDb(user.getRankCode());
			out.print(StrUtil.getNullString(rd.getName()));
			%>
            &nbsp;&nbsp;&nbsp;</td>
            <td width="447" class="stable"><a href="user_edit.jsp">修改个人信息</a></td>
          </tr>
          <tr class="stable">
            <td height="22" align=left valign="top" class="stable">我的角色：</td>
            <td height="22" align=left valign="top" class="stable"><%
com.redmoon.oa.pvg.RoleDb[] rld = user.getRoles();
int rolelen = 0;
if (rd!=null)
	rolelen = rld.length;
for (int k=0; k<rolelen; k++) {
	out.print(rld[k].getDesc() + "&nbsp;&nbsp;");
}
%>
            &nbsp;</td>
            <td height="22" align=left valign="top" class="stable">消息到来时是否弹出窗口：
			<select name="isMsgWinPopup">
			<option value="1" selected>是</option>
			<option value="0">否</option>
			</select>
			<script>
			form1.isMsgWinPopup.value = "<%=usd.isMsgWinPopup()?1:0%>";
			</script>			</td>
          </tr>
          <tr class="stable">
            <td height="22" align=left valign="top" class="stable">磁盘空间： </td>
            <td height="22" align=left valign="top" class="stable"><%=user.getDiskSpaceAllowed()%>字节&nbsp;&nbsp;已用<%=user.getDiskSpaceUsed()%>字节</td>
            <td height="22" align=left valign="top" class="stable">讨论信息到来时是否闪动图标：
              <select name="isChatIconShow">
                <option value="1" selected>是</option>
                <option value="0">否</option>
              </select>
			<script>
			form1.isChatIconShow.value = "<%=usd.isChatIconShow()?1:0%>";
			</script>			  </td>
          </tr>
          <tr class="stable">
            <td height="22" align=left valign="top" class="stable">论坛用户中心：</td>
            <td height="22" align=left valign="top" class="stable"><a href="../jump.jsp?fromWhere=oa&toWhere=forum&action=usercenter" target="_blank">进入</a></td>
            <td height="22" align=left valign="top" class="stable">讨论信息到来时是否声音提示：
              <select name="isChatSoundPlay">
                <option value="1" selected>是</option>
                <option value="0">否</option>
              </select>
			<script>
			form1.isChatSoundPlay.value = "<%=usd.isChatSoundPlay()?1:0%>";
			</script>		    </td>
          </tr>
          <tr class="stable">
            <td height="22" colspan="3" align=left valign="top" class="stable"><a href="desktop_setup.jsp">定制桌面</a></td>
          </tr>
          <tr class="stable">
            <td height="22" colspan="3" align=center valign="top" class="stable"><input type="submit" name="Submit" value=" 确 定 "></td>
          </tr>
		  </form>
      </table></td>
  </tr>
</table>
</body>
<SCRIPT>
function memberform_onsubmit()
{
	if (memberform.RealName.value=="") {
		alert("请输入用户姓名");
		return false;
	}
	if (memberform.Password.value != memberform.Password2.value)
	{
		alert("两遍输入的口令不一致");
		memberform.Password.focus();
		return false;
	}
	return true;
}
</SCRIPT>
</html>