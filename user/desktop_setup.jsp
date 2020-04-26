<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.module.cms.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.person.*" %>
<%@ page import="com.redmoon.oa.ui.*" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<LINK href="../common.css" type=text/css rel=stylesheet>
<title>用户桌面设置</title>
<script language=javascript>
<!--

//-->
</script>
<style type="text/css">
<!--
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body style="background-image:url()">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	String userName = privilege.getUser(request);
	String moduleCode = ParamUtil.get(request, "moduleCode");
	String moduleItem = ParamUtil.get(request, "moduleItem");
	String title = ParamUtil.get(request, "title");
	UserDesktopSetupDb udsd = new UserDesktopSetupDb();
	udsd.setTitle(title);
	udsd.setUserName(userName);
	udsd.setModuleCode(moduleCode);
	udsd.setModuleItem(moduleItem);
	boolean re = udsd.create();
	if (re) {
		out.print(StrUtil.Alert_Redirect("操作成功！", "desktop_setup.jsp"));
		return;
	}
	else {
		out.print(StrUtil.Alert_Back("操作失败！"));
	}
}

if (op.equals("edit")) {
	int id = ParamUtil.getInt(request, "id");
	String title = ParamUtil.get(request, "title");
	int count = ParamUtil.getInt(request, "count");
	UserDesktopSetupDb udsd = new UserDesktopSetupDb();
	udsd = udsd.getUserDesktopSetupDb(id);
	udsd.setTitle(title);
	udsd.setCount(count);
	boolean re = udsd.save();
	if (re) {
		out.print(StrUtil.Alert_Redirect("操作成功！", "desktop_setup.jsp"));
		return;
	}
	else {
		out.print(StrUtil.Alert_Back("操作失败！"));
	}
}

if (op.equals("del")) {
	int id = ParamUtil.getInt(request, "id");
	UserDesktopSetupDb udsd = new UserDesktopSetupDb();
	udsd = udsd.getUserDesktopSetupDb(id);
	boolean re = udsd.del();
	if (re) {
		out.print(StrUtil.Alert_Redirect("操作成功！", "desktop_setup.jsp"));
		return;
	}
	else {
		out.print(StrUtil.Alert_Back("操作失败！"));
	}
}

