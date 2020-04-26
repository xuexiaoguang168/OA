<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.vehicle.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>车辆使用查询</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
//-->
</script>
</head>
<body>
<%@ include file="vehicle_inc_apply_top.jsp"%>
<br />
<table width="552" border="0" align="center" cellPadding="1" cellSpacing="1" bgcolor="#FFFFFF" class="tableframe">
  <form name="form1" action="vehicle_apply_list.jsp?op=search" method="post">
    <tbody>
      <tr>
        <td class="right-title" noWrap colSpan="2"> 
          &nbsp;请指定查询条件：</td>
      </tr>
      <tr>
        <td noWrap width="62">状　　态：</td>
        <td width="462"><select name="result">
            <option value="" selected>待批</option>
            <option value="是">已准</option>
            <option value="否">未准</option>
        </select></td>
      </tr>
      <tr>
        <td noWrap width="62">车 牌 号：</td>
        <td><select name="licenseNo">
<%
		VehicleDb vd = new VehicleDb();
		String sql = "select licenseNo from vehicle";
		Iterator ir = vd.list(sql).iterator();
		while (ir.hasNext()) {
			vd = (VehicleDb)ir.next();
%>
			<option value="<%=vd.getLicenseNo()%>"><%=vd.getLicenseNo()%></option>
<%}%>
        </select></td>
      </tr>
      <tr>
        <td noWrap width="62">用 车 人：</td>
        <td><input maxLength="100" name="person" size="20"></td>
      </tr>
      <tr>
        <td noWrap width="62">用车部门：</td>
        <td><select name="deptCode">
 <%
	DeptMgr dm = new DeptMgr();
	DeptDb lf = dm.getDeptDb(DeptDb.ROOTCODE);
	DeptView dv = new DeptView(lf);
	dv.ShowDeptAsOptions(out, lf, lf.getLayer()); 
 %>
 </select></td>
      </tr>
      <tr>
        <td noWrap>使用日期：</td>
        <td><input maxLength="10" size="20" name="beginDate"> 
          <img style="CURSOR: hand" onClick="SelectDate('beginDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26">&nbsp;至 
          <input maxLength="10" size="20" name="endDate"><img style="CURSOR: hand" onClick="SelectDate('endDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> 日期格式形如 1999-1-2 </td>
      </tr>
      <tr>
        <td noWrap width="62">申 请 人：</td>
        <td class="TableData"><input size="10" name="applier">&nbsp;</td>
      </tr>
      <tr align="middle">
        <td colSpan="2" align="center" noWrap><input type="submit" value="查询">&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="reset" value="重填"></td>
      </tr>
    </tbody>
  </FORM>
</table>
</body>
</html>
