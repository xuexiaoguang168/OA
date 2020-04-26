<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.redmoon.oa.archive.*" %>
<%@ page import="cn.js.fan.util.*" %>
<%@ page import="cn.js.fan.web.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../common.css">
<link rel="stylesheet" type="text/css" href="../css.css">
<title>修改用户档案</title>
<script>
function findObj(theObj, theDoc)
{
  var p, i, foundObj;
  
  if(!theDoc) theDoc = document;
  if( (p = theObj.indexOf("?")) > 0 && parent.frames.length)
  {
    theDoc = parent.frames[theObj.substring(p+1)].document;
    theObj = theObj.substring(0,p);
  }
  if(!(foundObj = theDoc[theObj]) && theDoc.all) foundObj = theDoc.all[theObj];
  for (i=0; !foundObj && i < theDoc.forms.length; i++) 
    foundObj = theDoc.forms[i][theObj];
  for(i=0; !foundObj && theDoc.layers && i < theDoc.layers.length; i++) 
    foundObj = findObj(theObj,theDoc.layers[i].document);
  if(!foundObj && document.getElementById) foundObj = document.getElementById(theObj);
  
  return foundObj;
}

var GetDate=""; 
function SelectDate(ObjName,FormatDate){
	var PostAtt = new Array;
	PostAtt[0]= FormatDate;
	PostAtt[1]= findObj(ObjName);
	GetDate = showModalDialog("../util/calendar/calendar.htm", PostAtt ,"dialogWidth:286px;dialogHeight:221px;status:no;help:no;");
}

function SetDate()
{ 
	findObj(ObjName).value = GetDate; 
}
</script>
</head>
<body style="background-image:url()">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv = "archive";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String name = ParamUtil.get(request, "name");
if (name.equals("")) {
	out.print(StrUtil.Alert("用户名不能为空！"));
	return;
}
UserArchiveDb uad = new UserArchiveDb();
uad = uad.getUserArchiveDb(name);

