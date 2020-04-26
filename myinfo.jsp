<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="org.jdom.Element"%>
<%@ page import ="com.redmoon.forum.*"%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<%
String skincode = UserSet.getSkin(request);
if (skincode.equals(""))
	skincode = UserSet.defaultSkin;
SkinMgr skm = new SkinMgr();
Skin skin = skm.getSkin(skincode);
if (skin==null)
	skin = skm.getSkin(UserSet.defaultSkin);
String skinPath = skin.getPath();
%>
<html>
<head>
<title><lt:Label res="res.label.myinfo" key="myinfo"/> - <%=Global.AppName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<script>
function New(para_URL){var URL=new String(para_URL);window.open(URL,'','resizable,scrollbars')}
function CheckRegName(){
	var Name=document.frmAnnounce.RegName.value;
	window.open("checkregname.jsp?RegName="+Name,"","width=200,height=20");
}

function check_checkbox(myitem,myvalue)
{
     var checkboxs = document.all.item(myitem);
     if (checkboxs!=null)
     {
       for (i=0; i<checkboxs.length; i++)
          {
            if (checkboxs[i].type=="checkbox" && checkboxs[i].value==myvalue)
              {
                 checkboxs[i].checked = true
              }
          }
     }
}
</script>
<script src="forum/inc/ubbcode.jsp"></script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<jsp:useBean id="userservice" scope="page" class="com.redmoon.forum.person.userservice" />
<%
if (!privilege.isUserLogin(request)) {
	response.sendRedirect("door.jsp");
	return;
}
%>
<div id="newdiv" name="newdiv">
<%
String privurl = request.getRequestURL()+"?"+request.getQueryString();
%>
<%
String RegName="",Question="",Answer="";
String RealName="",Career="";
String Gender="",Job="";
int BirthYear = 0;
int BirthMonth = 0;
int BirthDay = 0;
Date Birthday = null;
String Phone="",Mobile="";
int Marriage = 0;
String State="",City="",Address="";
String PostCode="",IDCard="",RealPic="",sign="";
String Email="",OICQ="";
String Hobbies="",myface="";
String name = privilege.getUser(request);
int myfacewidth=120,myfaceheight=150;
UserDb user = new UserDb();
user = user.getUser(name);

		RegName = user.getNick();
		Question = user.getQuestion();
		Answer = user.getAnswer();
		RealName = user.getRealName();
		Career = user.getCareer();
		Gender = user.getGender();
		Job = user.getJob();
		Birthday = user.getBirthday();
		if (Birthday!=null) {
			Calendar cld = Calendar.getInstance();
			cld.setTime(Birthday);
			BirthYear = cld.get(Calendar.YEAR);
			BirthMonth = cld.get(Calendar.MONTH)+1;
			BirthDay = cld.get(Calendar.DAY_OF_MONTH);
			
			//BirthYear = Birthday.getYear()+1900;
			//BirthMonth = Birthday.getMonth()+1;
			//BirthDay = Birthday.getDate();
		}
		Marriage = user.getMarriage();
		Phone = user.getPhone();
		Mobile = user.getMobile();
		State = user.getState();
		City = user.getCity();
		Address = user.getAddress();
		PostCode = user.getPostCode();
		IDCard = user.getIDCard();
		RealPic = user.getRealPic();
		Hobbies = user.getHobbies();
		Email = user.getEmail();
		OICQ = user.getOicq();
		sign = user.getSign();
		myface = user.getMyface();
		myfacewidth = user.getMyfaceWidth();
		myfaceheight = user.getMyfaceHeight();