if (op.equals("copy")) {
	if (!privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {
		out.print(StrUtil.Alert_Back("非法操作！"));
		return;
	}
	else {
		int id = ParamUtil.getInt(request, "id");
		UserDesktopSetupDb udsd = new UserDesktopSetupDb();
		udsd = udsd.getUserDesktopSetupDb(id);
		udsd.copyToAllOtherUsersDesktop(privilege.getUser(request));
		out.print(StrUtil.Alert_Redirect("操作完成！", "desktop_setup.jsp"));
	}
}

if (op.equals("init")) {
	UserDesktopSetupDb udsd = new UserDesktopSetupDb();
	String userName = privilege.getUser(request);

	udsd.initDesktopOfUser(userName);
	out.print(StrUtil.Alert("操作成功！"));
}
%>
<%@ include file="user_inc_menu_top.jsp" %>
<%
String userName = privilege.getUser(request);
UserDesktopSetupDb udsd = new UserDesktopSetupDb();
String sql = "select id from " + udsd.getTableName() + " where user_name=" + StrUtil.sqlstr(userName);
Vector v = udsd.list(sql);
Iterator ir = v.iterator();
DesktopMgr dm = new DesktopMgr();
%>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;<a href="?op=init">恢复默认界面</a><br>
<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#7E7DA2">
<tr>
  <td bgcolor="#C4DAFF"><strong>模块</strong></td>
  <td bgcolor="#C4DAFF"><strong>属性</strong></td>
  <td bgcolor="#C4DAFF"><strong>操作</strong></td>
</tr>
<%
int k = 0;
while (ir.hasNext()) {
	k ++;
	udsd = (UserDesktopSetupDb) ir.next();
	DesktopUnit du = dm.getDesktopUnit(udsd.getModuleCode());
%>
<form name="form<%=k%>" action="?op=edit" method=post>
<tr><td width="29%" bgcolor="#E6E6E6">
	标题
<input name="title" value="<%=udsd.getTitle()%>">
	<input name="id" value="<%=udsd.getId()%>" type="hidden">
</td>
  <td width="48%" bgcolor="#E6E6E6">
  <%if (du.getType().equals(du.TYPE_LIST)) {%>
  行数&nbsp;<input name=count value="<%=udsd.getCount()%>">
  <%}else{%>
  字数&nbsp;<input name=count value="<%=udsd.getCount()%>">
  <%}%>  
  参数：<%=udsd.getModuleItem()%>
  </td>
  <td width="23%" bgcolor="#E6E6E6"><input type="submit" value="修改"/>
  <input value="删除" type="button" onClick="window.location.href='?op=del&id=<%=udsd.getId()%>'">
  <%if (privilege.isUserPrivValid(request, PrivDb.PRIV_ADMIN)) {%>
  <input name="button" type="button" onClick="window.location.href='?op=copy&id=<%=udsd.getId()%>'" title="复制至其它用户桌面" value="复制">
  <%}%>
  </td>
</tr></form>
<%}%>
</table>
	<br>
	<table width="761" border="0" align="center">
      <tr>
        <td width="249" valign="top"><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">公共通知</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="公共通知">
                <input type=hidden name="moduleCode" value="fileark">
                <input type=hidden name="moduleItem" value="notice"></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td width="249" valign="top"><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">文件柜目录</span></td>
            </tr>
            <tr>
              <td width="41" align="left" bgcolor="#F0F0F0">&nbsp;标题 </td>
              <td width="198" align="left" bgcolor="#F0F0F0"><input name="title" value="文件柜目录">
                  <input type=hidden name="moduleCode" value="fileark">
              </td>
            </tr>
            <tr>
              <td align="left" bgcolor="#F0F0F0">&nbsp;类别</td>
              <td align="left" bgcolor="#F0F0F0"><select name="moduleItem" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' 不能被选择！');return false;}">
                  <option value="not" selected>请选择类别</option>
                  <%
					Directory dir = new Directory();
					Leaf lf = dir.getLeaf("root");
					DirectoryView dv = new DirectoryView(lf);
					dv.ShowDirectoryAsOptions(out, lf, lf.getLayer());
					%>
              </select></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit2" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td width="249" valign="top"><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">日程安排</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="日程安排">
                  <input type=hidden name="moduleCode" value="plan">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit3" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
      </tr>
      <tr>
        <td><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">待办工作流</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="待办工作流">
                  <input type=hidden name="moduleCode" value="flow">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit4" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">任务督办</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="任务督办">
                  <input type=hidden name="moduleCode" value="task">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit42" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">短消息</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="短消息">
                  <input type=hidden name="moduleCode" value="msg">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit422" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
      </tr>
      <tr>
        <td valign="top"><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">论坛新贴</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="论坛新贴">
                  <input type=hidden name="moduleCode" value="forum">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit43" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td valign="top"><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">博客新贴</span></td>
            </tr>
            <tr>
              <td width="45" align="left" bgcolor="#F0F0F0">&nbsp;标题</td>
              <td width="194" align="left" bgcolor="#F0F0F0"><input name="title" value="博客新贴">
                  <input type=hidden name="moduleCode" value="blog">
                  <input type=hidden name="moduleItem" value=""></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit432" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
        <td><table width="249" border="0" align="center" cellspacing="1" bgcolor="#D9DCE1" class="frame_gray">
          <form name="formDoc" action="?op=add" method="post">
            <tr>
              <td colspan="2" align="center" bgcolor="#5286BD"><span class="STYLE1">文件柜中的文件</span></td>
            </tr>
            <tr>
              <td width="41" align="left" bgcolor="#F0F0F0">&nbsp;标题 </td>
              <td width="198" align="left" bgcolor="#F0F0F0"><input name="title" value="文章">
                  <input type=hidden name="moduleCode" value="document">
              </td>
            </tr>
            <tr>
              <td align="left" bgcolor="#F0F0F0">&nbsp;编号</td>
              <td align="left" bgcolor="#F0F0F0"><input name="moduleItem" value="" readonly size=8>
                &nbsp;&nbsp;<a href="javascript:showModalDialog('../cms/doc_template_select_frame.jsp?dirCode=root',window.self,'dialogWidth:640px;dialogHeight:480px;status:no;help:no;')">选文章</a></td>
            </tr>
            <tr>
              <td colspan="3" align="center" bgcolor="#F0F0F0"><input name="submit22" type=submit value="添加"/>
                &nbsp;&nbsp;&nbsp;</td>
            </tr>
          </form>
        </table></td>
      </tr>
    </table>
<br>
<br>
</body>
<script>
function selTemplate(id)
{
	formDoc.moduleItem.value = id;
}
</script>
</html>
