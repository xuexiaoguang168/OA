<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%!
String connname = "forum";
int CountSize = 6;    //����������ǰ�����
boolean CountView = true;  //�����Ƿ���ʾ��ҳ����,False/True
boolean CountType = true;  //ͳ���Ǽ�ʱ�仹�ǲ���.True�ǣ�False����
boolean CountMode = true; //��ҳ������ʾ����ʱ�ļ��������������ʾ��ʱ�Ľ����Ĭ��Ϊ����ʱ����ʱΪ��20�����ڲ�����)
int Avera,DayMax,AllCount;
 //������������֮�����������
 public int DateDiff(java.util.Date lowerLimitDate,java.util.Date upperLimitDate){
   long upperTime,lowerTime;
   upperTime=upperLimitDate.getTime();
   lowerTime=lowerLimitDate.getTime();
   if(upperTime<lowerTime)
	return -1;
   Long result=new Long((upperTime-lowerTime)/(1000*60*60*24));
   return result.intValue();   
 }
%>
<%
ConnUpdate conn = new ConnUpdate(connname);

//==========================================================================
String CountLink = request.getContextPath()+"/forum/admin/counter/ViewInfo.asp"; //�鿴ͳ�ƽ�������ӡ�
String ImageLink = request.getContextPath()+"/forum/admin/counter";              //ͼƬ��ַ
Calendar cal = Calendar.getInstance();
String today = cal.get(cal.YEAR)+"-"+cal.get(cal.MONTH)+"-"+cal.get(cal.DATE);
//===========================================================================
String NewYear,NewMonth,NewDay;
NewYear = Integer.toString(cal.get(cal.YEAR));
NewMonth = Integer.toString(cal.get(cal.MONTH)+1);
NewDay = Integer.toString(cal.get(cal.DATE));

if (NewYear.length()<=2)	NewYear="20" + NewYear;
if (NewMonth.length()<=1)	NewMonth="0" + NewMonth;
if (Integer.parseInt(NewDay)<=1)				NewDay="0" + NewDay;
//===========================================================================  ����ͳ������
int DayTotal = 0;
ResultSet rs = conn.executeQuery("Select count(*) from DayCount");
if (rs!=null && rs.next())
	DayTotal = rs.getInt(1);                             			//���ͳ��������
else
	DayTotal = 0;
if (rs!=null)	rs.close();
rs = conn.executeQuery("Select * from Count");
java.util.Date StartDate,LogDate=null;
int ToDay=0,TotalDays=0;
if (rs!=null && rs.next())
{
	StartDate = rs.getDate("StartDate");                                 //��ʼͳ������
	DayMax    = rs.getInt("DayMax");                                     //���һ������
	AllCount  = rs.getInt("AllCount");                                   //ͳ�Ʒ�������(ʹ�õ�����)
	ToDay     = rs.getInt("ToDayCount");                                 //�����������
	LogDate   = rs.getDate("LogDate");                              	    //ͳ�ƽ�ֹ����
	TotalDays = DateDiff(StartDate,new java.util.Date())+1;         		//ͳ�Ʒ���������(������û��ʹ�ã��ӿ�ʼͳ������.)
	Avera     = rs.getInt("AllCount") % TotalDays;                  		//�վ���������
}
if (rs!=null) rs.close();
if (DateDiff(LogDate,new java.util.Date())>=1) ToDay = 0;

//===========================================================================  Ԥ��һ�������
int intending=(ToDay/(cal.get(cal.HOUR)+1)*(24-cal.get(cal.HOUR)-1)+ToDay);

//===================================================================
String DayID,MonID,YearID;
boolean MyDay;
DayID = request.getParameter("day");
MonID = request.getParameter("mon");

if (DayID==null || !fchar.isNumeric(DayID))
{
     DayID  = NewDay;
     MyDay  = false;
}
else
{
     DayID = DayID.trim();
	 MyDay  = true;
}
if (MonID==null || !fchar.isNumeric(MonID))
{
	MonID = NewYear + NewMonth;
}
else
	MonID = MonID.trim();