%>
<table width=98% border=0 align=center cellpadding=0 cellspacing=0 bgcolor="#CCCCCC" >
 <form method="POST" action="myinfo_do.jsp"  name="frmAnnounce" onSubmit="return VerifyInput()">
 <tr>
      <td> <table width=100% border=0 cellpadding=0 cellspacing=1>
          <tr>
            <td colspan="4" align=center bgcolor="#FFFFFF"><table border=0 cellpadding=0 cellspacing=0 width=100%>
              <tr class="td_title">
                <td width=22 height=20 background="forum/<%=skinPath%>/images/bg1.gif">&nbsp;</td>
                <td width=140><b>
                  <lt:Label res="res.label.regist" key="nick_pwd"/>
                </b></td>
                <td width="776" height="26" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title"><lt:Label res="res.label.regist" key="notice"/></td>
              </tr>
            </table></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td width="14%" height="28" align="left" bgcolor="#FFFFFF" >&nbsp;
              <lt:Label res="res.label.forum.user" key="RegName"/></td>
            <td height="22" colspan="3" align="left" valign="middle" bgcolor="#FFFFFF" >&nbsp;&nbsp;<%=RegName%>
            <input type="hidden" name="RegName" size="20" value="<%=name%>" /></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" bgcolor="#FFFFFF">&nbsp;
              <lt:Label res="res.label.forum.user" key="Password"/></td>
            <td height="22" colspan="3" align="left" bgcolor="#FFFFFF">&nbsp;
                <input name="Password" type="password"  size="20" maxlength="20" />
                <font color="#FF0000">*</font>
                <lt:Label res="res.label.forum.user" key="Password2"/>
                &nbsp;
              <input name="Password2" type="password"  size="20" maxlength="20" />
                <font color="#FF0000"> *&nbsp;</font><font color=red><lt:Label res="res.label.myinfo" key="not_fill_not_change_pwd"/></font></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Gender"/></td>
            <td height="22" colspan="3" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;
              <input type=radio name=Gender value=M <%=Gender.equals("M")?"checked":""%>>
              <lt:Label res="res.label.forum.user" key="man"/>
              <input type=radio name=Gender value=F <%=Gender.equals("F")?"checked":""%>>
              <lt:Label res="res.label.forum.user" key="woman"/></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;&nbsp;Email</td>
            <td height="22" colspan="3" align="left" valign="middle" bgcolor="#FFFFFF">&nbsp;
                <input name="Email" type="text"  value="<%=Email%>" size="20" maxlength="50" />
                <font color="#FF0000">*</font> </td>
          </tr> 
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" bgcolor="#FFFFFF" >&nbsp;
            <lt:Label res="res.label.forum.user" key="Question"/></td>
            <td height="22" colspan="3" align="left" bgcolor="#FFFFFF" >&nbsp;
              <input name="Question" type="text"  value="<%=Question%>" size="20" maxlength="50" />
              <lt:Label res="res.label.forum.user" key="Answer"/>                &nbsp;&nbsp;
                <input name="Answer" type="text"  value="<%=Answer%>" size="20" maxlength="50" /></td>
          </tr>

          <tr>
            <td colspan="4" align=center bgcolor="#FFFFFF"><table width=100% border=0 cellpadding=0 cellspacing=0>
              <tr>
                <td width=22 height=20 background="forum/<%=skinPath%>/images/bg1.gif">&nbsp;</td>
                <td height="26" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title"><%
				  String checked = "";
				  if (user.isSecret()) {
				  	checked = "checked";
				  }
				  %>
                    <input name="isSecret" value="true" <%=checked%> type="checkbox">
                    <lt:Label res="res.label.forum.user" key="secret"/>                  </td>
                </tr>
            </table></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align="left" height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="RealName"/></td>
            <td width="25%" height="28" valign="middle"  bgcolor="#FFFFFF">&nbsp;
            <input name=RealName type=text  value="<%=RealName%>" size=12 maxlength=20></td>
            <td width="22%" height="28" align="left"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Career"/></td>
            <td width="39%" height="28" align="left"  bgcolor="#FFFFFF">&nbsp;
                <select name=Career size=1>
                      <option value="0" selected><lt:Label res="res.label.forum.user" key="select"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="government"/>"><lt:Label res="res.label.forum.user" key="government"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="student"/>"><lt:Label res="res.label.forum.user" key="student"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="communication"/>"><lt:Label res="res.label.forum.user" key="communication"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="computer"/>"><lt:Label res="res.label.forum.user" key="computer"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="web"/>"><lt:Label res="res.label.forum.user" key="web"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="trade"/>"><lt:Label res="res.label.forum.user" key="trade"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="bank"/>"><lt:Label res="res.label.forum.user" key="bank"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="tax"/>"><lt:Label res="res.label.forum.user" key="tax"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="refer"/>"><lt:Label res="res.label.forum.user" key="refer"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="service"/>"><lt:Label res="res.label.forum.user" key="service"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="tour"/>"><lt:Label res="res.label.forum.user" key="tour"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="health"/>"><lt:Label res="res.label.forum.user" key="health"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="realty"/>"><lt:Label res="res.label.forum.user" key="realty"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="transport"/>"><lt:Label res="res.label.forum.user" key="transport"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="law"/>"><lt:Label res="res.label.forum.user" key="law"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="culture"/>"><lt:Label res="res.label.forum.user" key="culture"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="ad"/>"><lt:Label res="res.label.forum.user" key="ad"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="education"/>"><lt:Label res="res.label.forum.user" key="education"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="agriculture"/>"><lt:Label res="res.label.forum.user" key="agriculture"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="manufacturing"/>"><lt:Label res="res.label.forum.user" key="manufacturing"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="soho"/>"><lt:Label res="res.label.forum.user" key="soho"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="other"/>"><lt:Label res="res.label.forum.user" key="other"/></option>
                    </select>
				<script language="JavaScript">
					<!--
					frmAnnounce.Career.value="<%=Career%>"
					//-->
				</script>            </td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Mobile"/></td>
            <td height="28" bgcolor="#FFFFFF"><span class="l15"> &nbsp;
              <input name=Mobile type=text  value="<%=Mobile%>" size=16 maxlength="16">
            </span></td>
            <td height="28" bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Job"/></td>
            <td height="28" bgcolor="#FFFFFF" class="l15">&nbsp;
                <select name=Job size=1>
                      <option value="0" selected><lt:Label res="res.label.forum.user" key="select"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="staffer"/>"><lt:Label res="res.label.forum.user" key="staffer"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="engineer"/>"><lt:Label res="res.label.forum.user" key="engineer"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="ceo"/>"><lt:Label res="res.label.forum.user" key="ceo"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="market_manager"/>"><lt:Label res="res.label.forum.user" key="market_manager"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="administration_manager"/>"><lt:Label res="res.label.forum.user" key="administration_manager"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="person_manager"/>"><lt:Label res="res.label.forum.user" key="person_manager"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="finance_manager"/>"><lt:Label res="res.label.forum.user" key="finance_manager"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="technology_manager"/>"><lt:Label res="res.label.forum.user" key="technology_manager"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="retire"/>"><lt:Label res="res.label.forum.user" key="retire"/></option>
                      <option value="<lt:Label res="res.label.forum.user" key="other"/>"><lt:Label res="res.label.forum.user" key="other"/></option>
                  </select>           
				  <script>
				  frmAnnounce.Job.value = "<%=Job%>"
				  </script> </td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" bgcolor="#FFFFFF" >&nbsp;
            <lt:Label res="res.label.forum.user" key="birthday"/></td>
            <td height="28" bgcolor="#FFFFFF">&nbsp;
              <input name=BirthYear type=text  value="<%=BirthYear%>" size=5>
              年 
              <input name=BirthMonth type=text  value="<%=BirthMonth%>" size=2>
              月 
              <input name=BirthDay type=text  value="<%=BirthDay%>" size=2>
            日</td><td height="28" bgcolor="#FFFFFF" align="left">&nbsp;
              <lt:Label res="res.label.forum.user" key="marry_status"/></td>
            <td height="28" bgcolor="#FFFFFF" class="l15">&nbsp;
                <select name=Marriage size=1>
                      <option value="0" selected><lt:Label res="res.label.forum.user" key="marry_not"/></option>
                      <option value="2"><lt:Label res="res.label.forum.user" key="marry_not_know"/></option>
                      <option value="1"><lt:Label res="res.label.forum.user" key="marry_yes"/></option>
                  </select>   
				   <script language="JavaScript">
					<!--
					frmAnnounce.Marriage.value="<%=Marriage%>";
					//-->
					</script>		            *</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align="left" bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="phone"/></td>
            <td height="28" bgcolor="#FFFFFF" valign="middle">&nbsp;
            <input name=Phone type=text  value="<%=Phone%>" size=16 maxlength="20"></td>
            <td height="28" bgcolor="#FFFFFF">&nbsp;QQ</td>
            <td height="28" bgcolor="#FFFFFF" class="l15">&nbsp;
            <input name=OICQ type=text  value="<%=OICQ%>" size=16 maxlength="15">
            *</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="28" align=left bgcolor="#FFFFFF"><img src=/images/c.gif width=1 height=5>&nbsp;
            <lt:Label res="res.label.forum.user" key="State"/></td>
            <td valign="middle" height="28"  bgcolor="#FFFFFF" >&nbsp;
              <input name=State size=10 maxlength="30" value="<%=State%>">            </td>
            <td colspan="2" rowspan="6" align="left" valign="middle" bgcolor="#FFFFFF"><table width="98%"  border="0">
              <tr>
                <td align="left"><font color="#FF0000"><b><font color="#000000"></font></b> <img src="forum/images/face/<%=RealPic%>" name="tus">&nbsp;
                      <script>function showimage(){document.images.tus.src="forum/images/face/"+document.frmAnnounce.RealPic.options[document.frmAnnounce.RealPic.selectedIndex].value;}</script>