String op = ParamUtil.get(request, "op");
if (op.equals("create")) {
	if (uad==null || !uad.isLoaded()) {
		boolean re = uad.create();
		// out.print("re=" + re);
	}
}
uad = uad.getUserArchiveDb(name);
if (op.equals("modify")) {
	UserArchiveMgr uam = new UserArchiveMgr();
	boolean re = false;
	try {
		re = uam.modify(application, request);
		if (re)
			uad = uad.getUserArchiveDb(name);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert("维护成功！"));
}
%>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" class="main">
  <form name="form1" action="?op=modify&name=<%=StrUtil.UrlEncode(name)%>" method="post" encType="multipart/form-data">
    <tbody>
      <tr>
        <td noWrap colSpan="3" class="right-title"><b>&nbsp;<%=name%>的基本信息</b></td>
      </tr>
      <tr>
        <td noWrap width="96">编号：</td>
        <td width="496"><input name="id" id="id" size="10" maxLength="100" value="<%=uad.getId()%>"></td>
        <td width="160" rowSpan="6"><center>
		<%if (uad.getPhoto()==null || uad.getPhoto().equals("")) {%>
		暂无照片
		<%}else{%>
		<img src="../<%=uad.getPhoto()%>">
		<%}%>
		</center>		</td>
      </tr>
      <tr>
        <td noWrap>姓名：</td>
        <td><input name="realName" id="realName" value="<%=uad.getRealName()%>" size="10" maxlength="100" /></td>
      </tr>
      <tr>
        <td noWrap>性别：</td>
        <td><select name="gender">
            <option value="0" selected>女</option>
            <option value="1">男</option>
          </select>
		  <script>
		  form1.gender.value = "<%=uad.getGender()%>";
		  </script>		  </td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td noWrap><input name="birthday" id="birthday" size="10" maxlength="10" value="<%=uad.getBirthday()==null?"":DateUtil.format(uad.getBirthday(), "yyyy-MM-dd")%>" />
          <img src="../images/form/calendar.gif" border="0" align="absmiddle" style="CURSOR: hand" onclick="SelectDate('birthday', 'yyyy-MM-dd')"> 
          日期格式形如 1980-1-2</td>
      </tr>
      <tr>
        <td noWrap>民族：</td>
        <td><input name="nation" id="nation" value="<%=uad.getNation()%>" size="8" maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>身份证号码：</td>
        <td><input name="IDCard" value="<%=uad.getIDCard()%>" size="20" maxLength="25"></td>
      </tr>
      <tr>
        <td noWrap>照片上传：</td>
        <td colSpan="2"><input   title="选择附件文件" type="file" size="35" name="photo"></td>
      </tr>
      <tr>
        <td noWrap>婚姻状况：</td>
        <td colSpan="2"><select name="marriage">
            <option value></option>
            <option value="0" selected>未婚</option>
            <option value="1">已婚</option>
            <option value="2">离异</option>
          </select>
		  <script>
		  form1.marriage.value = "<%=uad.getMarriage()%>";
		  </script>		  </td>
      </tr>
      <tr>
        <td noWrap>籍贯：</td>
        <td colSpan="2"><input name="jiGuan" value="<%=uad.getJiGuan()%>" size="30"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>户口所在地：</td>
        <td colSpan="2"><input name="hukouAddress" value="<%=uad.getHukouAddress()%>" size="30"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>学历：</td>
        <td colSpan="2"><select name="xueLi">
            <option value="1">小学</option>
            <option value="2">初中</option>
            <option value="3">高中</option>
            <option value="4">中专</option>
            <option value="5">大专</option>
            <option value="6">大本</option>
            <option value="7">硕士</option>
            <option value="8">博士</option>
            <option value="9">博士后</option>
          </select>
		  <script>
		  form1.xueLi.value = "<%=uad.getXueLi()%>";
		  if (form1.xueLi.value=="")
		  	form1.xueLi.value = "6";
		  </script>		  </td>
      </tr>
      <tr>
        <td noWrap>专业：</td>
        <td colSpan="2"><input name="zhuanye" value="<%=uad.getZhuanYe()%>" size="30"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>毕业院校：</td>
        <td colSpan="2"><input name="school" value="<%=uad.getSchool()%>" size="30"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>参加工作时间：</td>
        <td noWrap colSpan="2"><input name="workDate" value="<%=uad.getWorkDate()%>" size="10"   maxLength="10"> 
          <img src="../images/form/calendar.gif" border="0" align="absmiddle" style="CURSOR: hand" onclick="SelectDate('workDate', 'yyyy-MM-dd')"> 
          日期格式形如 1999-1-2，请仔细检查</td>
      </tr>
      <tr>
        <td noWrap>加入本单位时间：</td>
        <td noWrap colSpan="2"><input name="workDateAtHere" value="<%=uad.getWorkDateAtHere()%>" size="10"   maxLength="10"> 
          <img src="../images/form/calendar.gif" border="0" align="absmiddle" style="CURSOR: hand" onclick="SelectDate('workDateAtHere', 'yyyy-MM-dd')"> 
          日期格式形如 1999-1-2，请仔细检查</td>
      </tr>
      <tr>
        <td noWrap>部门：</td>
        <td colSpan="2"><input name="dept" value="<%=uad.getDept()%>" size="15"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>职务：</td>
        <td colSpan="2"><input   maxLength="100" size="15" value="<%=uad.getZhiWu()%>" name="zhiWu"></td>
      </tr>
      <tr>
        <td noWrap>职称：</td>
        <td colSpan="2"><input name="zhiChen" value="<%=uad.getZhiChen()%>" size="15"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>政治面貌：</td>
        <td colSpan="2"><select name="politics">
            <option value="1">群众</option>
            <option value="2">团员</option>
            <option value="4">预备党员</option>
            <option value="3">党员</option>
          </select>
		  <script>
		  form1.politics.value = "<%=uad.getPolitics()%>";
		  </script>		  </td>
      </tr>
      <tr>
        <td noWrap>家庭住址：</td>
        <td colSpan="2"><input name="address" value="<%=uad.getHomeAddress()%>" size="40"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>家庭电话：</td>
        <td colSpan="2"><input name="homeTel" value="<%=uad.getHomeTel()%>" size="15"   maxLength="100"></td>
      </tr>
      <tr>
        <td noWrap>电子邮件：</td>
        <td colSpan="2"><input name="email" value="<%=uad.getEmail()%>" size="30"   maxLength="100"></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;岗位变动情况：</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="postChange" rows="3" wrap="on" cols="70"><%=uad.getPostChange()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;教育背景</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea name="education" rows="3" wrap="on" cols="70"><%=uad.getEducation()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;工作简历</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea name="resume" rows="3" wrap="on" cols="70"><%=uad.getResume()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;社会关系</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="socialRelation" rows="3" wrap="on" cols="70"><%=uad.getSocialRelation()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;奖惩记录</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="jiangchenRecord" rows="3" wrap="on" cols="70"><%=uad.getJiangchenRecord()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;职务情况</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="zhiwuQinkuang" rows="3" wrap="on" cols="70"><%=uad.getZhiwuQinkuang()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;培训记录</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="trainRecord" cols="70" rows="3" wrap="on" id="trainRecord"><%=uad.getTrainRecord()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;担保记录</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="danbaoRecord" cols="70" rows="3" wrap="on" id="danbaoRecord"><%=uad.getDanbaoRecord()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;劳动合同签订情况</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="contract" cols="70" rows="3" wrap="on" id="contract"><%=uad.getContract()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;社保缴纳情况</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="insure" cols="70" rows="3" wrap="on" id="insure"><%=uad.getInsure()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;体检记录</td>
      </tr>
      <tr>
        <td colSpan="3"><textarea   name="tijianRecord" cols="70" rows="3" wrap="on" id="tijianRecord"><%=uad.getTijianRecord()%></textarea></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;备 注</td>
      </tr>
      <tr>
        <td colSpan="3"><span class="TableHeader"><b>
          <textarea   name="remark" cols="70" rows="3" wrap="on" id="remark"><%=uad.getRemark()%></textarea>
        </b></span></td>
      </tr>
	  <!--      <tr>
        <td class="TableHeader" noWrap colSpan="3"><b>&nbsp;附件文档</b></td>
      </tr>
      <tr>
        <td colSpan="3">		</td>
      </tr>

      <tr>
        <td noWrap>附件上传：</td>
        <td colSpan="2"><input name="attachment" type="file" id="attachment"   title="选择附件文件" size="35"></td>
      </tr>
	  -->
      <tr align="center" class="TableControl">
        <td noWrap colSpan="3"><input type=hidden name="name" value="<%=name%>" />
          <input type="submit" value=" 保 存 ">
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="重置" type="reset" onclick="location='blank.php'" value=" 重 置 "></td>
      </tr>
    </tbody>
  </form>
</table>
</body>
</html>
