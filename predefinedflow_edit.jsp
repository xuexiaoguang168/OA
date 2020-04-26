<%@ page contentType="text/html;charset=gb2312"%>
<html>
<head>
<title>审批流程管理</title>
<style type="text/css">
<!--
.flowspan {
	background: White;
	border: 1px solid Black;
	text-align: center;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 6px;
	padding-bottom: 6px;
	width: 200px;
	}
-->
</style>
<%@ include file="../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="common.css" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="javascript">
<!--
function setperson(p)
{
	form2.person.value = p
}

function btnsort_onclick() {
  len = form1.flowid.options.length;
  var flowids = "";
  for (i=0; i<len; i++)
  {
	form1.flowid.options(i).selected = true;
	if (flowids=="")
		flowids += form1.flowid.options(i).value;
	else
		flowids += ","+form1.flowid.options(i).value;
  }
  var r = window.confirm("请确定是否要重新排序?")
  if (!r)
    return false
  form1.action = "?mode=sort&flowids="+flowids;
  form1.submit();
}

function btnup_onclick() {
	index = form1.flowid.selectedIndex
	if (index==0)
		return;
	
	temp1 = form1.flowid.options(index).text
	temp2 = form1.flowid.options(index).value
	form1.flowid.options(index).value = form1.flowid.options(index-1).value;
	form1.flowid.options(index).text = form1.flowid.options(index-1).text;
	form1.flowid.options(index-1).value = temp2
	form1.flowid.options(index-1).text = temp1;
	form1.flowid.selectedIndex = index-1;
}

function btndown_onclick() {
	index = form1.flowid.selectedIndex
	if (index==form1.flowid.length-1)
		return;
	
	temp1 = form1.flowid.options(index).text
	temp2 = form1.flowid.options(index).value
	form1.flowid.options(index).value = form1.flowid.options(index+1).value;
	form1.flowid.options(index).text = form1.flowid.options(index+1).text;
	form1.flowid.options(index+1).value = temp2
	form1.flowid.options(index+1).text = temp1;
	form1.flowid.selectedIndex = index+1;
}

function delperson()
{
	errmsg = "";
	if (form1.flowid.value=="")
		errmsg  += "请选择需删除的审批人！";
	if (errmsg != "")
	{
		alert(errmsg);
		return;
	}
	if (!confirm("您确定要删除"+form1.flowid.options(form1.flowid.selectedIndex).text+"吗？"))
		return;
	form1.action = "predefinedflow_edit.jsp?mode=del";
	form1.submit();
}

function seteditperson()
{
	form3.person.value = form1.flowid.options(form1.flowid.selectedIndex).text
	form3.flowid.value = form1.flowid.options(form1.flowid.selectedIndex).value
}

function form1_onsubmit()
{
	errmsg = "";
	if (form1.flowid.value=="")
		errmsg  += "请选择需维护的代码！";
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
	form1.action="class1m.jsp";
}

function form2_onsubmit()
{
	errmsg = "";
	if (form2.person.value=="")
		errmsg += "请输入审批人！\n";
	if (errmsg!="")
	{
		alert(errmsg);
		return false;
	}
}

function form3_onsubmit()
{
	if (form3.person.value=="")
	{
		alert("请输入审批人");
		return false;
	}
}
//-->
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="inc/inc.jsp"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.oa.person.UserService"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<table width="494" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="23" valign="bottom" background="images/tab-b-top.gif">　　　　　<span class="right-title">审 
      批 流 程</span></td>
  </tr>
  <tr>
    <td valign="top" background="images/tab-b-back.gif"><br>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

priv="predefinedflow";
boolean isPrivValid = privilege.isUserDepartmentPrivValid(request,priv);
if (!isPrivValid) {
	out.println(fchar.makeErrMsg("您无定义流程的权限！"));
	return;
}

String predefined_flow_id = request.getParameter("predefined_flow_id");
String id = request.getParameter("flowid");
if (predefined_flow_id==null)
{
	out.println(fchar.makeErrMsg("流程标识不能为空！"));
	return;
}
%>
      <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/>
	  <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/> 
      <%
String mode=fchar.getNullString(request.getParameter("mode"));
if (mode.equals("del"))
{
	String sql = "select sort from predefined_flow_item where id="+id;
	ResultSet rs = conn.executeQuery(sql);
	String sort = "0";
	if (rs!=null && rs.next()) {
		sort = rs.getString(1);
	}
	if (rs!=null) {
		rs.close();
		rs = null;
	}
	
	if (id!=null)
	{
		if (conn.executeUpdate("delete from predefined_flow_item where id="+id)==0)
		{
			out.println(fchar.p_center("删除失败！"));
		}
		sql = "update predefined_flow_item set sort=sort-1 where id="+id+" and sort>"+sort;
		conn.executeUpdate(sql);
	}
}

if (mode.equals("edit"))
{
	String person = fchar.UnicodeToGB(request.getParameter("person"));
	if (id!=null)
	{
		if (!userservice.isUserExist(person)) {
			out.print(fchar.Alert("用户 "+person+" 不存在！"));
		}
		else
			if (conn.executeUpdate("update predefined_flow_item set person="+fchar.sqlstr(person)+" where id="+id)==0)
			{
				out.println(fchar.p_center("<font color=red>修改失败！</font>"));
			}
	}
}