<%
 String path = Global.getRootPath() + "/forum/images/face/";
 FaceFileViewer fileViewer = new FaceFileViewer(application.getRealPath("/") + "/forum/images/face/");
 fileViewer.init();
 int i = 1;
%>
                      <select name=RealPic size=1 onChange="showimage()">
                        <option value="face.gif"><lt:Label res="res.label.forum.user" key="default_icon"/></option>
                           <% while(fileViewer.nextFile()){
							  if (fileViewer.getFileName().lastIndexOf("gif") != -1 || fileViewer.getFileName().lastIndexOf("jpg") != -1 || fileViewer.getFileName().lastIndexOf("png") != -1 || fileViewer.getFileName().lastIndexOf("bmp") != -1 && fileViewer.getFileName().indexOf("face") != -1) {
							   String fileName = fileViewer.getFileName();
							%>
                            <option value="<%=fileName%>"><%=i++%></option>
                            <% }
							} %>
                      </select>                    <a href="JavaScript:New('images/index.jsp')"><lt:Label res="res.label.forum.user" key="view_all_icon"/></a>					</font>
				  <script language="JavaScript">
						  <!--
						  frmAnnounce.RealPic.value = "<%=RealPic%>"
						  //-->
						  </script>					</td>
                <td width="31%" rowspan="2" valign="top"><font color="#FF0000">
                  <%if (!myface.equals("")) {%>
                  <img src="images/myface/<%=myface%>" width=<%=myfacewidth%> height=<%=myfaceheight%>>
                  <%}%>
                </font></td>
              </tr>
              <tr>
                <td><iframe src="addmyface.jsp" width=100% height="95" frameborder="0" scrolling="no"></iframe>                  </td>
                </tr>
            </table></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="City"/></td>
            <td height="28" valign="middle" bgcolor="#FFFFFF">&nbsp;
            <input name=City type=text  value="<%=City%>" size=10></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Address"/></td>
            <td height="28" valign="middle" bgcolor="#FFFFFF">&nbsp;
            <input name=Address type=text  value="<%=Address%>" size=30 maxlength="100"></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="PostCode"/></td>
            <td height="28" valign="middle" bgcolor="#FFFFFF">&nbsp;
                <input name=PostCode type=text  value="<%=PostCode%>" size=10 maxlength="30"></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="IDCard"/></td>
            <td height="28" bgcolor="#FFFFFF" valign="middle">&nbsp;
                <input name=IDCard type=text  value="<%=IDCard%>" size=21></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="37"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="Hobbies"/></td>
            <td bgcolor="#FFFFFF" valign="middle">&nbsp;
                <input name=Hobbies type=text value="<%=Hobbies%>" size=30 maxlength="50"></td></tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="37"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="home"/></td>
            <td colspan="3" valign="middle"  bgcolor="#FFFFFF">&nbsp;
                <input name=home type=text value="<%=user.getHome()%>" size=30 maxlength="50"></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="37"  bgcolor="#FFFFFF">&nbsp;&nbsp;MSN</td>
            <td colspan="3" valign="middle"  bgcolor="#FFFFFF">&nbsp;
            <input name=msn type=text value="<%=user.getMsn()%>" size=30 maxlength="50"></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
              <lt:Label res="res.label.forum.user" key="locale"/></td>
            <td height="29" colspan="3" valign="middle" bgcolor="#FFFFFF">&nbsp;
              <select name=locale size=1>
              <option value="" selected>
                <lt:Label res="res.label.forum.user" key="locale_default"/>
                </option>
