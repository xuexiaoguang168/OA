<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<%@ page import = "com.redmoon.oa.BasicDataMgr"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加资产</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%@ include file="../inc/nocache.jsp"%>
<script language="JavaScript" type="text/JavaScript">
<!--
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
function setPerson(deptCode, deptName, user, userRealName)
{
	form1.keeper.value = user;
	form1.keeperRealName.value = userRealName;	
}
//-->
</script>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="oa.asset";
if (!privilege.isUserPrivValid(request, priv)) {
	out.println(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
String op = ParamUtil.get(request, "op");
if (op.equals("add")) {
	AssetMgr am = new AssetMgr();
	boolean re = false;
	try {
		  re = am.create(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		out.print(StrUtil.Alert_Redirect("操作成功！", "asset_add.jsp"));

}%>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE5 {color: #FF0000}
.STYLE7 {color: #FFFFFF}
-->
</style>
</head>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
<%@ include file="asset_inc_menu_top.jsp"%>
<br>
  <table width="580" height="89" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tableframe">
  <tr> 
    <td width="580" height="23" valign="bottom" class="right-title" >&nbsp;<span class="STYLE7">&nbsp;添加资产</span></td>
  </tr>
  <tr> 
    <td valign="top"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
      <TBODY>
        <TR>
          <TD vAlign="top"><TABLE width="100%" border="0" bordercolor="#CCCCCC">
            <FORM name="form1" action="?op=add" method="post">
              <TBODY>
                <TR>
                  <TD align="right" width="15%">资产名称：</TD>
                  <TD width="37%"><INPUT name="name" id="name" maxLength="255">
                      <span class="STYLE5"> *</span> </TD>
                  <TD align="right" width="12%">型 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
                  <TD width="36%"><INPUT name="type" id="type" maxLength="255">                  </TD>
                </TR>
                <TR>
                  <TD align="right">资产编号：</TD>
                  <TD><INPUT name="number" id="number" maxLength="25">
                      <span class="STYLE5"> *</span></TD>
                  <TD align="right">资产价值：</TD>
                  <TD><INPUT name="price" id="price" value="0" maxLength="10">
                    (元)</TD>
                </TR>
                <TR>
                  <TD align="right">资产类别：</TD>
                  <TD><%
					  AssetTypeDb atd = new AssetTypeDb();
					  String opts = "";
					  Iterator ir = atd.list().iterator();
					  while (ir.hasNext()) {
						 atd = (AssetTypeDb)ir.next();
						 opts += "<option value='" + atd.getId() + "'>" + atd.getName() + "</option>";
					  }
					  %>
                      <select name="typeId" id="typeId" >
                        <option value=0 selected>---请选择---</option>
                        <%=opts%>
                      </select>
                      <span class="STYLE5"> *</span> </TD>
                  <TD align="right">资产归属：</TD>
                  <TD><select name="department">
                      <%
									DeptMgr dm = new DeptMgr();
									DeptDb lf = dm.getDeptDb(DeptDb.ROOTCODE);
									DeptView dv = new DeptView(lf);
									dv.ShowDeptAsOptions(out, lf, lf.getLayer()); 
								 %>
                    </select>
                      <span class="STYLE5">*
                        <%
														   Date d = new Date();
														   String dt = DateUtil.format(d, "yyyy-MM-dd");
														 %>
                    </span></TD>
                </TR>
                <TR>
                  <TD align="right">购&nbsp;&nbsp;置&nbsp;&nbsp;人：</TD>
                  <TD><INPUT name="buyMan" id="buyMan" maxLength="25">                  </TD>
                  <TD align="right">购置时间：</TD>
                  <TD><INPUT name="buyDate" id="buyDate" maxLength="10" value="<%=dt%>">
                      <img style="CURSOR: hand" onClick="SelectDate('buyDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> </TD>
                </TR>
                <TR>
                  <TD align="right">领用时间：</TD>
                  <TD id="td_com"><input name="startDate" id="startDate" maxlength="10">
                      <img style="CURSOR: hand" onClick="SelectDate('startDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></TD>
                  <TD align="right">保&nbsp;&nbsp;管&nbsp;&nbsp;人：</TD>
                  <TD id="user">
				  <INPUT name="keeperRealName" id="keeperRealName" maxLength="10" width="80">
				  <INPUT name="keeper" id="keeper" maxLength="10" width="80" type="hidden">
                    <a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')"> 选择用户</a> </TD>
                </TR>
                <TR>
                  <TD align="right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 注：</TD>
                  <TD><TEXTAREA name="abstracts" id="abstracts"></TEXTAREA>                  </TD>
                  <TD align="right">增加方式：</TD>
                  <TD>
				  <%
				  BasicDataMgr bdm = new BasicDataMgr("asset");
				  String options = bdm.getOptionsStr("增加方式");
				  %>
                    <select name="addId" id="addId">
					<%=options%>
					</select></TD>
                </TR>
                <TR>
                  <TD align="right">登&nbsp;&nbsp;记&nbsp;&nbsp;人： </TD>
                  <TD><INPUT name="InputMan" ></TD>
                  <TD align="right">登记时间：</TD>
                  <TD><INPUT id="regDate"  name="regDate" value="<%=dt%>"></TD>
                </TR>
                <TR>
                  <TD colspan="4" align="right"><input name="button" type="submit" class="button1"  value="  确定  ">
  
  <input name="button" type="button" class="button1" onClick="window.close()" value="  取消  ">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                  </TR>
              </TBODY>
            </FORM>
          </TABLE></TD>
        </TR>
      </TBODY>
    </TABLE>    </td>
  </tr>
</table>
<br>
<br>
</body>
</html>
