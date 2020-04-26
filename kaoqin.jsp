<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.util.Calendar"%>
<%@ page import = "java.util.Date"%>
<%@ page import = "com.redmoon.oa.kaoqin.*"%>
<%@ page import = "cn.js.fan.util.StrUtil"%>
<%@ page import = "cn.js.fan.util.ParamUtil"%>
<%@ page import = "cn.js.fan.util.ErrMsgException"%>
<%@ page import = "cn.js.fan.util.DateUtil"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ include file="inc/inc.jsp"%>
<%@ page import="java.text.*"%>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>考勤</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language=javascript>
<!--
function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=50,left=120,width="+width+",height="+height);
}
//-->
</script>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="cfgparser" scope="page" class="cn.js.fan.util.CFGParser"/>
<%
if (!privilege.isUserLogin(request))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<%!
  int daysInMonth[] = {
      31, 28, 31, 30, 31, 30, 31, 31,
      30, 31, 30, 31};

  public int getDays(int month, int year) {
    //测试选择的年份是否是润年？
    if (1 == month)
      return ( (0 == year % 4) && (0 != (year % 100))) ||
          (0 == year % 400) ? 29 : 28;
        else
      return daysInMonth[month];
  }
%>
<%
// 翻月
int showyear,showmonth;
Calendar cal = Calendar.getInstance();
int curday = cal.get(cal.DAY_OF_MONTH);
int curhour = cal.get(cal.HOUR_OF_DAY);
int curminute = cal.get(cal.MINUTE);
int curmonth = cal.get(cal.MONTH);
int curyear = cal.get(cal.YEAR);

String strshowyear = request.getParameter("showyear");
String strshowmonth = request.getParameter("showmonth");
if (strshowyear!=null)
	showyear = Integer.parseInt(strshowyear);
else
	showyear = cal.get(cal.YEAR);
if (strshowmonth!=null)
	showmonth = Integer.parseInt(strshowmonth);
else
	showmonth = cal.get(cal.MONTH)+1;
		
cfgparser.parse("config_oa.xml");
Properties props = cfgparser.getProps();
String mbeginp = props.getProperty("morningbegin");
String mendp = props.getProperty("morningend");
String abeginp = props.getProperty("afternoonbegin");
String aendp = props.getProperty("afternoonend");
String[] strmbegin = mbeginp.split(":");
String[] strmend = mendp.split(":");
String[] strabegin = abeginp.split(":");
String[] straend = aendp.split(":");

int latevalue = Integer.parseInt(props.getProperty("latevalue"));
int[] mbegin = new int[2]; // 上午上班开始时间，0为小时，1为分钟
int[] mend = new int[2];
int[] abegin = new int[2];
int[] aend = new int[2];
for (int k=0; k<2; k++) {
	mbegin[k] = Integer.parseInt(strmbegin[k]);
	mend[k] = Integer.parseInt(strmend[k]);
	abegin[k] = Integer.parseInt(strabegin[k]);
	aend[k] = Integer.parseInt(straend[k]);
}
%>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr>
    <td width="100%" height="23" class="right-title"><span>&nbsp;<%=showmonth%>月 考 勤 表 &nbsp;&nbsp;上午<%=mbeginp%>-<%=mendp%> 下午<%=abeginp%>-<%=aendp%> 迟到或早退为相差 <%=latevalue%>分钟</span></td>
  </tr>
  <tr>
    <td valign="top">
<%
String op = ParamUtil.get(request, "op");
if (op.equals("add"))
{
	boolean re = false;
	try {
		KaoqinMgr km = new KaoqinMgr();
		re = km.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("操作成功！"));
}
%>
<table width="98%" border="0" align="center">
        <tr>
          <td align="center">&nbsp;</td>
        </tr>
        <tr> 
          <td align="center">
<select name="showyear" onChange="var y = this.options[this.selectedIndex].value; window.location.href='?showyear=' + y;">
		  <%for (int y=curyear-60; y<=curyear; y++) {%>
		  <option value="<%=y%>"><%=y%></option>
		  <%}%>
		  </select>
		  <script>
		  showyear.value = "<%=showyear%>";
		  </script>		  
<%
for (int i=1; i<=12; i++) {
	if (showmonth==i)
		out.print("<a href='kaoqin.jsp?showyear="+showyear+"&showmonth="+i+"'><font color=red>"+i+"月</font></a>&nbsp;");
	else
		out.print("<a href='kaoqin.jsp?showyear="+showyear+"&showmonth="+i+"'>"+i+"月</a>&nbsp;");
}
%> </td>
        </tr>
        <tr> 
          <td align="center"> <a href="kaoqin.jsp?showyear=<%=showyear%>&showmonth=<%=showmonth%>">全部</a> 
            <a href="kaoqin.jsp?showtype=<%=StrUtil.UrlEncode("考勤")%>&showyear=<%=showyear%>&showmonth=<%=showmonth%>">考勤</a> 
            <a href="kaoqin.jsp?showtype=<%=StrUtil.UrlEncode("外出办事")%>&showyear=<%=showyear%>&showmonth=<%=showmonth%>">外出办事</a> 
            <a href="kaoqin.jsp?showtype=<%=StrUtil.UrlEncode("加班")%>&showyear=<%=showyear%>&showmonth=<%=showmonth%>">加班</a> 
            <a href="kaoqin.jsp?showtype=<%=StrUtil.UrlEncode("其他原因")%>&showyear=<%=showyear%>&showmonth=<%=showmonth%>">其他原因</a> 
          </td>
        </tr>
      </table>