<%
            XMLConfig xc = new XMLConfig("config_i18n.xml", false, "utf-8");
            Element root = xc.getRootElement();
            Element child = root.getChild("support");
            List list = child.getChildren();
            if (list != null) {
                Iterator ir = list.iterator();
                while (ir.hasNext()) {
                    Element e = (Element) ir.next();
					String loc = e.getChildText("lang") + "_" + e.getChildText("country");
                    out.print("<option value=" + loc + ">" + SkinUtil.LoadString(request, "res.config.config_i18n", loc) + "</option>");
                }
            }
%>				
            </select>
			<script>
			frmAnnounce.locale.value = "<%=user.getLocale()%>";
			</script>
			</td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td align=left height="28"  bgcolor="#FFFFFF">&nbsp;
            <lt:Label res="res.label.forum.user" key="timeZone"/></td>
            <td height="29" colspan="3" valign="middle" bgcolor="#FFFFFF">&nbsp;
              <select name="timeZone">
  <option value="GMT-11:00">(GMT-11.00)
  <lt:Label res="res.label.cms.config" key="GMT-11.00"/>
  </option>
  <option value="GMT-10:00">(GMT-10.00)
  <lt:Label res="res.label.cms.config" key="GMT-10.00"/>
  </option>
  <option value="GMT-09:00">(GMT-9.00)
  <lt:Label res="res.label.cms.config" key="GMT-9.00"/>
  </option>
  <option value="GMT-08:00">(GMT-8.00)
  <lt:Label res="res.label.cms.config" key="GMT-8.00"/>
  </option>
  <option value="GMT-07:00">(GMT-7.00)
  <lt:Label res="res.label.cms.config" key="GMT-7.00"/>
  </option>
  <option value="GMT-06:00">(GMT-6.00)
  <lt:Label res="res.label.cms.config" key="GMT-6.00"/>
  </option>
  <option value="GMT-05:00">(GMT-5.00)
  <lt:Label res="res.label.cms.config" key="GMT-5.00"/>
  </option>
  <option value="GMT-04:00">(GMT-4.00)
  <lt:Label res="res.label.cms.config" key="GMT-4.00"/>
  </option>
  <option value="GMT-03:00">(GMT-3.00)
  <lt:Label res="res.label.cms.config" key="GMT-3.00"/>
  </option>
  <option value="GMT-02:00">(GMT-2.00)
  <lt:Label res="res.label.cms.config" key="GMT-2.00"/>
  </option>
  <option value="GMT-01:00">(GMT-1.00)
  <lt:Label res="res.label.cms.config" key="GMT-1.00"/>
  </option>
  <option value="GMT">(GMT)
  <lt:Label res="res.label.cms.config" key="GMT"/>
  </option>
  <option value="GMT+01:00">(GMT+1.00)
  <lt:Label res="res.label.cms.config" key="GMT+1.00"/>
  </option>
  <option value="GMT+02:00">(GMT+2.00)
  <lt:Label res="res.label.cms.config" key="GMT+2.00"/>
  </option>
  <option value="GMT+03:00">(GMT+3.00)
  <lt:Label res="res.label.cms.config" key="GMT+3.00"/>
  </option>
  <option value="GMT+04:00">(GMT+4.00)
  <lt:Label res="res.label.cms.config" key="GMT+4.00"/>
  </option>
  <option value="GMT+04:30">(GMT+4.30)
  <lt:Label res="res.label.cms.config" key="GMT+4.30"/>
  </option>
  <option value="GMT+05:00">(GMT+5.00)
  <lt:Label res="res.label.cms.config" key="GMT+5.00"/>
  </option>
  <option value="GMT+05:30">(GMT+5.30)
  <lt:Label res="res.label.cms.config" key="GMT+5.30"/>
  </option>
  <option value="GMT+05:45">(GMT+5.45)
  <lt:Label res="res.label.cms.config" key="GMT+5.45"/>
  </option>
  <option value="GMT+06:00">(GMT+6.00)
  <lt:Label res="res.label.cms.config" key="GMT+6.00"/>
  </option>
  <option value="GMT+06:30">(GMT+6.30)
  <lt:Label res="res.label.cms.config" key="GMT+6.30"/>
  </option>
  <option value="GMT+07:00">(GMT+7.00)
  <lt:Label res="res.label.cms.config" key="GMT+7.00"/>
  </option>
  <option value="GMT+08:00" selected="selected">(GMT+8.00)
  <lt:Label res="res.label.cms.config" key="GMT+8.00"/>
  </option>
  <option value="GMT+09:00">(GMT+9.00)
  <lt:Label res="res.label.cms.config" key="GMT+9.00"/>
  </option>
  <option value="GMT+09:30">(GMT+9.30)
  <lt:Label res="res.label.cms.config" key="GMT+9.30"/>
  </option>
  <option value="GMT+10:00">(GMT+10.00)
  <lt:Label res="res.label.cms.config" key="GMT+10.00"/>
  </option>
  <option value="GMT+11:00">(GMT+11.00)
  <lt:Label res="res.label.cms.config" key="GMT+11.00"/>
  </option>
  <option value="GMT+12:00">(GMT+12.00)
  <lt:Label res="res.label.cms.config" key="GMT+12.00"/>
  </option>
  <option value="GMT+13:00">(GMT+13.00)
  <lt:Label res="res.label.cms.config" key="GMT+13.00"/>
  </option>
