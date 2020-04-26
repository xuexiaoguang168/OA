<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.redmoon.oa.person.*"%>
<%@ page import="com.redmoon.oa.dept.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="com.redmoon.oa.basic.*"%>
<html>
<head>
<title>编辑用户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="../common.css" type="text/css">
<script>
function New(para_URL){var URL=new String(para_URL);window.open(URL,'','resizable,scrollbars')}

function check_checkbox(myitem,myvalue)
{
     var checkboxs = document.all.item(myitem);
	 
	 var myary = myvalue.split("|");
	 
     if (checkboxs!=null)
     {
       for (i=0; i<checkboxs.length; i++)
          {
            if (checkboxs[i].type=="checkbox" )
              {
				for (k=0; k<myary.length; k++) {
				 if (checkboxs[i].value==myary[k])
	                 checkboxs[i].checked = true
				}
              }
          }
     }
}

</script>
<style type="text/css">
<!--
.style1 {color: #000000}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
//String priv="admin";
//if (!privilege.isUserPrivValid(request,priv))
//{
//	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
//	return;
//}
%>
<div id="newdiv" name="newdiv">
<%
String username = ParamUtil.get(request, "name");
if (!SecurityUtil.isValidSqlParam(username)) {
	out.print(StrUtil.Alert("参数非法！"));
	return;
}
UserMgr um = new UserMgr();
UserDb user = um.getUserDb(username);
if (user==null || !user.isLoaded()) {
	out.print(StrUtil.Alert_Back("该用户已不存在！"));
	return;
}
%>
<table width=98% align=center cellspacing=0 cellpadding=0 border=0>
 <Form method="POST" action="user_edit_do.jsp"  name="memberform" onSubmit="return memberform_onsubmit()"><tr>
      <td bgcolor=#D3D3D3> <table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor="#CCCCCC">
          <tr> 
            <td align=center bgcolor="#FFFFFF"> <table border=0 cellpadding=0 cellspacing=0 width=100%>
                <tr bgcolor="#C4DAFF"> 
                  <td width="82%" height=24 bgcolor="#C4DAFF" class="stable"><b>　</b>职员信息
                    </td>
                  <td width="18%" align="center" bgcolor="#C4DAFF" class="stable"><a href="user_list.jsp">返回职员列表</a></td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=2 cellspacing=0>
                <tr> 
                  <td width="100" align=left bgcolor="#eeeeee" class="stable">用户名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td width="300" class="stable"><%=user.getName()%>
                    <input type=hidden name="name" size=20 value="<%=user.getName()%>"></td>
                  <td class="stable">启用帐号 
                    <select name=isValid size=1>
                      <option value="1" selected>是</option>
                      <option value="0">否</option>
                  </select> <script language="javascript">
					<!--
					memberform.isValid.value = "<%=user.getValid()%>"
					//-->
					</script> 
                  &nbsp;&nbsp;<a href="user_op.jsp?op=edit&name=<%=StrUtil.UrlEncode(user.getName())%>">分配权限</a> </td>
                </tr>
                <tr class="stable"> 
                  <td align="left" valign="top" bgcolor="#eeeeee" class="stable"> 登陆密码                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td colspan="2" valign="top" class="stable"><input type=password name=Password size=20>
                    <font color="#FF0000">*</font> 请再次输入密码
                    <input type=password name=Password2 size=20>
                    <font color="#FF0000"> * 
（如不需更改密码，则不用填写） </font> </td>
                </tr>
                <tr class="stable"> 
                  <td height="22" align=left valign="top" bgcolor="#eeeeee" class="stable"> 
                    真实姓名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                  <td height="22" align=left valign="top" class="stable"><input type=text name=RealName size=12 maxlength=8 value="<%=user.getRealName()%>"></td>
                  <td height="22" align=left valign="top" class="stable">磁盘份额&nbsp;
                  <input name="diskSpaceAllowed" value="<%=user.getDiskSpaceAllowed()%>">字节</td>
                </tr>
                <tr class="stable">
                  <td height="22" align=left valign="top" bgcolor="#eeeeee" class="stable">职级</td>
                  <td height="22" align=left valign="top" class="stable"><select name="rankCode">
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
                  </select>
				  <script>
				  memberform.rankCode.value = "<%=user.getRankCode()%>";
				  </script>
				  </td>
                  <td height="22" align=left valign="top" class="stable">&nbsp;</td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=0 cellspacing=0>
                <tr> 
                  <td height=24 bgcolor="#C4DAFF" class="stable"><b>　</b>个人资料</td>
                </tr>
              </table>
              <table width=100% border=0 cellpadding=2 cellspacing=0>
                <tr> 
                  <td width=100 height="25" align=left bgcolor="#eeeeee" class="stable"> 
                    性别</td>
                  <td width="300" height="25" class="stable"> <% 
				  String isM = "";
				  String isF="";
				  if (user.getGender()==0)
				  	isM = "checked";
				  else
				  	isF = "checked";
				  %> <input type=radio name=gender value=0 <%=isM%>>
                    男 
                    <input type=radio name=gender value=1 <%=isF%>>
                  女</td>
                  <td width="115" height="28" align="left" bgcolor="#eeeeee" class="stable">婚姻状况</td>
                  <td height="28" class=stable><select name=Marriage size=1>
                      <option value="" selected>请选...</option>
                      <option value="0">已婚</option>
                      <option value="1">未婚</option>
                    </select>
                  <script language="JavaScript">
					<!--
					memberform.Marriage.value="<%=user.getMarriaged()%>";
					//-->
					</script></td>
                </tr>
                <tr> 
                  <td width=102 height="28" align=left bgcolor="#eeeeee" class="stable"> 
                    出生日期</td>
                  <td height="28" class="stable"> 
				  <%
				Date bd = user.getBirthday();
				String y="",m="",d="";
				if (bd!=null) {
					Calendar cal = Calendar.getInstance();
					cal.setTime(bd);
					y = "" + cal.get(cal.YEAR);
					m = "" + (cal.get(cal.MONTH) + 1);
					d = "" + cal.get(cal.DAY_OF_MONTH);
				}
				  %>
					<jsp:useBean id="calsheet" scope="page" class="com.redmoon.oa.CalendarSheet"/>
                    <select name="BirthYear">
					<option value="">请选择</optoin>
                      <%
				int curyear = calsheet.getCurYear();
				int curmonth = calsheet.getCurMonth();
				int curday = calsheet.getCurDay();
				int monthdays = 31;// calsheet.getDays(curmonth,curyear);
				String isselected = "";
				for (int k=curyear-80; k<=curyear+50; k++) {
					if ((k+"").equals(y))
						isselected = "selected";
				%>
                      <option value="<%=k%>" <%=isselected%>><%=k%></option>
                      <%
					isselected = "";
				}
				%>
                    </select>
年
<select name="BirthMonth">
<option value="">...</optoin>
  <%
			  String v = "";
			  for (int k=1; k<=12; k++) {
			  	if ((k+"").equals(m))
					isselected = "selected";
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
<option value="">...</optoin>
  <%
			  for (int k=1; k<=monthdays; k++) {
			  	if ((k+"").equals(d))
					isselected="selected";
				v = k+"";
			  %>
  <option value="<%=v%>" <%=isselected%>><%=k%></option>
  <%
			  	isselected = "";
			  }
			  %>
</select>
日 &nbsp;</td>
                  <td width="115" height="25" align="left" bgcolor="#eeeeee" class="stable">QQ</td>
                  <td height="25" align="left" class=stable><input type=text name=QQ size=16 maxlength="15" value="<%=user.getQQ()%>">                  </td>
                </tr>
                <tr> 
                  <td width=102 height="25" align=left bgcolor="#eeeeee" class="stable"> 
                    E-mail</td>
                  <td height="25" class="stable"> <input type=text name=Email size=20 maxlength="50" value="<%=StrUtil.getNullString(user.getEmail())%>">                  </td>
                  <td width=115 height="25" align="left" bgcolor="#eeeeee" class="stable">MSN</td>
                  <td class=stable height="25"><input type=text name=MSN size=16 maxlength="16" value="<%=StrUtil.getNullString(user.getMSN())%>"></td>
                </tr>
                <tr> 
                  <td width=102 height="25" align=left bgcolor="#eeeeee" class="stable"> 
                    电话</td>
                  <td height="25" class="stable"> <input type=text name=Phone size=16 maxlength="20" value="<%=StrUtil.getNullString(user.getPhone())%>">                  </td>
                  <td width=115 height="25" align="left" bgcolor="#eeeeee" class="stable"> 
                    手机号码</td>
                  <td class=stable height="25"> <input type=text name=mobile size=16 maxlength="16" value="<%=user.getMobile()%>">
                    <font color="#FF0000">
                    <input type="hidden" name="RealPic" value="1">
                  </font>                  </td>
                </tr>
                <tr> 
                  <td width=102 height="27" align=left bgcolor="#eeeeee" class="stable">省份</td>
                  <td height="27" valign="top" class="stable"> <select name=State size=1>
                      <option value="" selected>请选择…</option>
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
                    </select> <script language="JavaScript">
					<!--
					memberform.State.value="<%=StrUtil.getNullString(user.getState())%>"
					//-->
					</script> </td>
                  <td width="115" align="left" valign="top" bgcolor="#eeeeee" class="stable">城市
                  <br></td>
                  <td valign="top" class="stable"><input type=text name=City size=10 value="<%=StrUtil.getNullString(user.getCity())%>"></td>
                </tr>
                <tr> 
                  <td width=102 height="25" align=left bgcolor="#eeeeee" class="stable">地址/邮政地址</td>
                  <td height="25" valign="top" class="stable"><input type=text name=Address size=25 value="<%=StrUtil.getNullString(user.getAddress())%>"></td>
                  <td width="115" align="left" valign="top" bgcolor="#eeeeee" class="stable">邮政编码</td>
                  <td valign="top" class="stable"><input type=text name=postCode size=10 value="<%=user.getPostCode()%>"></td>
                </tr>
                <tr> 
                  <td width=102 height="25" align=left bgcolor="#eeeeee" class="stable">身份证号码</td>
                  <td height="25" class="stable"><input type=text name=IDCard size=30 value="<%=StrUtil.getNullString(user.getIDCard())%>"></td>
                  <td valign="top" bgcolor="#eeeeee" class="stable">&nbsp;</td>
                  <td valign="top" class="stable">&nbsp;</td>
                </tr>
                
                <tr> 
                  <td width=102 align=left valign="top" bgcolor="#eeeeee" class="stable"><img src="images/c.gif" width=1 height=8>兴趣爱好</td>
                  <td colspan=3><input type=text size="30" name="Hobbies" value="<%=user.getHobbies()%>" ></td>
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