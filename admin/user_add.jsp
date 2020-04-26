<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="com.redmoon.oa.basic.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="java.util.*"%>
<html>
<head>
<title>添加用户</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script>
function New(para_URL){var URL=new String(para_URL);window.open(URL,'','resizable,scrollbars')}
function CheckRegName(){
	var Name=document.memberform.name.value;
	window.open("../isUserExist.jsp?name="+Name,"","width=200,height=20");
}
</script>
</head>
<body bgcolor="#FFFFFF" text="#000000" style="BACKGROUND-IMAGE:url()">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%
if (!privilege.isUserPrivValid(request, "admin.user")) {
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
<table width=98% align=center cellspacing=0 cellpadding=0 border=0>
 <Form method="POST" action="user_add_do.jsp"  name="memberform" onSubmit="return memberform_onsubmit()"><tr>
      <td bgcolor=#D3D3D3> <table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor="#CCCCCC">
          <tr> 
            <td align=center bgcolor="#FFFFFF"> <table border=0 cellpadding=0 cellspacing=0 width=100%>
                <tr bgcolor="#0099FF"> 
                  <td width="86%" height=20 bgcolor="#C4DAFF" class="stable"><b>　</b>成员代号及密码 
                    &nbsp;&nbsp;&nbsp;注意：此栏必须填写</td>
                  <td width="14%" align="center" bgcolor="#C4DAFF" class="stable"><a href="user_list.jsp">返回职员列表</a></td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=0 cellspacing=1>
                <tr> 
                  <td width="102" align=left bgcolor="#EEEEEE" class="stable">注册用户</td>
                  <td width="300" align=left class="stable"><input type=text name="name" size=20>
                    <font color="#FF0000"> * </font>
                  <input name=Button type=button class="singleboarder" onClick="javascript:CheckRegName()" value='检测用户名'></td>
                  <td width="142" align=left bgcolor="#EFEFEF" class="stable">真实姓名                    </td>
                  <td align=left class="stable"><input type=text name=RealName size=12 maxlength=8>
                  <font color="#FF0000">*</font></td>
                </tr>
                <tr align="left"> 
                  <td align="left" bgcolor="#EEEEEE" class="stable">登陆密码                    </td>
                  <td valign="top" class="stable"><input type=password name=Password size=20>
                    <font color="#FF0000">*</font></td>
                  <td valign="top" bgcolor="#EFEFEF" class="stable">请再次输入密码                    </td>
                  <td valign="top" class="stable"><input type=password name=Password2 size=20>
                    <font color="#FF0000"> *</font></td>
                </tr>
                <tr align="left">
                  <td align="left" bgcolor="#EEEEEE" class="stable">职级</td>
                  <td valign="top" class="stable"><select name="rankCode">
                    <option value="">无</option>
                    <%
	RankDb rd = new RankDb();
	Iterator ir = rd.list().iterator();
	String opts = "";
	while (ir.hasNext()) {
		rd = (RankDb)ir.next();
		opts += "<option value='" + rd.getCode() + "'>" + rd.getName() + "</option>";
	}
	out.print(opts);
%>
                  </select></td>
                  <td valign="top" bgcolor="#EFEFEF" class="stable">&nbsp;</td>
                  <td valign="top" class="stable">&nbsp;</td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=0 cellspacing=0>
                <tr bgcolor="#C4DAFF"> 
                  <td height=20 class="stable"><b>　</b>个人资料</td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=0 cellspacing=1>
                <tr> 
                  <td width=100 height="25" align=left bgcolor="#EEEEEE" class="stable"> 
                    性别</td>
                  <td width="300" height="25" class="stable"> <input type=radio name=gender value="<%=UserDb.GENDER_MAN%>" checked>
                    男 
                    <input type=radio name=gender value="<%=UserDb.GENDER_WOMAN%>">
                  女</td>
                  <td width=142 height="25" bgcolor="#EEEEEE" class="stable"> 
                    婚姻状况</td>
                  <td height="25" class=stable><select name=Marriage size=1>
                    <option value="1">已婚</option>
                    <option value="0">未婚</option>
                  </select></td>
                </tr>
                <tr> 
                  <td width=100 height="28" align=left bgcolor="#EEEEEE" class="stable"> 
                    出生日期</td>
                  <td height="28" class="stable">
					<jsp:useBean id="calsheet" scope="page" class="com.redmoon.oa.CalendarSheet"/>
				   <select name="BirthYear">
                      <option value="">请选择
                      <%
				int curyear = calsheet.getCurYear();
				int curmonth = calsheet.getCurMonth();
				int curday = calsheet.getCurDay();
				int monthdays = 31;//calsheet.getDays(curmonth,curyear);
				String isselected = "";
				for (int k=curyear-80; k<=curyear+50; k++) {
				%>
                      <option value="<%=k%>" <%=isselected%>><%=k%></option>
                      <%
					isselected = "";
				}
				%>
                    </select>
年
<select name="BirthMonth">
  <option value="">...
  <%
			  String v = "";
			  for (int k=1; k<=12; k++) {
				v = k+"";
			  %>
  <option value="<%=v%>" <%=isselected%>><%=k%></option>
  <%
			  	isselected = "";
			  }
			  %>
</select>
月
<select name="BirthDay">
  <option value="">...
  <%
			  for (int k=1; k<=monthdays; k++) {
				v = k+"";
			  %>
  <option value="<%=v%>" <%=isselected%>><%=k%></option>
  <%
			  	isselected = "";
			  }
			  %>
</select></td>
                  <td width=142 height="28" bgcolor="#EEEEEE" class="stable"> 
                    QQ:</td>
                  <td class=stable height="28"><input type=text name=QQ size=16 maxlength="15"></td>
                </tr>
                <tr> 
                  <td width=100 height="25" align=left bgcolor="#EEEEEE" class="stable"> 
                    E-mail</td>
                  <td height="25" class="stable"> <input type=text name=Email size=20 maxlength="50">                  </td>
                  <td width=142 height="25" bgcolor="#EEEEEE" class="stable"> 
                    MSN:</td>
                  <td class=stable height="25"><input type=text name=MSN size=16 maxlength="15"></td>
                </tr>
                <tr> 
                  <td width=100 height="25" align=left bgcolor="#EEEEEE" class="stable"> 
                    电话</td>
                  <td height="25" class="stable"> <input type=text name=Phone size=16 maxlength="20">                  </td>
                  <td width=142 height="25" bgcolor="#EEEEEE" class="stable"> 
                    手机号码</td>
                  <td class=stable height="25"> <input type=text name=mobile size=16 maxlength="16">                  </td>
                </tr>
                <tr> 
                  <td width=100 height="27" align=left bgcolor="#EEEEEE" class="stable"><img src=/images/c.gif width=1 height=5> 
                    省份</td>
                  <td height="27" valign="top" class="stable"> <select name=State size=1>
                      <option value="0" selected>请选择…</option>
                      <option value="安徽">安徽</option>
                      <option value="北京">北京</option>
                      <option value="重庆">重庆</option>
                      <option value="福建">福建</option>
                      <option value="甘肃">甘肃</option>
                      <option value="广东">广东</option>
                      <option value="广西">广西</option>
                      <option value="贵州">贵州</option>
                      <option value="海南">海南</option>
                      <option value="河北">河北</option>
                      <option value="黑龙江">黑龙江</option>
                      <option value="河南">河南</option>
                      <option value="湖北">湖北</option>
                      <option value="湖南">湖南</option>
                      <option value="内蒙古">内蒙古</option>
                      <option value="江苏">江苏</option>
                      <option value="江西">江西</option>
                      <option value="吉林">吉林</option>
                      <option value="辽宁">辽宁</option>
                      <option value="宁夏">宁夏</option>
                      <option value="青海">青海</option>
                      <option value="山西">山西</option>
                      <option value="陕西">陕西</option>
                      <option value="山东">山东</option>
                      <option value="上海">上海</option>
                      <option value="四川">四川</option>
                      <option value="天津">天津</option>
                      <option value="西藏">西藏</option>
                      <option value="新疆">新疆</option>
                      <option value="云南">云南</option>
                      <option value="浙江">浙江</option>
                      <option value="其他">其他</option>
                    </select> </td>
                  <td height="25" align=left bgcolor="#EEEEEE" class="stable">城市</td>
                  <td height="25" class="stable"><input type=text name=City size=10>                  </td>
                </tr>
                <tr>
                  <td height="25" align=left bgcolor="#EEEEEE" class="stable">地址/邮政地址</td>
                  <td height="25" class="stable"><input type=text name=Address size=25>                  </td> 
                  <td height="36" align=left bgcolor="#EEEEEE" class="stable">邮政编码</td>
                  <td height="36" class="stable"><input type=text name=postCode size=10>                  </td>
                </tr>
                <tr>
                  <td height="25" align=left bgcolor="#EEEEEE" class="stable">身份证号码</td>
                  <td height="25" valign="top" class="stable"><input type=text name=IDCard size=30>                  </td> 
                  <td valign="top" class="stable">&nbsp;</td>
                  <td valign="top" class="stable">&nbsp;</td>
                </tr>
                <tr>
                  <td align=left bgcolor="#EEEEEE" class="stable"><img src=/images/c.gif width=1 height=8>兴趣爱好</td>
                  <td colspan=3 class="stable"><input name="Hobbies" type=text size="30" ></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td bgcolor="#FFFFFF"> <table border=0 cellpadding=0 cellspacing=0 width=100%>
                <tr> 
                  <td height=41 align="center"> 
                    <input type=submit name=Write value=" 提 交 ">
                    　 
                    <input type=reset name=reset value=" 重 填 "> </td>
                </tr>
              </table></td>
          </tr>
        </table></td>
</tr></form></table>
</body>
<SCRIPT>
function memberform_onsubmit()
{
	if (memberform.RealName.value=="") {
		alert("请输入用户姓名");
		return false;
	}
	if (memberform.Password.value != memberform.Password2.value)
	{
		alert("两遍输入的口令不一致");
		memberform.Password.focus();
		return false;
	}
	return true;
}
</SCRIPT>
</html>