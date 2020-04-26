<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="cn.js.fan.db.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%!
int ToDay,Avera,DayMax,AllCount;
int CountSize = 6;         //计数不足在前面加零
boolean CountView = true;  //计数是否显示在页面上,False/True
boolean CountType = true;  //统计是记时间还是不记.True记，False不记
boolean CountMode = true;  //在页面上显示不计时的计数结果，还是显示计时的结果，默认为不计时（计时为：20分钟内不加数)
//==========================================================================
//计算两个日期之间相隔的天数
public int DateDiff(java.util.Date lowerLimitDate,java.util.Date upperLimitDate){
   long upperTime,lowerTime;
   upperTime=upperLimitDate.getTime();
   lowerTime=lowerLimitDate.getTime();
   if(upperTime<lowerTime)
	return -1;
   Long result=new Long((upperTime-lowerTime)/(1000*60*60*24));
   return result.intValue();
}

public void addinfo(String Name,String Info,boolean NewDays)
{
		boolean Found = false;
		ConnUpdate conn = null;
		ResultSet MyCount = null;
		Conn conn1 = new Conn(Global.defaultDB);
		try {
			conn = new ConnUpdate(Global.defaultDB);
			MyCount = conn.executeQuery( "Select "+Name+",count,todays,ID FROM " + Name);
			int id = 0;
			if (conn.getRows()>0)
			{
					  while(MyCount.next())
					  {
						  id = MyCount.getInt(4);  
						  if (NewDays)
						  {
								  if (MyCount.getString(Name).equals(Info))
								  {
										 // MyCount.updateInt(2,MyCount.getInt("count")+1);
										 // MyCount.updateInt(3,MyCount.getInt("todays")+1);
										 // MyCount.updateRow();
										 String sql = "update " + Name + " set count=count+1,todays=todays+1 where id=" + id;
										 conn1.executeUpdate(sql);
										 Found = true;
								  }
						  }
						  else
						  {
								  if (MyCount.getString(Name).equals(Info))
								  {
										 // MyCount.updateInt(2,MyCount.getInt("count")+1);
										 // MyCount.updateInt(3,1);
										 String sql = "update " + Name + " set count=count+1,todays=1 where id=" + id;
										 conn1.executeUpdate(sql);
										 Found = true;
								  }
								  else {
										 // MyCount.updateInt(3,0);
										 String sql = "update " + Name + " set todays=0 where id=" + id;
										 conn1.executeUpdate(sql);
								  }
								  // MyCount.updateRow();
						  }
					  }
			}
			if (!Found)
			{
				// System.out.print("not found+"+Name+"\n");
				/*
				MyCount.moveToInsertRow();
				MyCount.updateString(1,Info);
				MyCount.updateInt(2,1);
				MyCount.updateInt(3,1);
				MyCount.insertRow();
				*/
				String sql = "insert " + Name + " set "+Name+"="+cn.js.fan.util.StrUtil.sqlstr(Info)+",count=1,todays=1";
				conn1.executeUpdate(sql);				
			}
		}
		catch (Exception e)
		{
			System.out.println("addinfo:"+e.getMessage());
		}
		finally {
			if (MyCount!=null) {
				try { MyCount.close(); } catch (SQLException e) {}
				MyCount = null;
			}
			if (conn!=null) {
				conn.close();
				conn = null;
			}
			if (conn1!=null) {
				conn1.close();
				conn1 = null;
			}
		}
}
%>
<%
Conn conn = new Conn(Global.defaultDB);
String CountLink = request.getContextPath()+"/cms/counter/showcount.jsp"; //查看统计结果的连接。
String ImageLink = request.getContextPath()+"/cms/counter";              //图片地址

String NewYear,NewMonth,NewDay;
Calendar cal  = Calendar.getInstance();
NewYear = ""+(cal.get(cal.YEAR));
NewMonth = ""+(cal.get(cal.MONTH)+1);
NewDay = ""+cal.get(cal.DATE);

