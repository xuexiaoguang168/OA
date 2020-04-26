<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.archive.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.jfree.data.general.DefaultPieDataset"%>
<%@ page import="org.jfree.chart.JFreeChart"%>
<%@ page import="org.jfree.chart.plot.PiePlot"%>
<%@ page import="org.jfree.chart.ChartRenderingInfo"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities"%>
<%@ page import="org.jfree.chart.urls.StandardPieURLGenerator"%>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@ page import="org.jfree.chart.encoders.SunPNGEncoderAdapter"%>
<%@ page import="org.jfree.chart.labels.*"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>档案统计分析</title>
<link rel="stylesheet" type="text/css" href="../common.css">
<link rel="stylesheet" type="text/css" href="../css.css">
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
%>
<table width="304" border="0" cellspacing="0" cellpadding="0">
  <form action="?op=showChart" method="post" name="form1" id="form1">
    <tr>
      <td width="183"><strong>&nbsp;请选择分布类型</strong>
          <select name="type" id="type">
            <option value="age" selected="selected"> 年&nbsp;&nbsp;&nbsp;&nbsp;龄 </option>
            <option value="xl"> 学&nbsp;&nbsp;&nbsp;&nbsp;历 </option>
          </select>
      </td>
      <td width="121"><input type="submit" name="Submit" value="确 定" /></td>
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
double[] datas = null;
UserArchiveDb uad = new UserArchiveDb();

if (type.equals("age")) {
	labels = uad.getAgeGrade();
	// The data for the pie chart
	datas = uad.getAgeEveryGradeCount();
}
else if (type.equals("xl")) {
	labels = uad.getXueLiGrade();
	// The data for the pie chart
	datas = uad.getXueLiEveryGradeCount();
}

DefaultPieDataset data = new DefaultPieDataset();
int len = labels.length;
for (int i=0; i<len; i++) {
	data.setValue(labels[i], datas[i]);
}

PiePlot plot = new PiePlot(data);
JFreeChart chart = new JFreeChart("", JFreeChart.DEFAULT_TITLE_FONT, plot, true);
chart.setBackgroundPaint(java.awt.Color.white);  //可选，设置图片背景色
chart.setTitle("档案分析"); //可选，设置图片标题

// plot.setToolTipGenerator(new org.jfree.chart.labels.StandardPieToolTipGenerator()); 

plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})", NumberFormat.getNumberInstance(), new DecimalFormat("0.00%")));
ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());

//500是图片长度，300是图片高度
String filename = ServletUtilities.saveChartAsPNG(chart, 600, 360, info, session);
String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename; 	
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><img src="<%=graphURL%>" width=600 height=360 border=0 usemap="#<%=filename %>" /></td>
  </tr>
</table>
</body>
</html>
