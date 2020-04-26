<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="com.redmoon.oa.netdisk.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="com.redmoon.oa.pvg.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<LINK href="default.css" type=text/css rel=stylesheet>
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "read")) {
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
String mappingAddress = "";
int type = 0;
if (op.equals("")) {
	op = "AddChild";
}

if (op.equals("AddChild")) {
	PublicLeafPriv lp = new PublicLeafPriv(parent_code);
	if (!lp.canUserManage(privilege.getUser(request))) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}	
}

PublicLeaf leaf = null;
if (op.equals("modify")) {
	PublicLeafPriv lp = new PublicLeafPriv(code);
	if (!lp.canUserManage(privilege.getUser(request))) {
		out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
		return;
	}	
	PublicDirectory dir = new PublicDirectory();
	leaf = dir.getLeaf(code);
	name = leaf.getName();
	description = leaf.getDescription();
	type = leaf.getType();
	isHome = leaf.getIsHome();
	mappingAddress = leaf.getMappingAddress();
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
      <TD align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="415" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td width="411" align="center"><table width="98%">
            <form name="form1" method="post" action="netdisk_public_dir_top.jsp?op=<%=op%>" target="dirmainFrame">
              <tr>
                <td width="78" rowspan="6" align="left" valign="top"><br>
                  当前结点：<br>
                    <font color=blue><%=parent_name.equals("")?"根结点":parent_name%></font>					</td>
                <td width="312" align="left"> 编码
                    <input name="code" value="<%=code%>" <%=op.equals("modify")?"readonly":""%>>                </td>
              </tr>
              <tr>
                <td align="left">名称
                    <input name="name" value="<%=name%>"></td>
              </tr>
              <tr>
                <td align="left">描述
                    <input name="description" value="<%=StrUtil.getNullStr(description)%>">
                    <input type=hidden name=parent_code value="<%=parent_code%>">                    </td>
              </tr>
              
              <tr>
                <td align="left">映射地址<input name="mappingAddress" value="<%=StrUtil.getNullStr(mappingAddress)%>"></td>
              </tr>
              <tr>
                <td align="left"><span class="unnamed2">
                  <%if (op.equals("modify")) {%>
                  <script>
			  var bcode = "<%=leaf.getCode()%>";
			      </script>
<%if (op.equals("modify") && !leaf.getCode().equals(PublicLeaf.ROOTCODE)) {%>				  
&nbsp;父结点：
<select name="parentCode">
<%
				PublicLeaf rootlf = leaf.getLeaf("root");
				PublicDirectoryView dv = new PublicDirectoryView(rootlf);
				dv.ShowDirectoryAsOptionsWithCode(out, rootlf, rootlf.getLayer());
%>
</select>
<script>
form1.parentCode.value = "<%=leaf.getParentCode()%>";
</script>
<%}else{%>
<input type="hidden" name="parentCode" value="<%=leaf.getParentCode()%>">
<%}%>
&nbsp;
<%}%>
                </span></td>
              </tr>
              
              <tr>
                <td align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
                  &nbsp;&nbsp;&nbsp;
                  <input name="Submit" type="reset" class="singleboarder" value="重置">
                  &nbsp;&nbsp;&nbsp;</td>
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