if (mode.equals("add"))
{
	String person = fchar.UnicodeToGB(request.getParameter("person"));
	if (!userservice.isUserExist(person)) {
		out.print(fchar.Alert("用户 "+person+" 不存在！"));
	}
	else
		if (person!=null)
	{
		String sql = "select sort,id from predefined_flow_item where id="+predefined_flow_id+" order by sort desc";
		int mysort = -1;
		ResultSet rs = conn.executeQuery(sql);
		if (rs!=null && rs.next())
		{
			mysort = rs.getInt(1);
		}
		if (rs!=null) {
			rs.close();
			rs = null;
		}
		if (mysort==-1)//第一个流程
		{
			mysort = 0;
			sql = "insert into predefined_flow_item (person,predefined_flow_id,sort) values ("+fchar.sqlstr(person)+","+predefined_flow_id+","+mysort+")";
		}
		else {
			mysort += 1;
			sql = "insert into predefined_flow_item (person,predefined_flow_id,sort) values ("+fchar.sqlstr(person)+","+predefined_flow_id+","+mysort+")";
		}
		if (conn.executeUpdate(sql)==0)
		{
			out.println(fchar.p_center("添加审批人"+person+"时出错！"));
		}
	}
}
//排序
if (mode.equals("sort"))
{
	String flowid[] = ((String)request.getParameter("flowids")).split(",");
	int sort = 0;
	String sql = "";
	for (int i=0 ;i<flowid.length; i++)
	{
		sql += "update predefined_flow_item set sort="+sort+" where id="+flowid[i]+";";
		sort++;
	}
	if (conn.executeUpdate(sql)==0)
	{
		out.print(fchar.p_center("排序时出错，操作未能成功！"+"<br>"));//成功时返回值也可能为0
	}
}
%>
      <table class=p9 width="80%" border="0" cellpadding="2" cellspacing="0" align="center" height="351">
        <form id="form1" action="predefinedflow_edit.jsp" method=post name="form1" onSubmit="return form1_onsubmit()">
          <tr bgcolor="#C4DAFF"> 
            <td height="22" colspan="2" align="center" class="stable">预定义审批流程管理</td>
          </tr>
          <tr> 
            <td width="73%" align="center" bgcolor="#F7F7F7" class="stable"> <%
		String options = "";
		String sql = "select id,person from predefined_flow_item where predefined_flow_id="+predefined_flow_id+" order by sort";
		ResultSet rs = conn.executeQuery(sql);
		while(rs.next())
		{
			options += "<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
		}
		if (rs!=null) {
			rs.close();
			rs = null;
		}
		if (conn!=null) {
			conn.close(); conn = null;
		}
		%> <select id=flowid name=flowid size=2 onChange="seteditperson()" style="HEIGHT: 200px; WIDTH: 220px" multiple>
                <%=options%> </select> </td>
            <td width="27%" align="center" bgcolor="#F7F7F7" class="stable"> <p> 
                <input name="reset" type="reset" class="singleboarder" value="重置">
                <br>
                <br>
                <input name=del type=button class="singleboarder" onClick="delperson()" value="删除">
                <br>
                <br>
                <input name=btnup type=button class="singleboarder" id=btnup onClick="return btnup_onclick()" value=上移 language=javascript>
                <br>
                <br>
                <input name=btndown type=button class="singleboarder" id=btndown onClick="return btndown_onclick()" value=下移 language=javascript>
                <br>
                <br>
                <input name=btnsort type=button class="singleboarder" id=btnsort onClick="btnsort_onclick()" value=排序 language=javascript>
                <br>
                <input type=hidden name="predefined_flow_id" value="<%=predefined_flow_id%>">
              </p></td>
          </tr>
        </form>
        <form id=form3 action="?mode=edit&predefined_flow_id=<%=predefined_flow_id%>" onSubmit="return form3_onsubmit()" method=post name=form3>
          <tr> 
            <td align="center" bgcolor="#F7F7F7" class="stable">审批人 
              <input name=person> <input type=hidden name=flowid></td>
            <td align="center" bgcolor="#F7F7F7" class="stable"><a href="#" onClick="javascript:showModalDialog('person_sel.jsp?op=flowmodify',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择</a> 
              <input name="submit22" type=submit class="singleboarder" style="COLOR: #4b0082" value="修改">
            </td>
          </tr>
        </form>
        <form id=form2 action="?mode=add&predefined_flow_id=<%=predefined_flow_id%>" method=post name=form2 onSubmit="return form2_onsubmit()">
          <tr> 
            <td align="center" bgcolor="#F7F7F7" class="stable"> 审批人 
              <input name=person></td>
            <td align="center" bgcolor="#F7F7F7" class="stable"> <a href="#" onClick="javascript:showModalDialog('person_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">选择</a> 
              <input name="submit2" type=submit class="singleboarder" style="COLOR: #8b0000" value="添加">
            </td>
          </tr>
        </form>
      </table>
      
      
    </td>
  </tr>
  <tr>
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>