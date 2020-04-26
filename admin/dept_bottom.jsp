<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.util.*" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="com.redmoon.oa.dept.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>部门信息管理</title>
<LINK href="default.css" type=text/css rel=stylesheet>
<script>
function form1_onsubmit() {
	form1.root_code.value = window.parent.dirmainFrame.getRootCode();
}
</script>
</head>
<body>
<%
String parent_code = ParamUtil.get(request, "parent_code");
if (parent_code.equals(""))
	parent_code = "root";
String parent_name = ParamUtil.get(request, "parent_name");
String code = ParamUtil.get(request, "code");
String name = ParamUtil.get(request, "name");
String description = ParamUtil.get(request, "description");
String op = ParamUtil.get(request, "op");
int type = 0;
if (op.equals(""))
	op = "AddChild";
DeptDb leaf = null;
if (op.equals("modify")) {
	DeptMgr dir = new DeptMgr();
	leaf = dir.getDeptDb(code);
	name = leaf.getName();
	description = leaf.getDescription();
	type = leaf.getType();
}
%>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%">部门增加或修改</TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD align="center" style="PADDING-LEFT: 10px"><table class="frame_gray" width="61%" border="0" cellpadding="0" cellspacing="1">
        <tr>
          <td align="center"><table width="92%">
            <form name="form1" method="post" action="dept_top.jsp?op=<%=op%>" target="dirmainFrame" onClick="return form1_onsubmit()">
              <tr>
                <td width="104" rowspan="5" align="left" valign="top"><br>
                  当前结点：<br>
                    <font color=blue><%=parent_name.equals("")?"所有部门":parent_name%></font>					</td>
                <td align="center"> 编码
                    <input name="code" value="<%=code%>" <%=op.equals("modify")?"readonly":""%>>                </td>
              </tr>
              <tr>
                <td align="center">名称
                    <input name="name" value="<%=name%>"></td>
              </tr>
              <tr>
                <td align="center">描述
                    <input name="description" value="<%=description%>">
                    <input type=hidden name=parent_code value="<%=parent_code%>">
                    <input type=hidden name=type value=1>
                    <input type=hidden name=root_code value=""></td>
              </tr>
              <tr>
                <td align="center"><%if (op.equals("modify")) {%>
                  <script>
				    var bcode = "<%=leaf.getCode()%>";
			        </script>
&nbsp;
<%if (code.equals(leaf.ROOTCODE)) {%>
<input type=hidden name="parentCode" value="<%=leaf.getParentCode()%>">
<%}else{%>
父结点：
<select name="parentCode">
  <%
									DeptDb rootlf = leaf.getDeptDb(DeptDb.ROOTCODE);
									DeptView dv = new DeptView(rootlf);
									dv.ShowDeptAsOptions(out, rootlf, rootlf.getLayer());
					%>
</select>
<script>
					form1.parentCode.value = "<%=leaf.getParentCode()%>";
					</script>
<%}%>
<%}%></td>
              </tr>
              <tr>
                <td align="center"><input name="Submit" type="submit" class="singleboarder" value="提交">
&nbsp;&nbsp;&nbsp;
<input name="Submit" type="reset" class="singleboarder" value="重置">				  </td>
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