<%
String sql;
// 获取本月考勤
String showtype = ParamUtil.get(request, "showtype");
if (showtype.equals(""))
	sql = "select id from kaoqin where name="+fchar.sqlstr(privilege.getUser(request))+" and MONTH(myDate)="+showmonth+" and YEAR(myDate)="+showyear+" order by mydate asc";
else
	sql = "select id from kaoqin where name="+fchar.sqlstr(privilege.getUser(request))+" and MONTH(myDate)="+showmonth+" and YEAR(myDate)="+showyear+" and type="+fchar.sqlstr(showtype)+" order by mydate asc";
int i = 1;
String direction="",type="",reason="",mydate="",strweekday="";
int id;
int weekday=0;
Date dt = null;
int monthday = 0;
int monthdaycount = getDays(showmonth-1,showyear);//当前显示月份的天数
String[] wday = {"","日","一","二","三","四","五","六"};

boolean coloralt = true;//背景颜色交替
String backcolor = "#ffffff";
int myhour = 0;	//用于计算迟到时间
int myminute = 0;
int latecount = 0;//迟到次数
int beforecount = 0; //早退次数
int latehour = 0;
int lateminute = 0;
Calendar cld = Calendar.getInstance();

KaoqinDb kd = new KaoqinDb();
Vector v = kd.list(sql);
Iterator ir = v.iterator();
%>
      <br>
      <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr align="center" bgcolor="#C4DAFF"> 
          <td width="8%" class="stable"> <div align="center">星期</div></td>
          <td width="13%" class="stable">日期</td>
          <td width="13%" class="stable">时间</td>
          <td width="19%" bgcolor="#C4DAFF" class="stable">去向</td>
          <td width="18%" class="stable">类型</td>
          <td width="29%" class="stable">事由</td>
        </tr>
      </table>
      <%
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
 		if (ir.hasNext()) {
			kd = (KaoqinDb)ir.next();
			mydate = DateUtil.format(kd.getMyDate(), "yyyy-MM-dd HH:mm:ss");
			//dt = rs.getDate("mydate");//这样取的话会丢失小时和分钟信息
			dt = kd.getMyDate();
			cld.setTime(dt);
			monthday = cld.get(cld.DAY_OF_MONTH);
		}
		while (i<=monthdaycount)
		{
			if (monthday==i)
			{
				coloralt = !coloralt;
				if (coloralt)
					backcolor = "#eeeeee";
				else
					backcolor = "#ECFFDF";
				String oldbackcolor = backcolor;
				
				while (monthday==i) {
					backcolor = oldbackcolor;
					id = kd.getId();
					direction = kd.getDirection();
					type = kd.getType();
					reason = kd.getReason();
					
					mydate = DateUtil.format(kd.getMyDate(), "yyyy-MM-dd HH:mm:ss");
					dt = formatter.parse(mydate);
					cld.setTime(dt);
					
					mydate = mydate.substring(11,19);
					weekday = cld.get(cld.DAY_OF_WEEK);
					strweekday = wday[weekday];
					// 计算是否迟到
					myhour = cld.get(cld.HOUR_OF_DAY);
					myminute = cld.get(cld.MINUTE);
					if (type.equals("考勤"))
					{
						int hbeginf,mbeginf,hendf,mendf;
						if (myhour<13) //上午
						{
							hbeginf = mbegin[0];
							mbeginf = mbegin[1];
							hendf = mend[0];
							mendf = mend[1];
						}
						else
						{
							hbeginf = abegin[0];
							mbeginf = abegin[1];
							hendf = aend[0];
							mendf = aend[1];
						}
							
						if (direction.equals("c"))
						{
							latehour = myhour-hbeginf;
							lateminute = myminute-mbeginf;
							if (lateminute>0) //计算本次迟到的分钟数
								lateminute = latehour*60+lateminute;
							else
								lateminute = latehour*60+lateminute;
							//System.out.println("hbeginf="+hbeginf);
							//System.out.println("myhour="+myhour);
							//System.out.println("myminute="+myminute);
							//System.out.println("mbeginf="+mbeginf);
							//System.out.println("lateminute="+lateminute);
							if (lateminute>latevalue)//如果大于阀值则认为是迟到
							{
								backcolor = "#FFCECA";
								latecount++;
							}
						}
						else
						{
							latehour = hendf-myhour;
							lateminute = mendf-myminute;
							if (lateminute>0) //计算本次迟到的分钟数
								lateminute = latehour*60+lateminute;
							else
								lateminute = latehour*60+lateminute;
							if (lateminute>latevalue)//如果大于阀值则认为是早退
							{
								backcolor = "#ffff00";
								beforecount++;
							}
						}
					}

					if (direction.equals("c"))
						direction = "到达单位";
					else
						direction = "离开单位";
				%>
					  <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr align="center" bgcolor="<%=backcolor%>"> 
          <td width="8%" bgcolor="<%=backcolor%>" class="stable"><%=strweekday%> </td>
          <td width="13%" bgcolor="<%=backcolor%>" class="stable"><%=i%></td>
          <td width="13%" bgcolor="<%=backcolor%>" class="stable"><%=mydate%></td>
          <td width="19%" bgcolor="<%=backcolor%>" class="stable"><%=direction%></td>
          <td width="18%" bgcolor="<%=backcolor%>" class="stable"><%=type%></td>
          <td width="29%" bgcolor="<%=backcolor%>" class="stable"><%=reason%></td>
        </tr>
      </table>
				<%
					if (ir.hasNext()) {
						kd = (KaoqinDb)ir.next();
						dt = kd.getMyDate();
						cld.setTime(dt);
						monthday = cld.get(cld.DAY_OF_MONTH);
						
					}
					else {
						break;
					}
				 }
			}
			else
			{
				cld.set(showyear,showmonth-1,i);
				weekday = cld.get(cld.DAY_OF_WEEK);
				strweekday = wday[weekday];
				if (weekday==1 || weekday==7)
					strweekday = "<font color=red>"+strweekday+"</font>";				
				%>
				  <table width="98%" border="0" align="center" cellpadding="2" cellspacing="0" class="stable">
        <tr align="center"> 
          <td width="8%" class="stable"><%=strweekday%></td>
          <td width="13%" class="stable"><%=i%></td>
          <td width="13%" class="stable">&nbsp;</td>
          <td width="19%" class="stable">&nbsp;</td>
          <td width="18%" class="stable">&nbsp;</td>
          <td width="29%" class="stable">&nbsp;</td>
        </tr>
      </table>
				<%
			}
			i++;
		}%>
		<br>
      <table width="98%" border="0" align="center">
        <tr>
          <td align="center">迟到次数：<%=latecount%>&nbsp;&nbsp;&nbsp;早退次数：<%=beforecount%></td>
  </tr>
