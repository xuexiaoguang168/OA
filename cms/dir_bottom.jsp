<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.module.cms.*" %>
<%@ page import="cn.js.fan.module.cms.plugin.*" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<LINK href="default.css" type=text/css rel=stylesheet>
<script>
function form1_onsubmit() {
	form1.type.value = form1.seltype.value;
	form1.root_code.value = window.parent.dirmainFrame.getRootCode();
}

function selTemplate(id)
{
	if (form1.templateId.value!=id) {
		form1.templateId.value = id;
	}
}

function enableSelType() {
	if (confirm("如果该项中已经含有内容，则更改以后会造成问题，您要强制更改吗？")) {
		form1.seltype.disabled = false;
	}
}
</script>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserLogin(request))
{
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%
String parent_code = ParamUtil.get(request, "parent_code");
if (parent_code.equals(""))
	parent_code = "root";
String parent_name = ParamUtil.get(request, "parent_name");
String code = ParamUtil.get(request, "code");
String name = ParamUtil.get(request, "name");
String description = ParamUtil.get(request, "description");
String op = ParamUtil.get(request, "op");
boolean isHome = false;
int type = 0;
if (op.equals(""))
	op = "AddChild";
if (op.equals("AddChild")) {
	LeafPriv lp = new LeafPriv();
	lp.setDirCode(parent_code);
	if (!lp.canUserAppend(privilege.getUser(request))) {
		// out.println(StrUtil.makeErrMsg(privilege.MSG_INVALID, "red", "green"));
		// return;
	}
}

Leaf leaf = null;
if (op.equals("modify")) {
	LeafPriv lp = new LeafPriv(code);
	if (!lp.canUserModify(privilege.getUser(request))) {
		// out.print(StrUtil.makeErrMsg(privilege.MSG_INVALID));
		// return;
	}

	Directory dir = new Directory();
	leaf = dir.getLeaf(code);
	name = leaf.getName();
	description = leaf.getDescription();
	type = leaf.getType();
	isHome = leaf.getIsHome();
}
%>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">目录增加或修改</TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="469" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td align="center"><table width="100%">
            <form name="form1" method="post" action="dir_top.jsp?op=<%=op%>" target="dirmainFrame" onClick="return form1_onsubmit()">
              <tr>
                <td width="78" rowspan="7" align="left" valign="top"><br>
                  当前结点：<br>
                    <font color=blue><%=parent_name.equals("")?"根结点":parent_name%></font>
					</td>
                <td width="312" align="left"> 编码
                    <input name="code" value="<%=code%>" <%=op.equals("modify")?"readonly":""%>>
&nbsp;
<select name="target">
<option value="">默认</option>
<option value="mainFileFrame">文件柜右侧</option>
<option value="_parent">父窗口</option>
<option value="_top">顶层窗口</option>
<option value="_blank">新窗口</option>
<option value="_self">本窗口</option>
</select>
<%if (op.equals("modify")) {%>
<script>
form1.target.value = "<%=leaf.getTarget()%>";
</script>
<%}%>
               </td>
              </tr>
              <tr>
                <td align="left">名称
                    <input name="name" value="<%=name%>"></td>
              </tr>
              <tr>
                <td align="left">描述
                    <input name="description" value="<%=description%>">
                    <input type=hidden name=parent_code value="<%=parent_code%>"> 
                    (链接型节点在描述中填链接地址)                    </td>
              </tr>
              <tr>
                <td align="left">
				<%
				String disabled = "";
				if (op.equals("modify") && leaf.getType()>=1)
					disabled = "true";
				%>
				类型：
                  <select name="seltype">
                    <option value="0">分类</option>
                    <option value="1">文章</option>
                    <option value="2" <%=op.equals("AddChild")?"selected":""%>>列表</option>
					<option value="3">链接</option>
                  </select>
				  <script>
				  <%if (op.equals("modify")) {%>
					  form1.seltype.value = "<%=type%>"
				  <%}%>
				  form1.seltype.disabled = "<%=disabled%>"
				  </script>
				  <input type=hidden name=root_code value="">
				  <input type=hidden name="type" value="<%=type%>">
                  <span class="unnamed2">模板ID&nbsp;
                  <input name="templateId" class="singleboarder" value="<%=op.equals("modify")?""+leaf.getTemplateId():"-1"%>" size=3 readonly>
&nbsp;<a href="javascript:showModalDialog('doc_template_select_frame.jsp',window.self,'dialogWidth:640px;dialogHeight:480px;status:no;help:no;')">选模板</a> <span id=templateInfo>
<%if (op.equals("modify") && leaf.getTemplateId()!=-1) {%>
<a target=_blank href="doc_template_show.jsp?id=<%=leaf.getTemplateId()%>">预览模板</a> 
<%}%><a target=_self href="#" onClick="form1.templateId.value='-1'">取消模板</a>
</span></span> </td>
              </tr>
              <tr>
                <td align="left"><span class="unnamed2">
                  <%if (op.equals("modify")) {%>
                  <script>
			  var bcode = "<%=leaf.getCode()%>";
			      </script>
&nbsp;父结点：
<select name="parentCode">
<%
				Leaf rootlf = leaf.getLeaf("root");
				DirectoryView dv = new DirectoryView(rootlf);
				dv.ShowDirectoryAsOptionsWithCode(out, rootlf, rootlf.getLayer());
%>
</select>
<script>
form1.parentCode.value = "<%=leaf.getParentCode()%>";
</script>
&nbsp;( <span class="style3">蓝色</span>表示“无内容”或“列表”项 )
<%}%>
                </span></td>
              </tr>
              <tr>
                <td align="left">
				<%if (op.equals("modify")) {%>
				<input type="checkbox" name="isHome" value="true" <%=isHome?"checked":""%> >
				<%}else{%>
				<input type="checkbox" name="isHome" value="true" checked>
				<%}%>
				前台
				<%if (op.equals("modify")) {%>
<a href="dir_priv_m.jsp?dirCode=<%=StrUtil.UrlEncode(leaf.getCode())%>" target="_parent">权限</a>
<%}%>  
			应用插件
			<select name=pluginCode>
			<option value="<%=PluginUnit.DEFAULT%>">默认</option>
<%			
PluginMgr pm = new PluginMgr();
Vector v = pm.getAllPlugin();
Iterator ir = v.iterator();
while (ir.hasNext()) {
	PluginUnit pu = (PluginUnit)ir.next();
%>
<option value="<%=pu.getCode()%>"><%=pu.getName(request)%></option>
<%}%>	
				<%if (op.equals("modify")) {%>
				<script>
				form1.pluginCode.value = "<%=leaf.getPluginCode()%>";
				</script>
				<%}%>
			</select>
			<%
			String sysChecked = "";
			if (op.equals("modify")) {
				if (leaf.isSystem())
					sysChecked = "checked";
			}
			%>
			<input name="isSystem" value="1" type="checkbox" <%=sysChecked%>>系统目录
			</td>
              </tr>
              <tr>
                <td align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
                  &nbsp;&nbsp;&nbsp;
                  <input name="Submit" type="reset" class="singleboarder" value="重置">
                  &nbsp;&nbsp;&nbsp;
                  <input type="button" class="singleboarder" value="强制类型修改" onClick="enableSelType()"></td>
              </tr>
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
</body>
</html>
