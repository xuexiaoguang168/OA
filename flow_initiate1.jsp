<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.flow.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>发起流程</title>
<link href="common.css" rel="stylesheet" type="text/css">
<%@ include file="inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function form1_onsubmit() {
	if (form1.typeCode.value=="not") {
		alert("请选择正确的流程类型！");
		return false;
	}
}

function trim(strValue) 
{
	var r = strValue.replace(/^\s*|\s*$/g,"");
	alert(strValue + "\r\n" + r);
	return r;
}

function trimOptionText(strValue) 
{
	// 注意option中有全角的空格，所以不直接用trim
	var r = strValue.replace(/^　*|\s*|\s*$/g,"");
	return r;
}
//-->
</script>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE3 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="flow.init";
if (!privilege.isUserPrivValid(request, priv))
{
	out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

String op = ParamUtil.get(request, "op");
%>
<table width="494" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td height="23" valign="bottom" background="images/top-right.gif" class="right-title">&nbsp;&nbsp;创建流程</td>
  </tr>
  <tr> 
    <td valign="top">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	<form action="flow_initiate1_do.jsp" method=post name="form1" class="STYLE3" id=form1 onSubmit="return form1_onsubmit()">
      <tr>
        <td height="100" align="center" class="p14"><table width="88%" height="81"  border="0" cellpadding="0" cellspacing="0" class="p14">
            <tr>
              <td class="p14">流程类型
                ：
                <select name="typeCode" class="p14" onChange="if(this.options[this.selectedIndex].value=='not'){alert(this.options[this.selectedIndex].text+' 不能被选择！'); return false;} else form1.title.value=trimOptionText(this.options[this.selectedIndex].text)+'： '+form1.title.value; ">
                  <%
					Leaf lf = new Leaf();
					lf = lf.getLeaf("root");
					DirectoryView dv = new DirectoryView(lf);
					dv.ShowDirectoryAsOptions(request, out, lf, 1);
				  %> 
                </select>
				<%if (!op.equals("")) {%>
				<script>
				form1.typeCode.value = "<%=op%>";
				</script>
				<%}%>				</td>
            </tr>
            <tr>
              <td class="p14">流程名称 ：
			  <%
			  java.util.Date d = new java.util.Date();
			  %>
                <input name="title" type="text" size="50" value="[<%=DateUtil.format(d, "yyyy-MM-dd HH:mm:ss")%>]"></td>
            </tr>
          </table>
          <br>          </td>
      </tr>
      <tr>
        <td height="30" align="center"><input type="submit" name="next" value="下一步">          </td>
      </tr></form>
    </table></td>
  </tr>
</table>
<br>
<br>
</body>
</html>