</select>
			<script>
				frmAnnounce.timeZone.value = "<%=user.getTimeZone().getID()%>";
				</script>            </td></tr>
          <tr bgcolor="#CCCCCC">
            <td rowspan="2" align=left valign="middle"  bgcolor="#FFFFFF">&nbsp;
              <lt:Label res="res.label.forum.user" key="sign"/>
              <br>
              <br>
              &nbsp;&nbsp;UBB：
	        <%
				  com.redmoon.forum.Config cfg = new com.redmoon.forum.Config();
				  if (cfg.getBooleanProperty("forum.sign_ubb"))
				  	out.print("支持");
				  else
				  	out.print("不支持");
				  %></td>
            <td height="14" colspan="3" valign="middle" bgcolor="#FFFFFF">&nbsp;
                <%@ include file="forum/inc/getubb.jsp"%></td>
          </tr>
          <tr bgcolor="#CCCCCC">
            <td height="14" colspan="3" valign="middle" bgcolor="#FFFFFF">&nbsp;
                <textarea cols="75" name="Content" rows="5" wrap="VIRTUAL" title="签名档"><%=sign%></textarea>
                <font color="#000000"><br>
  &nbsp;&nbsp;
  <lt:Label res="res.label.forum.user" key="sign_limit_count"/>
  <%=cfg.getIntProperty("forum.sign_length")%></font></td>
          </tr>
          <tr> 
            <td colspan="4" bgcolor="#FFFFFF"> <table border=0 cellpadding=0 cellspacing=0 width=100%>
                <tr valign=bottom> 
                  <td height=41 align="center" valign="middle"> <font color="#FF0000">&nbsp; </font><br>
                    <input name=Write type=submit  value="<lt:Label key="ok"/>">
                    　 
                    <input name=reset type=reset  value="<lt:Label key="reset"/>">
                  <br></td>
                </tr>
              </table></td>
          </tr>
      </table></td>
</tr></form></table>
<%@ include file="forum/inc/footer.jsp"%>
</body>
<SCRIPT>
function VerifyInput()
{
	var signlen = <%=cfg.getIntProperty("forum.sign_length")%>;
	if (document.frmAnnounce.Content.value.length>signlen)
	{
		alert("<lt:Label res="res.label.forum.user" key="sign_limit_count"/>" + signlen);
		document.frmAnnounce.Content.focus();
		return false;
	}

	return true;
}
</SCRIPT>
</html>