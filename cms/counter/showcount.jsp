<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
if (!privilege.isUserPrivValid(request, "forum.bak"))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%!
String connname = Global.defaultDB;
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
 
 public String Right(String str ,int n)
 {
 	return str.substring(str.length()-2);
 }
%>

<%
Conn conn = new Conn(connname);
Calendar cal = Calendar.getInstance();
String today = cal.get(cal.YEAR)+"-"+(cal.get(cal.MONTH)+1)+"-"+cal.get(cal.DATE);
//===========================================================================
String NewYear,NewMonth,NewDay;
NewYear = Integer.toString(cal.get(cal.YEAR));
NewMonth = Integer.toString(cal.get(cal.MONTH)+1);
NewDay = Integer.toString(cal.get(cal.DATE));

if (NewYear.length()<=2)	NewYear="20" + NewYear;
if (NewMonth.length()<=1)	NewMonth="0" + NewMonth;
if (Integer.parseInt(NewDay)<=9)				NewDay="0" + NewDay;
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
if (DayID.length()<=1)
	DayID = "0" + DayID;
if (MonID.length()<=1)
	MonID = "0" + MonID;	
%>
<%
//===========================================================================
%>
<html>
<head>
<title>����ͳ��ϵͳ</title>
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
.style1 {color: #0000FF}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
//==========================================================================
String CountLink = request.getContextPath()+"/cms/counter/ViewInfo.asp"; //�鿴ͳ�ƽ�������ӡ�
String ImageLink = request.getContextPath()+"/cms/counter";              //ͼƬ��ַ
%>
<table width="576" border="0" cellpadding="0" cellspacing="0" align="center" height="48">
  <tr> 
    <td align="center"><font color="#000000">����: <%=today%><img src="<%=ImageLink%>/theme/default/vstatb.gif"> 
      ȫ��: <%=AllCount%><img src="<%=ImageLink%>/theme/default/hstatt.gif"> ���: 
      <%=DayMax%><img src="<%=ImageLink%>/theme/default/vstatg.gif"> �վ�: <%=Avera%>
      <%
//===========================================================================
		String ScriptName = request.getRequestURL().toString();
//===========================================================================
		String path = "bc";
		try {
			ResultSet MyCount = conn.executeQuery("Select * From bc");
			if ( conn.getRows()>0)
			{
				   %>
      <a href="showlast.jsp">���20λ����</a></font></td>
  </tr>
</table>
<table class=p9 width="576" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr class=info>
    <td align=right colspan=2><font class=strong>������ ����� ͳ��</font></td>
  </tr>
  <%
				   int counttotal = 0;
				   int todaystotal = 0;
				   int countwidth = 0;
				   int todayswidth = 0;
				   while (MyCount.next())
				   {
						  counttotal = MyCount.getInt("count") + counttotal;
						  todaystotal = MyCount.getInt("todays") + todaystotal;
						  if (countwidth < MyCount.getInt("count")) 
						  	countwidth = MyCount.getInt("count");
						  if (todayswidth < MyCount.getInt("todays")) 
						  	todayswidth = MyCount.getInt("todays");
				   }
				   MyCount.beforeFirst();
				   int dpct = 0;
				   int tpct = 0;
				   int widthd = 0;
				   int widtht = 0;
				   while (MyCount.next())
				   {
						  dpct = (int)Math.round((double)MyCount.getInt("todays")/todaystotal*100);
						  tpct = (int)Math.round((double)MyCount.getInt("count")/counttotal*100);
						  widthd = dpct*3;
						  widtht = tpct*3;
						  %>
  <tr class=rcontent> 
    <td height="39"><nobr><%=MyCount.getString(path)%></nobr></td>
    <td height="39"><nobr><img src="<%=ImageLink%>/theme/default/vstatb.gif" width="<%=widthd%>" height=10><%=Percent(MyCount.getInt("todays"),todaystotal)%> 
      (<%=MyCount.getInt("todays")%>)<nobr><br>
      <nobr><img src="<%=ImageLink%>/theme/default/hstatt.gif" width="<%=widtht%>" height=10><%=Percent(MyCount.getInt("count"),counttotal)%> 
      (<%=MyCount.getInt("count")%>)</nobr></td>
  </tr>
  <%
				   }%>
</table>
<%
			 }
			 MyCount.close();
		 }
		 catch (java.sql.SQLException e)
		 {}
		 catch (java.io.IOException e)
		 {}
		path = "os";
		try {
			ResultSet MyCount = conn.executeQuery("Select * From os");
			if ( conn.getRows()>0)
			{
				   %>
<table class=p9 width="576" align="center" border="0" cellspacing="0" cellpadding="0">
  <tr class=info>
    <td align=right colspan=2><font class=strong>������ ����ϵͳ ͳ��</font></td>
  </tr>
  <%
				   int counttotal = 0;
				   int todaystotal = 0;
				   int countwidth = 0;
				   int todayswidth = 0;
				   while (MyCount.next())
				   {
						  counttotal = MyCount.getInt("count") + counttotal;
						  todaystotal = MyCount.getInt("todays") + todaystotal;
						  if (countwidth < MyCount.getInt("count")) 
						  	countwidth = MyCount.getInt("count");
						  if (todayswidth < MyCount.getInt("todays")) 
						  	todayswidth = MyCount.getInt("todays");
				   }
				   MyCount.beforeFirst();
				   int dpct = 0;
				   int tpct = 0;
				   int widthd = 0;
				   int widtht = 0;
				   while (MyCount.next())
				   {
						  dpct = (int)Math.round((double)MyCount.getInt("todays")/todaystotal*100);
						  tpct = (int)Math.round((double)MyCount.getInt("count")/counttotal*100);
						  widthd = dpct*3;
						  widtht = tpct*3;
						  %>
  <tr class=rcontent>
    <td><nobr><%=MyCount.getString(path)%></nobr></td>
    <td><nobr><img src="<%=ImageLink%>/theme/default/vstatb.gif" width="<%=widthd%>" height=10><%=Percent(MyCount.getInt("todays"),todaystotal)%> 
      (<%=MyCount.getInt("todays")%>)<nobr><br>
      <nobr><img src="<%=ImageLink%>/theme/default/hstatt.gif" width="<%=widtht%>" height=10><%=Percent(MyCount.getInt("count"),counttotal)%> 
      (<%=MyCount.getInt("count")%>)</nobr></td>
  </tr>
  <%
				   }%>
</table>
<%
			 }
			 MyCount.close();
		 }
		 catch (java.sql.SQLException e)
		 {}
		 catch (java.io.IOException e)
		 {}
%>
<br>
<table width="576" border="0" class="p9" align="center" cellpadding="0" cellspacing="0">
  <tr class=info>
    <td align="right"><font class=strong><%=YearID%> �� <%=Mon%> �� ��ͳ��</font> </td>
  </tr>
</table>
<table cellspacing='0' cellpadding='0' width='576' border='0' class="p9" align="center">
  <tr align=center valign=bottom> 
    <%//===========================================================================
		String mondays = ",31,28,31,30,31,30,31,31,30,31,30,31";
		String[] lastday = mondays.split(",");
        if (((Integer.parseInt(YearID) % 4 == 0) && (Integer.parseInt(YearID) % 100 != 0)) || (Integer.parseInt(YearID) % 400 == 0))	lastday[2] = "29";
		
        String StrSQL="Select * From MonthCount Where ID = " + MonID;
        ResultSet MyCount = conn.executeQuery(StrSQL);

        if (!MyCount.next())
             out.println( "<TD align=center>û��ͳ������</TD>");
        else
		{
             String weekstr = "Sun,Mon,Tue,Wed,Thu,Fri,Sat";
			 String[] Wday = weekstr.split(",");
			 int Dmax = 0;
			 Calendar ca =  Calendar.getInstance();
             for (int n = 1; n<=Integer.parseInt(lastday[Integer.parseInt(Mon)]); n++)
			 {
                    if (Dmax<MyCount.getInt(n+1)) 	Dmax = MyCount.getInt(n+1);
					ca.set(Integer.parseInt(YearID),Integer.parseInt(Mon)-1,n);
					int intSday = ca.get(Calendar.DAY_OF_WEEK)-1;
					String Sday = "";
                    if (intSday == 0 || intSday == 6)
                          Sday = "<font color=red>" + Wday[intSday] + "</font>";
                    else
                          Sday = ""+Wday[intSday];
                   %>
    <td width="563" class="rcontent"><nobr><font class=small><%=Sday%></font></td>
    <%
             }
             %>
  </tr>
  <tr align=center valign=bottom> 
    <%
			 String Images = "";
             for (int n = 1;n<=Integer.parseInt(lastday[Integer.parseInt(Mon)]);n++)
			 {
                    int iDay = MyCount.getInt(n+1);
                    %>
    <td width="563" class="rcontent"><font class=small><nobr> 
      <%
                    if( iDay>0 )
						out.println(iDay);
                    %>
      </nobr></font><br>
      <%
                    if (iDay == Dmax)
                          Images = "vstath.gif" ;
                    else if (n == Integer.parseInt(NewDay))
                          Images = "vstatd.gif";
                    else if (n == Integer.parseInt(DayID))
                          Images = "vstatp.gif";
                    else
                          Images = "vstatt.gif";
                    int height = (int)iDay*300/Dmax;
                    %>
      <IMG Src="<%=ImageLink%>/theme/default/<%=Images%>" height="<%=height%>" width='10'></TD>
    <%
              }
              %>
  </TR>
  <TR align=center> 
    <%
              String strn = "";
              for (int n = 1; n<=Integer.parseInt(lastday[Integer.parseInt(Mon)]); n++)
			  {
					 strn = ""+n;
					 if (n<=9) strn = "" + n;
                     %>
    <TD width="563" class="rcontent"><a href="<%=ScriptName%>?mon=<%=MonID%>&day=<%=strn%>"><%=strn%></a></TD>
    <%
              }
        }
        MyCount.close();
       %>
  </TR>
</table>
<table class="p9" width="576" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr><td colspan=2 align=center>������ڿɲ鿴����ʱ�����ͳ��.���û��ѡ������.����ʾһ�����ڵ�����ʱ��ͳ��</td></tr>
        <tr class=info>
    <td colspan=2 align=right><font class=strong><%=YearID%> �� 
      <%=Mon%> �� 
      <%if (MyDay) out.println(DayID + "��");%>
      ʱ��ͳ��</font></td>
  </tr>
		 <%
        StrSQL="Select * From DayCount Where";
        if (MyDay)
              StrSQL = StrSQL + " ID = " + MonID + DayID;
        else
              StrSQL = StrSQL + " Left(ID,6) = " + MonID;
        MyCount = conn.executeQuery(StrSQL);
        // System.out.println(StrSQL);
        if (conn.getRows()==0)
            out.println("<tr class=rcontent><td colspan=2 align=center>û��ͳ������</TD></TR>");
        else
		{
            int d[] = new int[25];
			int dtotal = 0;
			int Tmax = 0;
			int TWidth = 0;
			String Images = "";
            while (MyCount.next())
			{
                for (int i = 1; i<=24; i++)
                    d[i] = MyCount.getInt(i+1) + d[i];
            }
            for (int x = 1; x<=24; x++)
			{
                 dtotal = d[x] + dtotal;
                 if (Tmax < d[x]) 	Tmax=d[x];
            }
			Calendar ca = Calendar.getInstance();

            for (int n = 1; n<=24; n++)
			{
     			  //ca.set(Integer.parseInt(YearID),Integer.parseInt(MonID),Integer.parseInt(DayID));
                  if (n-1 == ca.get(Calendar.HOUR_OF_DAY))
                        Images = "vstatb.gif" ;
                  else if (d[n] == Tmax)
                        Images = "vstatg.gif" ;
                  else
                        Images = "hstatt.gif";
                  TWidth = (int)350 * d[n]/Tmax;
				  %>
                  <tr class=rcontent>
    <td align=center> <%=Right("0" + (n-1),2)%>:00 ~ <%=Right("0" + n,2)%></TD>
    <TD>
                  <IMG src="<%=ImageLink%>/theme/default/<%=Images%>" height='10' width="<%=TWidth%>">
                  <%if (d[n]>0) out.println(d[n]);
                  out.println("(" + Percent(d[n],dtotal) + ")");%>
				  </TD></TR>
				  <%
            }
        }
        MyCount.close();
%>
        <tr class=info>
    <td colspan=2 align=right><font class="strong" color="#FFFFFF"><%=YearID%> 
      �� ��ͳ��</font></td>
  </tr>
<%
        StrSQL="Select * from YearCount Where ID = " + YearID;
        MyCount = conn.executeQuery(StrSQL);
		int Mmax = 0;
		int iMon = 0;
        if ( !MyCount.next())
             out.println("<tr class=rcontent><TD colspan=2 align=center>û��ͳ������</TD></TR>");
        else
		{
             int mtotal = 0;
			 String Images = "";
			 for (int i=1; i<=12; i++)
			 {
                 mtotal += MyCount.getInt(i+1);
                 if (Mmax < MyCount.getInt(i+1)) 	Mmax=MyCount.getInt(i+1);
             }
             for (int n = 1; n<=12; n++)
			 {
				 iMon = MyCount.getInt(n+1);
                 if (iMon>0)
				 {
                      if (n == Integer.parseInt(NewMonth))
                             Images = "vstatb.gif";
                      else if (n == Integer.parseInt(Mon))
                             Images = "vstatk.gif";
                      else if (iMon == Mmax)
                             Images = "vstatg.gif";
                      else
                             Images = "hstatt.gif";
                      int MWidth = (int)350*iMon/Mmax;
					  %>
                      <tr class=rcontent><td align=center>
                      <%if (iMon!=0)
                           out.println("<a href='" + ScriptName + "?mon=" + YearID + Right("0" + n,2) + "'>");
                      out.println(YearID + "-" + Right("0" + n,2) +" ~ " +  lastday[n] + "</a>");%>
					  </TD><TD>
                      <IMG src="<%=ImageLink%>/theme/default/<%=Images%>" height='10' width="<%=MWidth%>">
                      <%if (iMon > 0) 	out.println(iMon);%>
                      (<%=Percent(iMon,mtotal)%>)</TD></TR>
					  <%
                 }
			}
        }
		if (MyCount!=null) {
			MyCount.close();
			MyCount = null;
		}
        conn.close();
%>
</table>
<table width="576" border="0" class="p9" cellpadding="0" align="center">
  <tr>
    <td align="center" height="42"> 
      <%!
public String Percent(int St,int Sz)
{
       double Str = (double)St / Sz * 100;
       return cn.js.fan.util.StrUtil.FormatPrice(Str)+"%";
}
%>
      ��ֹ����: <%=LogDate%>, ͳ������: <%=DayTotal%>/<%=TotalDays%> ��, Ԥ�Ʊ��շ�����: <%=intending%> 
      �� </td>
  </tr>
</table>
     
<table cellspacing='0' cellpadding='3' width='576' border='0' align="center">
  <tr><td align=center><font class=footer>��֮��<br><img src='theme/default/hr_black.gif' height=2 width='60%'><br>
      Copyright &copy2000-2001 <A href='mailto:bestfeng@163.com'>����ͳ��ϵͳ</A>,All 
      Rights Reserved</font></td>
  </tr>
     <tr><td>
     </td></tr></table>
</body>
</html>