if (NewYear.length()<=2)	NewYear="20" + NewYear;
if (NewMonth.length()<=1)	NewMonth="0" + NewMonth;
if (Integer.parseInt(NewDay)<=9)				NewDay="0" + NewDay;
//===========================================================================  基本统计数据
ResultSet rs = null;
java.util.Date StartDate,LogDate=null;
int Avera,DayMax,AllCount,ToDay=0,TotalDays;
String sql = "";
try {
	sql = "Select count(*) from DayCount";
	rs = conn.executeQuery(sql);
	int DayTotal = 0;
	if (rs!=null && rs.next())
		DayTotal = rs.getInt(1);                             //获得统计总天数
	else
		DayTotal = 0;
	if (rs!=null) {
		rs.close();
		rs = null;
	}
	rs = conn.executeQuery("Select * from Count");
	if (rs!=null && rs.next())
	{
		StartDate = rs.getDate("StartDate");                                 //开始统计日期
		DayMax    = rs.getInt("DayMax");                                     //最高一天流量
		AllCount  = rs.getInt("AllCount");                                   //统计访问总数(使用的天数)
		ToDay     = rs.getInt("ToDayCount");                                 //今天访问流量
		LogDate   = rs.getDate("LogDate");                                   //统计截止日期
		TotalDays = DateDiff(StartDate,new java.util.Date())+1;      						//统计访问日期数(不管有没有使用，从开始统计算起.)
		Avera     = rs.getInt("AllCount") % TotalDays;                 		//日均访问流量
	}
}
catch (Exception e) {
	//e.printStackTrace();
}
finally {
	if (rs!=null) {
		try { rs.close(); } catch (SQLException e) {}
		rs = null;
	}
}

if (DateDiff(LogDate,new java.util.Date())>=1)	ToDay = 0;

//===========================================================================  预计一天访问量
//注意此处要防止除0，因为在夜里12点钟时cal.HOUR_OF_DAY是0
//int intending=(ToDay/(1+cal.get(cal.HOUR_OF_DAY)))*(24-cal.get(cal.HOUR_OF_DAY)-1)+ToDay;

//===================================================================
String DayDate = NewYear + NewMonth + NewDay;                      //20001818
String MonDate = NewYear + NewMonth;                               //200018
String YeaDate = NewYear;                                          //2000

