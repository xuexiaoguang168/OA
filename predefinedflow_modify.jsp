<%@ page contentType="text/html;charset=gb2312"%>
<html>
<head>
<title>�������̹���</title>
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
  var r = window.confirm("��ȷ���Ƿ�Ҫ��������?")
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
		errmsg  += "��ѡ����ɾ���������ˣ�";
	if (errmsg != "")
	{
		alert(errmsg);
		return;
	}
	if (!confirm("��ȷ��Ҫɾ��"+form1.flowid.options(form1.flowid.selectedIndex).text+"��"))
		return;
	form1.action = "defineflow.jsp?mode=del";
	form1.submit();
}

function seteditperson()
{
	form3.person.value = form1.flowid.options(form1.flowid.selectedIndex).text
	form3.id.value = form1.flowid.options(form1.flowid.selectedIndex).value
}

function form1_onsubmit()
{
	errmsg = "";
	if (form1.flowid.value=="")
		errmsg  += "��ѡ����ά���Ĵ��룡";
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
		errmsg += "�����������ˣ�\n";
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
		alert("������������");
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
    <td height="23" valign="bottom" background="images/tab-b-top.gif">����������<span class="right-title">�� 
      �� �� ��</span></td>
  </tr>
  <tr>
    <td valign="top" background="images/tab-b-back.gif"><br>
      <%
String priv="upload";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String document_id = request.getParameter("document_id");
String document_name = fchar.UnicodeToGB(request.getParameter("docname"));

if (document_id==null)
{
	out.println(fchar.makeErrMsg("�ļ���ʶΪ�գ�"));
	return;
}
%>
      <jsp:useBean id="conn" scope="page" class="com.redmoon.oa.db.Conn"/> <jsp:setProperty name="conn" property="POOLNAME" value="ttoa"/> 
      <%
String mode=fchar.getNullString(request.getParameter("mode"));
if (mode.equals("del"))
{
	String id=fchar.UnicodeToGB(request.getParameter("flowid"));
	String sql = "select sort,document_id from doc_flow where id="+id;
	ResultSet rs = conn.executeQuery(sql);
	String sort = "0", document_id1="";
	if (rs!=null && rs.next()) {
		sort = rs.getString(1);
		document_id1 = rs.getString(2);
	}
	if (rs!=null) {
		rs.close();
		rs = null;
	}
	
	if (id!=null)
	{
		if (conn.executeUpdate("delete from doc_flow where id="+id)==0)
		{
			out.println(fchar.p_center("ɾ��ʧ�ܣ�"));
		}
		sql = "update doc_flow set sort=sort-1 where document_id="+document_id1+" and sort>"+sort;
		conn.executeUpdate(sql);
	}
}

if (mode.equals("edit"))
{
	String id=request.getParameter("id");
	String person = fchar.UnicodeToGB(request.getParameter("person"));
	if (id!=null)
	{
		if (!userservice.isUserExist(person)) {
			out.print(fchar.Alert("�û� "+person+" �����ڣ�"));
		}
		else
			if (conn.executeUpdate("update doc_flow set person="+fchar.sqlstr(person)+" where id="+id)==0)
			{
				out.println(fchar.p_center("<font color=red>�޸�ʧ�ܣ�</font>"));
			}
	}
}

if (mode.equals("add"))
{
	String person = fchar.UnicodeToGB(request.getParameter("person"));
	if (!userservice.isUserExist(person)) {
		out.print(fchar.Alert("�û� "+person+" �����ڣ�"));
	}
	else
		if (person!=null)
	{
		String sql = "select sort,id from doc_flow where ischecked=0 and document_id="+document_id+" order by sort desc";
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
		if (mysort==-1)//��һ������
		{
			mysort = 0;
			sql = "insert into doc_flow (ischecking,person,document_id,sort) values (1,"+fchar.sqlstr(person)+","+document_id+","+mysort+")";
		}
		else {
			mysort += 1;
			sql = "insert into doc_flow (person,document_id,sort) values ("+fchar.sqlstr(person)+","+document_id+","+mysort+")";
		}
		if (conn.executeUpdate(sql)==0)
		{
			out.println(fchar.p_center("���������"+person+"ʱ����"));
		}
	}
}
//����
if (mode.equals("sort"))
{
	String flowid[] = ((String)request.getParameter("flowids")).split(",");
	String sql = "select MAX(sort) from doc_flow where ischecked=1 and document_id="+document_id;
	int sort = 0;
	ResultSet rs = conn.executeQuery(sql);
	if (rs!=null && rs.next())
	{
		sort = rs.getInt(1);
	}
	if (rs!=null) {
		rs.close();
		rs = null;
	}
	if (sort!=0)
		sort++;

	sql = "";
	for (int i=0 ;i<flowid.length; i++)
	{
		if (sql.equals("") && sort==0)//���sortΪ0��ʾ֮ǰ�����������������̣������õ�һ������Ϊischecking=1������������
			sql += "update doc_flow set ischecking=1,sort="+sort+" where id="+flowid[i]+";";
		else
			sql += "update doc_flow set sort="+sort+" where id="+flowid[i]+";";
		sort++;
	}
	if (conn.executeUpdate(sql)==0)
	{
		out.print(fchar.p_center("����ʱ��������δ�ܳɹ���"+"<br>"));//�ɹ�ʱ����ֵҲ����Ϊ0
	}
}
%>
      <table class=p9 width="80%" border="0" cellpadding="2" cellspacing="0" align="center" height="351">
        <form id="form1" action="defineflow.jsp" method=post name="form1" onSubmit="return form1_onsubmit()">
          <tr bgcolor="#C4DAFF"> 
            <td height="22" colspan="2" align="center" class="stable"><%=document_name%> �������̹���</td>
          </tr>
          <tr> 
            <td width="73%" align="center" bgcolor="#F7F7F7" class="stable"> <%
		boolean ischecked = false;
		String options = "";
		String sql = "select id,person,ischecked from doc_flow where document_id="+document_id+" order by sort";
		ResultSet rs = conn.executeQuery(sql);
		while(rs.next())
		{
			ischecked = rs.getBoolean(3);
			if (!ischecked)
			{
				options += "<option value="+rs.getString(1)+">"+rs.getString(2)+"</option>";
			}
		}
		if (rs!=null) {
		rs.close();
		rs = null;
		}
		%> <select id=flowid name=flowid size=2 onChange="seteditperson()" style="HEIGHT: 200px; WIDTH: 220px" multiple>
                <%=options%> </select> </td>
            <td width="27%" align="center" bgcolor="#F7F7F7" class="stable"> <p> 
                <input name="reset" type="reset" class="singleboarder" value="����">
                <br>
                <br>
                <input name=del type=button class="singleboarder" onClick="delperson()" value="ɾ��">
                <br>
                <br>
                <input name=btnup type=button class="singleboarder" id=btnup onClick="return btnup_onclick()" value=���� language=javascript>
                <br>
                <br>
                <input name=btndown type=button class="singleboarder" id=btndown onClick="return btndown_onclick()" value=���� language=javascript>
                <br>
                <br>
                <input name=btnsort type=button class="singleboarder" id=btnsort onClick="btnsort_onclick()" value=���� language=javascript>
                <br>
                <input type=hidden name="document_id" value="<%=document_id%>">
              </p></td>
          </tr>
        </form>
        <form id=form3 action="?mode=edit&document_id=<%=document_id%>" onSubmit="return form3_onsubmit()" method=post name=form3>
          <tr> 
            <td align="center" bgcolor="#F7F7F7" class="stable">������ 
              <input name=person> <input type=hidden name=id></td>
            <td align="center" bgcolor="#F7F7F7" class="stable"><a href="#" onClick="javascript:showModalDialog('person_sel.jsp?op=flowmodify',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">ѡ��</a> 
              <input name="submit22" type=submit class="singleboarder" style="COLOR: #4b0082" value="�޸�">
            </td>
          </tr>
        </form>
        <form id=form2 action="?mode=add&document_id=<%=document_id%>" method=post name=form2 onSubmit="return form2_onsubmit()">
          <tr> 
            <td align="center" bgcolor="#F7F7F7" class="stable"> ������ 
              <input name=person> </td>
            <td align="center" bgcolor="#F7F7F7" class="stable"> <a href="#" onClick="javascript:showModalDialog('person_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')">ѡ��</a> 
              <input name="submit2" type=submit class="singleboarder" style="COLOR: #8b0000" value="���">
            </td>
          </tr>
        </form>
      </table>
      
      <table class=p9 width="80%" border="0" cellpadding="2" cellspacing="0" align="center">
        <tr bgcolor="#C4DAFF"> 
          <td width="100%" height="22" align="center" class="stable">�� �� �� �� ״ 
            ̬</td>
        </tr>
        <tr> 
          <td align="center" bgcolor="#F7F7F7" class="stable"> <%
		sql = "select id,person,ischecked from doc_flow where document_id="+document_id+" order by sort";
		rs = conn.executeQuery(sql);
		//out.println("���м�¼"+conn.getRows());
		while(rs.next())
		{
			ischecked = rs.getBoolean(3);
			if (!ischecked)
			{
				out.println("<div class=flowspan>"+rs.getString(2)+"<br>δ����</div><img src=images/nextflow.gif>");
			}
			else
			{
				out.println("<div class=flowspan>"+rs.getString(2)+"<br><font color=red>������</font></div><img src=images/nextflow.gif>");			
			}
		}
		if(conn.getRows()<=0)
		{
		out.println("<div class=flowspan>δ������</div>");
		}
		else{
		out.println("<div class=flowspan>�������</div>");
		}
		if (rs!=null) {
		rs.close();
		rs = null;
		}
		if (conn!=null) {
		conn.close();
		conn = null;
		}
		%> </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="9"><img src="images/tab-b-bot.gif" width="494" height="9"></td>
  </tr>
</table>
</body>
</html>