</table>
<%
	if (curyear==showyear && (curmonth+1)==showmonth)
	{
%>
      <table width="448" border="0" align="center" cellpadding="0" cellspacing="0" class="stable">
        <tr bgcolor="#C4DAFF">
          <td height="21" colspan="4" align="center" bgcolor="#C4DAFF" class="stable">考&nbsp;勤</td>
        </tr>
        <form name="form1" action="?op=add" method="post" onSubmit="">
          <tr bgcolor="#EEEEEE">
            <td width="54" height="19" align="center" class="stable">类型</td>
            <td width="152" height="19" class="stable"> 
			<select name="type">
			<%
			// 如果已过了考勤时间段（该时间段为上午前后1小时和下午前后1小时），则不显示考勤
			int curm = curhour*60+curminute;//当前时间在本日中的分钟数
			int fz = 60;//阀值为60分钟
			if ((curm>mbegin[0]*60+mbegin[1]-fz && curm<mend[0]*60+mend[1]+fz) ||
					(curm>abegin[0]*60+abegin[1]-fz && curm<aend[0]*60+aend[1]+fz))
			{
			%>
                <option value="考勤" checked>考勤</option>
			<% } %>
                <option value="外出办事">外出办事</option>
				<option value="加班">加班</option>
                <option value="其他原因">其他原因</option>
            </select> </td>
            <td width="95" align="center" class="stable">去向</td>
            <td width="145" class="stable"> <select name="direction">
                <option value="c" checked>来到单位</option>
                <option value="l">离开单位</option>
            </select></td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td height="17" align="center" class="stable">事由</td>
            <td height="17" colspan="3" class="stable"> <textarea name=reason cols="50" class="singleboarder" rows="8"></textarea>            </td>
          </tr>
          <tr bgcolor="#EEEEEE">
            <td colspan="4" align="center" class="stable"> <input name="submit" type=submit class="singleboarder" value="发送">
              &nbsp;&nbsp;&nbsp; <input name="reset" type=reset class="singleboarder" value="取消">            </td>
          </tr>
        </form>
      </table> 
		  <%
	}
	%>
    </td>
  </tr>
  <tr>
    <td height="9">&nbsp;</td>
  </tr>
</table>
</body>
</html>