//===================================================================
ResultSet MyCount = null;
String StrSQL = "";
try {
		//===================================================================
        int Dayn = cal.get(cal.DATE);
        StrSQL = "Select ID,monthcount."+Dayn+" FROM monthcount Where ID = " + MonDate;
        MyCount = conn.executeQuery(StrSQL);
		int MyCountDay = 0;
        if (!MyCount.next())
		{
				// MyCount.moveToInsertRow();
				// MyCount.updateInt(1,Integer.parseInt(MonDate));
				// MyCount.updateInt(""+Dayn,1);
				// MyCount.insertRow();
				StrSQL = "insert monthcount (ID, monthcount." + Dayn + ") values (" + MonDate + ",1)";
				conn.executeUpdate(StrSQL);
		}
        else
		{
			MyCountDay = MyCount.getInt(2);
            // MyCount.updateInt(2,MyCount.getInt(2)+1);
			// MyCount.updateRow();
			StrSQL = "update monthcount set monthcount." + Dayn + "=" + (MyCountDay+1) + " where ID=" + MonDate;
			conn.executeUpdate(StrSQL);
		}
	
		if (MyCount!=null) {
			try { MyCount.close(); } catch (Exception e) {}
			MyCount = null;
		}
		//===================================================================
		StrSQL = "Select AllCount,ToDayCount,DayMax,StartDate,LogDate FROM Count";
        MyCount = conn.executeQuery(StrSQL);
        if (!MyCount.next())
		{
		/*
                MyCount.moveToInsertRow();
				MyCount.updateInt(1,1);
				MyCount.updateInt(2,1);
				MyCount.updateInt(3,1);
				MyCount.updateDate(4,new java.sql.Date(cal.getTimeInMillis()));
				MyCount.updateDate(5,new java.sql.Date(cal.getTimeInMillis()));
				MyCount.insertRow();
		*/
				StrSQL = "insert Count (AllCount,ToDayCount,DayMax,StartDate,LogDate) values (1,1,1,NOW(),NOW())";
				conn.executeUpdate(StrSQL);
		}
        else
		{
		/*
                if (MyCount.getInt("DayMax") < MyCountDay)
                        MyCount.updateInt(3,MyCountDay);
                MyCount.updateInt(1,MyCount.getInt("AllCount")+1);
                MyCount.updateInt(2,MyCountDay);
				MyCount.updateDate(5,new java.sql.Date(cal.getTimeInMillis()));
				MyCount.updateRow();
		*/		
				int dayMax = MyCount.getInt("DayMax");
				if (dayMax < MyCountDay)
					dayMax = MyCountDay;
				StrSQL = "update Count set AllCount=AllCount+1,ToDayCount="+MyCountDay+",DayMax="+dayMax+",LogDate=NOW()";
				conn.executeUpdate(StrSQL);
        }
		if (MyCount!=null) {
			try { MyCount.close(); } catch (Exception e) {}
			MyCount = null;
		}

//===================================================================
        int Hourn = cal.get(cal.HOUR_OF_DAY);
		boolean ToDaysCount = false;
        StrSQL = "Select ID,DayCount."+Hourn+" FROM DayCount Where ID = " + DayDate;
        MyCount = conn.executeQuery(StrSQL);
        if (!MyCount.next())
		{
                /*
				MyCount.moveToInsertRow();
                MyCount.updateInt(1,Integer.parseInt(DayDate));
                MyCount.updateInt(2,1);
				MyCount.insertRow();
				*/
				StrSQL = "insert DayCount (ID, DayCount."+Hourn+") values ("+DayDate+",1)";
				conn.executeUpdate(StrSQL);
                ToDaysCount = false;
		}
        else
		{
                // MyCount.updateInt(2,MyCount.getInt(2)+1);
                // ToDaysCount    = true;
				// MyCount.updateRow();
				int dayCount = MyCount.getInt(2);
				StrSQL = "update DayCount set DayCount."+Hourn+"="+(dayCount+1) + " where ID="+DayDate;
				conn.executeUpdate(StrSQL);
        }
		if (MyCount!=null) {
			try { MyCount.close(); } catch (Exception e) {}
			MyCount = null;
		}

//===================================================================
        int Monn=cal.get(cal.MONTH)+1;
        StrSQL = "Select ID,"+Monn+" FROM YearCount where ID = " + YeaDate;

        MyCount = conn.executeQuery(StrSQL);
        if (!MyCount.next())
		{
                /*
				MyCount.moveToInsertRow();
                MyCount.updateInt(1,Integer.parseInt(YeaDate));
                MyCount.updateInt(2,1);
				MyCount.insertRow();
				*/
				StrSQL = "insert YearCount (ID,YearCount."+Monn+") values ("+YeaDate+",1)";
				conn.executeUpdate(StrSQL);
        }
		else
		{
				// MyCount.updateInt(2,MyCount.getInt(2)+1);
				// MyCount.updateRow();
				StrSQL = "update YearCount set YearCount."+Monn+"=YearCount."+Monn+"+1 where ID="+YeaDate;
				conn.executeUpdate(StrSQL);
        }
		if (MyCount!=null) {
			try { MyCount.close(); } catch (Exception e) {}
			MyCount = null;
		}

		String BC="",OS="";
		String[] Agt;
//===================================================================
        String aAgt = request.getHeader("User-Agent");
//===================================================================
        if (aAgt.indexOf("Mozilla")!=-1)
		{
                   if (aAgt.indexOf("MSIE")!=-1)
				   {
                         if (aAgt.indexOf("4.90")!=-1)
                             aAgt = aAgt.replaceAll("98","Me");
                         Agt = aAgt.split(";");
                         BC  = Agt[0].trim();
                         OS  = Agt[1].trim();
			       }
                   if (aAgt.indexOf("Opera")!=-1)
				   {
							   BC = "Opera" + aAgt.substring(aAgt.indexOf(")")+1);
							   OS = aAgt.substring(aAgt.indexOf(";")+2);
							   OS = OS.substring(0,OS.indexOf(";")+2);
							   OS = OS.substring(0,OS.indexOf(")"));
                   }
					else
					{
                           if (aAgt.indexOf("[en]")!=-1 || aAgt.indexOf("Gold")!=-1)
						   {
								 BC = aAgt.substring(aAgt.indexOf("/"));
								 BC = "Netscape" + " " + BC.substring(0,BC.indexOf(" "));
								 OS = aAgt.substring(aAgt.indexOf("(")+1);
								 OS = OS.substring(1,OS.indexOf(";")-1);
								 OS = OS.replaceAll("win","windows");
                           }
						   else
						   {
                                 BC = "Unknown";
                                 OS = "Unknown";
                           }
                   }
	    }
        else
		{
                 BC = "Unknown";
                 OS = "Unknown";
		}
        BC = BC.replaceAll("MSIE","Internet Explorer");
        OS = fchar.replace(OS,")","");
        OS = OS.replaceAll("NT 5.0","2000");
        OS = OS.replaceAll("4.10","98");
        OS = OS.replaceAll("4.90","Me");
//=========================================================
        addinfo("bc",BC,ToDaysCount);
        addinfo("os",OS,ToDaysCount);
//=========================================================
        String IPaddress = request.getRemoteAddr();
//=========================================================
		StrSQL = "Select bc,OS,IP,Date FROM lastly";
        MyCount = conn.executeQuery(StrSQL);
        if (conn.getRows()>20)
		{
                // MyCount.first();
                // MyCount.deleteRow();
				if (MyCount.next()) {
					String IP = MyCount.getString(3);
					String date = MyCount.getString(4);
					StrSQL = "delete from lastly where IP=" + fchar.sqlstr(IP) + " and date=" + fchar.sqlstr(date);
					conn.executeUpdate(StrSQL);
				}
        }
        // MyCount.moveToInsertRow();
        // MyCount.updateString(1,BC);
        // MyCount.updateString(2,OS);
		// MyCount.updateString(3,IPaddress);
        // MyCount.insertRow();
		StrSQL = "insert lastly (bc,OS,IP,Date) values("+fchar.sqlstr(BC)+","+fchar.sqlstr(OS)+","+fchar.sqlstr(IPaddress)+",NOW())";
		conn.executeUpdate(StrSQL);
		
		if (MyCount!=null) {
			try { MyCount.close(); } catch (Exception e) {}
			MyCount = null;
		}
		
	//Session("ASPCounter") = True
	//=========================================================
	String Counter = "";
	StrSQL = "Select PageCount,AllCount FROM Count";
	MyCount = conn.executeQuery(StrSQL);
	if (MyCount!=null && MyCount.next())
	{
		// MyCount.updateInt(1,MyCount.getInt(1)+1);
		// MyCount.updateRow();
		if (!CountMode)
			Counter = MyCount.getString("PageCount");
		else
			Counter = MyCount.getString("AllCount");
		StrSQL = "update Count set PageCount=PageCount+1";
		conn.executeUpdate(StrSQL);
	}

	if (CountView)
	{
			//=========================================================
			int CountLength=Counter.length();
			String Style = fchar.getNullString(request.getParameter("style"));
			//=========================================================
			String PicView="";
	
			if (CountLength < CountSize)
			{
				int CountToAdd = CountSize - CountLength;
				for (int i = 1; i<=CountToAdd; i++)
				{
					  if (!Style.equals(""))
						   PicView = PicView + "<IMG SRC=" + ImageLink + "/" + Style + "/0.gif border=0>";
					  else
						   PicView = PicView + "0";
				}
			}
	
			for (int i = 0; i<CountLength; i++)
			{
				 if (!Style.equals(""))
					  PicView = PicView + "<IMG SRC=" + ImageLink + "/" + Style + "/" + Counter.substring(i,i+1) + ".gif border=0>";
				 else
					  PicView = PicView + "" + Counter.substring(i,i+1) + "";
			}
			out.println("document.write('<NOBR><a href=" + CountLink + " title=?? target=_blank>" + PicView + "</A></NOBR>');");
	}
}
catch (Exception e) {
	out.print(e.getMessage() + "<BR>" + StrSQL);
    e.printStackTrace();
}
finally {
	if (MyCount!=null) {
		try { MyCount.close(); } catch (SQLException e) {}
		MyCount = null;
	}
}
if (conn!=null) {
	conn.close();
	conn = null;
}
%>