YearID = MonID.substring(0,4);
String Mon = MonID.substring(MonID.length()-2);
String dToday = YearID + "-" + Mon;
%>
<%
//===========================================================================
%>
<html>
<head>
<title>��֮��ͳ��ϵͳ</title>
<%@ include file="../../inc/nocache.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../common.css" type="text/css">
<style type="text/css">
<!--
BODY {font-size:9pt;font-family:Tahoma,Verdana,MS Sans Serif,Courier New;}
A:link,A:visited{text-decoration:none;}
A:hover {text-decoration:underline;}
A:hover {text-decoration:overline;color:#FFFF00}
TR,TD,P{font-size:9pt}
B{color:#E1005D;}
INPUT.text,INPUT.file,SELECT,TEXTAREA{color:#000000;background-color:#FFFFFF;border:1 solid #220430}
#TITLE{height:20;Filter: shadow(color=#00AAFF,direction=135);}
.notice{position:relative;height:50;overflow:visible;border:0;z-index:2}
FONT.table{color:#000000}
FONT.strong{color:#FFFFEE;font-weight:bold}
.footer{color:#FFFFEE;font-size:8pt}
.info,.title{background-color:#002F90}
.outter{background-color:#350682}
.cell{background-color:#9B9D9A}
FONT.search{color:#FFFFFF}
FONT.notice{color:#FFFFFF}
.retable{background-color:#FFFFFF}
.rcontent{background-color:#F0F0F0}
FONT.small{font-size:7pt}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="576" border="0" cellpadding="0" cellspacing="0" align="center" height="48">
  <tr> 
    <td align="center"><font color="#000000">����: <%=today%><img src="<%=ImageLink%>/theme/default/vstatb.gif"> 
      ȫ��: <%=AllCount%><img src="<%=ImageLink%>/theme/default/hstatt.gif"> ���: 
      <%=DayMax%><img src="<%=ImageLink%>/theme/default/vstatg.gif"> �վ�: <%=Avera%> 
      </font></td>
  </tr>
</table>
<table width="576" height="21" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr class=info><td align=right colspan=3><font class=strong>���20λ���� ͳ��</font></td></tr>
<%        
        ResultSet MyCount = conn.executeQuery("Select * FROM lastly order by Date desc");
        if (conn.getRows()>0)
		{
			while (MyCount.next())
			{
				 String Online = "<Img Src=" + ImageLink + "/theme/default/online.gif align=absmiddle width=13 height=15>";
				 %>
				 <tr class=rcontent><td height=30><nobr><%=MyCount.getDate("Date")%></nobr></td><td><nobr><%=Online%><%=MyCount.getString("IP")%></td><td><%=MyCount.getString("BC")%>&nbsp;&nbsp;<%=MyCount.getString("OS")%></td></tr>
				 <%
			}
		}
		else
            out.println("<tr class=rcontent><TD colspan=3 align=center>û��ͳ������</TD></TR>");
        MyCount.close();
        conn.close();  
%>
	</table>
<table width="576" border="0" class="p9" cellpadding="0" align="center">
  <tr>
    <td align="center" height="42"> 
      ��ֹ����: <%=LogDate%>, ͳ������: <%=DayTotal%>/<%=TotalDays%> ��, Ԥ�Ʊ��շ�����: <%=intending%> 
      �� </td>
  </tr>
</table>
     
<table cellspacing='0' cellpadding='3' width='576' border='0' align="center">
  <tr><td align=center><font class=footer>��֮��<br><img src='theme/default/hr_black.gif' height=2 width='60%'><br>Copyright &copy2000-2001 <A href='mailto:bestfeng@163.com'>������</A>,All Rights Reserved</font></td></tr>
     <tr><td>
     </td></tr></table>
</body>
</html>