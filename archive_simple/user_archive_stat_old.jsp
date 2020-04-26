<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.archive.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="ChartDirector.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>档案统计分析</title>
<link rel="stylesheet" type="text/css" href="../common.css">
<link rel="stylesheet" type="text/css" href="../css.css">
</head>
<body>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width="304" border="0" cellspacing="0" cellpadding="0">
  <form action="?op=showChart" method="post" name="form1" id="form1">
    <tr>
      <td width="235"><strong>&nbsp;请选择分布类型</strong>
          <select name="type" id="type">
            <option value="age" selected="selected"> 年&nbsp;&nbsp;&nbsp;&nbsp;龄 </option>
            <option value="xl"> 学&nbsp;&nbsp;&nbsp;&nbsp;历 </option>
          </select>
      </td>
      <td width="69"><input type="submit" name="Submit" value="确 定" /></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </form>
</table>
<%
String op = ParamUtil.get(request, "op");
op = "showChart";
String type = ParamUtil.get(request, "type");
if (type.equals(""))
	type = "age";
%>
<script>
form1.type.value = "<%=type%>";
</script>
<%
String[] labels = null;
double[] data = null;
UserArchiveDb uad = new UserArchiveDb();

if (type.equals("age")) {
	labels = uad.getAgeGrade();
	// The data for the pie chart
	data = uad.getAgeEveryGradeCount();
}
else if (type.equals("xl")) {
	labels = uad.getXueLiGrade();
	// The data for the pie chart
	data = uad.getXueLiEveryGradeCount();
}
	
// Create a PieChart object of size 450 x 240 pixels
PieChart c = new PieChart(600, 380);
c.setLabelStyle("宋体", 10, 0x663300);
// Set the center of the pie at (150, 100) and the radius to 80 pixels
c.setPieSize(320, 200, 140);
// Add a title at the bottom of the chart using Arial Bold Italic font
c.addTitle2(Chart.Top, "档案分析", "宋体", 10);
// Draw the pie in 3D
c.set3D();
// add a legend box where the top left corner is at (330, 40)
c.addLegend(480, 50,true,"宋体");
// modify the label format for the sectors to $nnnK (pp.pp%)
c.setLabelFormat("{label}\n{value}个 ({percent}%)");
// Set the pie data and the pie labels
c.setData(data, labels);
// Explode the 1st sector (index = 0)
c.setExplode(0);

//output the chart
String chart1URL = c.makeSession(request, "chart1");

//include tool tip for the chart
String imageMap1 = c.getHTMLImageMap("", "",
    "title='{label}:{value}个({percent}%)'");
%>
                    <img src='<%=response.encodeURL("../getchart.jsp?"+chart1URL)%>'
    usemap="#map1" border="0">
                    <map name="map1">
                      <%=imageMap1%>
                    </map>
</body>
</html>
