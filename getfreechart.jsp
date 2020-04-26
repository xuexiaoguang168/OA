<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.jfree.data.general.DefaultPieDataset"%>
<%@ page import="org.jfree.chart.JFreeChart"%>
<%@ page import="org.jfree.chart.plot.PiePlot"%>
<%@ page import="org.jfree.chart.ChartRenderingInfo"%>
<%@ page import="org.jfree.chart.servlet.ServletUtilities"%>
<%@ page import="org.jfree.chart.urls.StandardPieURLGenerator"%>
<%@ page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@ page import="org.jfree.chart.encoders.SunPNGEncoderAdapter"%>
<%
/*
DefaultPieDataset dataset = new DefaultPieDataset();
dataset.setValue(StrUtil.GBToUnicode("ƻ��GOOD"),100);
dataset.setValue("����",200);
dataset.setValue("����",300);
dataset.setValue("�㽶",400);
dataset.setValue("��֦",500);
response.setContentType("image/jpeg");

JFreeChart chart = ChartFactory.createPieChart3D("ˮ������ͼ", dataset, true, false, false);

Font font = new Font("����",Font.TRUETYPE_FONT, 12);
// StandardLegend legend = (StandardLegend) chart.getLegend();
// legend.setItemFont(font);

String title = "�յ�2002���г�ռ����";
//�趨ͼƬ����
chart.setTitle(new TextTitle(title, new Font("����", Font.ITALIC, 15)));
// chart.addSubtitle(new TextTitle("2002�������", new Font("����", Font.ITALIC, 12)));
//�趨����
// chart.setBackgroundPaint(Color.white);
//chart.s
//��ͼʹ��һ��PiePlot 
PiePlot pie = (PiePlot)chart.getPlot();
//pie.setSectionLabelType(PiePlot.NAME_AND_PERCENT_LABELS);
//�趨��ʾ��ʽ(���ƼӰٷֱȻ���ֵ)
// pie.setPercentFormatString("#,###0.0#%");
//�趨�ٷֱ���ʾ��ʽ
// pie.setBackgroundPaint(Color.white);
pie.setLabelFont(new Font("����", Font.TRUETYPE_FONT, 12));
//�趨����͸���ȣ�0-1.0֮�䣩
pie.setBackgroundAlpha(0.6f);
//�趨ǰ��͸���ȣ�0-1.0֮�䣩
pie.setForegroundAlpha(0.90f);
*/


/*
//ͼƬ����
String title = "�յ�2002���г�ռ����";

DefaultPieDataset piedata = new DefaultPieDataset();
//��һ������Ϊ���ƣ��ڶ���������double��
piedata.setValue("����", 27.3);
piedata.setValue("����", 12.2);
piedata.setValue("����", 5.5);
piedata.setValue("����", 17.1);
piedata.setValue("����", 9.0);
piedata.setValue("����", 19.0);
//����JFreeChart����ʹ��ChartFactory������JFreeChart,�ܱ�׼�Ĺ������ģʽ
JFreeChart chart = ChartFactory.createPieChart(title, piedata, true, true, true);
//�趨ͼƬ����
chart.setTitle(new TextTitle(title, new Font("����", Font.ITALIC, 15)));
//chart.addSubtitle(new TextTitle("2002�������", new Font("����", Font.ITALIC, 12)));
//�趨����
chart.setBackgroundPaint(Color.white);
//chart.s
//��ͼʹ��һ��PiePlot 
PiePlot pie = (PiePlot)chart.getPlot();
// pie.setSectionLabelType(PiePlot.NAME_AND_VALUE_LABELS);
//�趨��ʾ��ʽ(���ƼӰٷֱȻ���ֵ)
// pie.setPercentFormatString("#,###0.0#%");
//�趨�ٷֱ���ʾ��ʽ
pie.setBackgroundPaint(Color.white);
// pie.setSectionLabelFont(new Font("����", Font.TRUETYPE_FONT, 12));
//�趨����͸���ȣ�0-1.0֮�䣩
pie.setBackgroundAlpha(0.6f);
//�趨ǰ��͸���ȣ�0-1.0֮�䣩
pie.setForegroundAlpha(0.90f);


ChartUtilities.writeChartAsJPEG(response.getOutputStream(), 100, chart, 400, 300, null);

*/
DefaultPieDataset data = new DefaultPieDataset();
data.setValue("����", 500);
data.setValue("����", 580);
data.setValue("����", 828); 
data.setValue("����",200);
data.setValue("����",300);
data.setValue("�㽶",400);
data.setValue("��֦",500);


PiePlot plot = new PiePlot(data);
JFreeChart chart = new JFreeChart("", JFreeChart.DEFAULT_TITLE_FONT, plot, true);
chart.setBackgroundPaint(java.awt.Color.white);  //��ѡ������ͼƬ����ɫ
chart.setTitle("��������"); //��ѡ������ͼƬ����

plot.setToolTipGenerator(new org.jfree.chart.labels.StandardPieToolTipGenerator()); 

ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());

//500��ͼƬ���ȣ�300��ͼƬ�߶�
String filename = ServletUtilities.saveChartAsPNG(chart, 500, 300, info, session);
String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename; 
%>
<HTML>
<HEAD>
       <TITLE>Welcome to Jfreechart !</TITLE>
</HEAD>
<BODY>
<P ALIGN="CENTER">
<img src="<%=graphURL %>" width=500 height=300 border=0 usemap="#<%= filename %>">
</P>
</BODY>

</HTML>
