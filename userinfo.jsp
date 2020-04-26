<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.forum.person.*"%>
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
<title><lt:Label res="res.label.userinfo" key="user_info"/> - <%=Global.AppName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="forum/<%=skinPath%>/skin.css" rel="stylesheet" type="text/css">
<script>
function New(para_URL){var URL=new String(para_URL);window.open(URL,'','resizable,scrollbars')}
function CheckRegName(){
	var Name=document.form.RegName.value;
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
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%@ include file="forum/inc/header.jsp"%>
<jsp:useBean id="StrUtil" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/>
<div id="newdiv" name="newdiv">
<%
//安全验证
//if (!privilege.isUserLogin(request))
//{
//	response.sendRedirect("door.jsp");
//	return;
//}
String username = ParamUtil.get(request, "username");
if (username==null) {
	out.print(StrUtil.makeErrMsg(SkinUtil.LoadString(request,"res.label.userinfo","user_name_can_not_be_null")));
	return;
}
%>
<%
String RegName="",Question="",Answer="";
String RealName="",Career="";
String Gender="",Job="";
int BirthYear = 0;
int BirthMonth = 0;
int BirthDay = 0;
Date Birthday = null;
String Marriage="",Phone="",Mobile="";
String State="",City="",Address="";
String PostCode="",IDCard="",RealPic="";
String Email="",OICQ="";
String Hobbies="",myface="";
String RegDate = "";
ResultSet rs = null;
String name = privilege.getUser(request);
int myfacewidth=120,myfaceheight=150;
UserDb user = new UserDb();
user = user.getUser(username);
if (!user.isLoaded()) {
	out.print(StrUtil.Alert_Back(SkinUtil.LoadString(request,"res.label.userinfo","user_not_exsist")));
	return;
}
		RegName = user.getName();
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
		int mar = user.getMarriage();
		if (mar==1)
			Marriage = SkinUtil.LoadString(request,"res.label.userinfo","married");
		else if (mar==0)
			Marriage = SkinUtil.LoadString(request,"res.label.userinfo","not_married");
		else
			Marriage = SkinUtil.LoadString(request,"res.label.userinfo","married_none");
		Phone = user.getPhone();
		Mobile = user.getMobile();
		State = user.getState();
		City = user.getCity();
		Address = user.getAddress();
		PostCode = user.getPostCode();
		IDCard = user.getIDCard();
		RealPic = user.getRealPic();
		RegDate = com.redmoon.forum.ForumSkin.formatDateTime(request, user.getRegDate());

		Hobbies = user.getHobbies();
		Email = user.getEmail();
		OICQ = user.getOicq();
		myface = user.getMyface();
		myfacewidth = user.getMyfaceWidth();
		myfaceheight = user.getMyfaceHeight();
%>
<br>

<br>
<table width=580 height="248" border=0 align="center" cellpadding=5 cellspacing=1 class="tableframe_gray">
  <tr align="center" valign="middle">
    <td height="25" colspan="5" background="forum/<%=skinPath%>/images/bg1.gif" class="text_title">　<%=user.getNick()%>&nbsp;-&nbsp;
      <lt:Label res="res.label.userinfo" key="user_info"/></td>
  </tr>
  <tr valign="middle">
    <td width=135 rowspan="8" align=left><font color="#FF0000">&nbsp;
        <%if (myface.equals("")) {%>
        <img src="forum/images/face/<%=RealPic%>" name="tus">
        <%}else{%>
        <img src="images/myface/<%=myface%>" name="tus" width="<%=myfacewidth%>" height="<%=myfaceheight%>">
        <%}%>
    </font></td> 
    <td width=87 height="25" align=left bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="Gender"/></td>
    <td width="140" height="25" bgcolor="#FBFBFB"> 
      <% if (Gender.equals("M"))
						out.println(SkinUtil.LoadString(request,"res.label.prision","man"));
					else if (Gender.equals("F"))
						out.println(SkinUtil.LoadString(request,"res.label.prision","woman"));
					else
						out.println(SkinUtil.LoadString(request,"res.label.prision","not_in_detail"));
				  %>    </td>
    <td width=87 height="25" align="left" bgcolor="#EFEFEF"> <lt:Label res="res.label.forum.user" key="Career"/></td>
    <td width="138" height="25" bgcolor="#FBFBFB" class=l15> <%=Career%> </td>
  </tr>
  <tr valign="middle">
    <td width=87 height="25" align=left bgcolor="#EFEFEF">E-mail</td>
    <td height="25" bgcolor="#FBFBFB"><%if (!user.isSecret()) {%>
      <%=Email%>
      <%}else{%>
<lt:Label res="res.label.userinfo" key="secret"/>
<%}%></td>
    <td width=87 height="25" align="left" bgcolor="#EFEFEF"> <lt:Label res="res.label.forum.user" key="Job"/></td>
    <td height="25" bgcolor="#FBFBFB" class=l15> <%=Job%></td>
  </tr>
  <tr valign="middle">
    <td width=87 height="28" align=left bgcolor="#EFEFEF">QQ</td>
    <td height="28" bgcolor="#FBFBFB"><%if (!user.isSecret()) {%>
      <%=OICQ%>
      <%}else{%>
      <lt:Label res="res.label.userinfo" key="secret"/>
<%}%></td>
    <td width=87 height="28" align="left" bgcolor="#EFEFEF"> <lt:Label res="res.label.forum.user" key="marry_status"/></td>
    <td height="28" bgcolor="#FBFBFB" class=l15><%if (!user.isSecret()) {%>
      <%=Marriage%>
      <%}else{%>
<lt:Label res="res.label.userinfo" key="secret"/>
<%}%></td>
  </tr>
  <tr valign="middle">
    <td width=87 height="27" align=left bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="State"/></td>
    <td height="27" bgcolor="#FBFBFB"> <%=State%></td>
    <td align="left" bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="City"/></td>
    <td bgcolor="#FBFBFB"><%=City%></td>
  </tr>
  <tr valign="middle">
    <td width=87 height="25" align=left bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="PostCode"/></td>
    <td height="25" bgcolor="#FBFBFB"><%=PostCode%></td>
    <td align="left" bgcolor="#EFEFEF"><lt:Label res="res.label.userinfo" key="credit"/></td>
    <td bgcolor="#FBFBFB"><%=user.getCredit()%></td>
  </tr>
  <tr valign="middle">
    <td width=87 height="25" align=left bgcolor="#EFEFEF"><lt:Label res="res.label.userinfo" key="reg"/></td>
    <td height="25" bgcolor="#FBFBFB"><%=RegDate%></td>
    <td align="left" bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="Hobbies"/></td>
    <td bgcolor="#FBFBFB"><%=Hobbies%></td>
  </tr>
  <tr valign="middle">
    <td height="29" align=left bgcolor="#EFEFEF"><lt:Label res="res.label.forum.user" key="home"/></td>
    <td bgcolor="#FBFBFB"><a href="<%=user.getHome()%>"><%=user.getHome()%></a></td>
    <td align="left" bgcolor="#EFEFEF">MSN</td>
    <td bgcolor="#FBFBFB"><%if (!user.isSecret()) {%>
        <%=user.getMsn()%>
        <%}else{%>
      <lt:Label res="res.label.userinfo" key="secret"/>
  <%}%></td>
  </tr>
  <tr valign="middle">
    <td width=87 height="29" align=left bgcolor="#EFEFEF">&nbsp;</td>
    <td bgcolor="#FBFBFB">&nbsp;</td>
    <td align="left" bgcolor="#EFEFEF">&nbsp;</td>
    <td bgcolor="#FBFBFB"><a href="#" onClick="hopenWin('message/send.jsp?receiver=<%=StrUtil.UrlEncode(user.getNick())%>', 320, 260)"><lt:Label res="res.label.userinfo" key="send_message"/></a>&nbsp;&nbsp;
      <%if (Global.hasBlog) {%>
      <a target="_blank" title="<lt:Label res="res.label.forum.showtopic" key="blog"/>" href="blog/myblog.jsp?userName=<%=StrUtil.UrlEncode(user.getName())%>">
      <lt:Label res="res.label.forum.showtopic" key="blog"/>
      <%}%>
      </a></td>
  </tr>
</table>
<br>
<%@ include file="forum/inc/footer.jsp"%>
</body>
<SCRIPT>
function VerifyInput()
{
var newDateObj = new Date()
if (document.form.username.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_regname"/>");
document.form.username.focus();
return false;
}

if (document.form.userpass.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_pwd"/>");
document.form.userpass.focus();
return false;
}
if (document.form.userpass2.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_pwd2"/>");
document.form.userpass2.focus();
return false;
}
if (document.form.userpass.value != document.form.userpass2.value)
{
alert("<lt:Label res="res.label.forum.user" key="pwd_not_equal_pwd2"/>");
document.form.userpass.focus();
return false;
}

if (document.form.usermail.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_email"/>");
document.form.usermail.focus();
return false;
}

if (document.form.question.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_question"/>");
document.form.question.focus();
return false;
}

if (document.form.answer.value == "")
{
alert("<lt:Label res="res.label.forum.user" key="need_answer"/>");
document.form.answer.focus();
return false;
}

if (document.form.birthyear.value > 0)  {
if (isNaN(document.form.birthyear.value) || document.form.birthyear.value > newDateObj.getFullYear()  || document.form.birthyear.value < 1900)
{
alert("<lt:Label res="res.label.forum.user" key="err_birthday"/>");
document.form.birthyear.focus();
return false;
}}

return true;
}
</SCRIPT>
</html>