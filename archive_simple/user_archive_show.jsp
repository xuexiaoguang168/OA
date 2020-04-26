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
<title>查看用户档案</title>
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
%>
<table width="90%" border="0" align="center" cellPadding="2" cellSpacing="1" class="main">
  <form name="form1" action="?op=modify&name=<%=StrUtil.UrlEncode(name)%>" method="post" encType="multipart/form-data">
    <tbody>
      <tr>
        <td noWrap colSpan="3" class="right-title"><b>&nbsp;<%=name%>的基本信息</b></td>
      </tr>
      <tr>
        <td noWrap width="96">编号：</td>
        <td width="496"><%=uad.getId()%></td>
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
        <td><%=uad.getRealName()%></td>
      </tr>
      <tr>
        <td noWrap>性别：</td>
        <td>
		  <%=uad.getGender()==0?"女":"男"%></td>
      </tr>
      <tr>
        <td noWrap>出生日期：</td>
        <td noWrap><%=uad.getBirthday()==null?"":DateUtil.format(uad.getBirthday(), "yyyy-MM-dd")%></td>
      </tr>
      <tr>
        <td noWrap>民族：</td>
        <td><%=uad.getNation()%></td>
      </tr>
      <tr>
        <td noWrap>身份证号码：</td>
        <td><%=uad.getIDCard()%></td>
      </tr>
      <tr>
        <td noWrap>婚姻状况：</td>
        <td colSpan="2"><%
		  if (uad.getMarriage()==0)
		  	out.print("未婚");
		  else if (uad.getMarriage()==1)
		  	out.print("已婚");
		  else
		  	out.print("离婚");
		  %>		  </td>
      </tr>
      <tr>
        <td noWrap>籍贯：</td>
        <td colSpan="2"><%=uad.getJiGuan()%></td>
      </tr>
      <tr>
        <td noWrap>户口所在地：</td>
        <td colSpan="2"><%=uad.getHukouAddress()%></td>
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
        <td colSpan="2"><%=uad.getZhuanYe()%></td>
      </tr>
      <tr>
        <td noWrap>毕业院校：</td>
        <td colSpan="2"><%=uad.getSchool()%></td>
      </tr>
      <tr>
        <td noWrap>参加工作时间：</td>
        <td noWrap colSpan="2"><%=uad.getWorkDate()%></td>
      </tr>
      <tr>
        <td noWrap>加入本单位时间：</td>
        <td noWrap colSpan="2"><%=uad.getWorkDateAtHere()%></td>
      </tr>
      <tr>
        <td noWrap>部门：</td>
        <td colSpan="2"><%=uad.getDept()%></td>
      </tr>
      <tr>
        <td noWrap>职务：</td>
        <td colSpan="2"><%=uad.getZhiWu()%></td>
      </tr>
      <tr>
        <td noWrap>职称：</td>
        <td colSpan="2"><%=uad.getZhiChen()%></td>
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
        <td colSpan="2"><%=uad.getHomeAddress()%></td>
      </tr>
      <tr>
        <td noWrap>家庭电话：</td>
        <td colSpan="2"><%=uad.getHomeTel()%></td>
      </tr>
      <tr>
        <td noWrap>电子邮件：</td>
        <td colSpan="2"><%=uad.getEmail()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;岗位变动情况：</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getPostChange()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;教育背景</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getEducation()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;工作简历</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getResume()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;社会关系</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getSocialRelation()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;奖惩记录</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getJiangchenRecord()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;职务情况</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getZhiwuQinkuang()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;培训记录</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getTrainRecord()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;担保记录</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getDanbaoRecord()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;劳动合同签订情况</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getContract()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;社保缴纳情况</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getInsure()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;体检记录</td>
      </tr>
      <tr>
        <td colSpan="3"><%=uad.getTijianRecord()%></td>
      </tr>
      <tr>
        <td class="TableHeader" noWrap colSpan="3">&nbsp;备 注</td>
      </tr>
      <tr>
        <td colSpan="3"><span class="TableHeader"><b><%=uad.getRemark()%>
        </b></span></td>
      </tr>
    </tbody>
  </form>
</table>
</body>
</html>
