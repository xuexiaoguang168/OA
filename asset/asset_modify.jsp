<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.net.URLEncoder"%>
<%@ page import = "java.util.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.asset.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "com.redmoon.oa.dept.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资产修改</title>
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
function setPerson(deptCode, deptName, user)
{
	form1.keeper.value = user;	
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
if (op.equals("modify")) {
	AssetMgr am = new AssetMgr();
	boolean re = false;
	try {
		  re = am.modify(request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re)
		{//out.print(StrUtil.Alert_Redirect("操作成功！", "officeequip_type_list.jsp"));
%>
    <script>
		window.opener.location.reload();
		window.close();
	</script>
<%}}%>
<style type="text/css">
<!--
.style2 {font-size: 14px}
.STYLE5 {color: #FF0000}
-->
</style>
</head>
<%
 int id = ParamUtil.getInt(request, "id");
 AssetDb adb = new AssetDb();
 AssetTypeDb btdb = new AssetTypeDb();
 adb = adb.getAssetDb(id);
 int typeId = adb.getTypeId();
 btdb = btdb.getAssetTypeDb(typeId);
%>
<body background="" leftmargin="0" topmargin="5" marginwidth="0" marginheight="0">
<jsp:useBean id="fchar" scope="page" class="cn.js.fan.util.StrUtil"/>
  <table width="580" height="89" border="0" align="center" cellpadding="0" cellspacing="0" class="tableframe">
  <tr class="right-title"> 
    <td width="580" height="23" >&nbsp;&nbsp;资产修改</td>
  </tr>
  <tr> 
    <td valign="top"><TABLE width="100%" border="0" bordercolor="#CCCCCC" bgcolor="#FFFFFF">
      <FORM name="form1" action="?op=modify " method="post">
        <TBODY>
          <TR>
            <TD align="right" width="15%">资产名称：</TD>
            <TD width="37%"><INPUT name="name" id="name" maxLength="255" value="<%=adb.getName()%>">
                <span class="STYLE5"> *</span>
              </input>
              <input type=hidden name="id" value="<%=adb.getId()%>"></TD>
            <TD align="right" width="12%">型 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;号：</TD>
            <TD width="36%"><INPUT name="type" id="type" maxLength="255" value="<%=adb.getType()%>" >
            </TD>
          </TR>
          <TR>
            <TD align="right">资产编号：</TD>
            <TD><INPUT name="number" id="number" maxLength="25" value="<%=adb.getNumber()%>">
                <span class="STYLE5"> *</span></TD>
            <TD align="right">资产价值：</TD>
            <TD><INPUT name="price" id="price" value="<%=adb.getPrice()%>" maxLength="10">
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
                  <option selected>---请选择---</option>
                  <%=opts%>
                </select>
                <script>
							     form1.typeId.value = "<%=atd.getId()%>"
							  </script>
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
                <span class="STYLE5">* </span>
                <script>
		                    form1.department.value = "<%=adb.getDepartment()%>";
		                    </script>
            </TD>
          </TR>
          <TR>
            <TD align="right">购&nbsp;&nbsp;置&nbsp;&nbsp;人：</TD>
            <TD><INPUT name="buyMan" id="buyMan" maxLength="25" value="<%=adb.getBuyMan()%>">
            </TD>
            <TD align="right">购置时间：</TD>
            <TD><INPUT name="buyDate" id="buyDate" maxLength="10" value="<%=adb.getBuyDate()%>">
                <img style="CURSOR: hand" onClick="SelectDate('buyDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"> </TD>
          </TR>
          <TR>
            <TD align="right">领用时间：</TD>
            <TD id="td_com"><input name="startDate" id="startDate" maxlength="10" value="<%=DateUtil.format(adb.getStartDate(), "yyyy-MM-dd")%>">
                <img style="CURSOR: hand" onClick="SelectDate('startDate', 'yyyy-MM-dd')" src="../images/form/calendar.gif" align="absMiddle" border="0" width="26" height="26"></TD>
            <TD align="right">保&nbsp;&nbsp;管&nbsp;&nbsp;人：</TD>
            <TD id="user"><INPUT name="keeper" id="keeper" maxLength="10" width="80" value="<%=adb.getKeeper()%>">
              <a href="#" onClick="javascript:showModalDialog('../user_sel.jsp',window.self,'dialogWidth:480px;dialogHeight:320px;status:no;help:no;')"> 用户</a> </TD>
          </TR>
          <TR>
            <TD align="right">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 注：</TD>
            <TD><TEXTAREA name="abstracts" id="abstracts" ><%=adb.getAbstracts()%></TEXTAREA>
            </TD>
            <TD align="right">&nbsp;增加方式：</TD>
            <TD><select name="addId" id="addId">
                <option>购入</option>
                <option>自建</option>
                <option>融资租入</option>
                <option>接受投资</option>
                <option>接受捐赠</option>
                <option>盘赢</option>
                <option>增加零部件</option>
                <option>其它</option>
              </select>
            </TD>
          </TR>
          <TR>
            <TD align="right">登&nbsp;&nbsp;记&nbsp;&nbsp;人： </TD>
            <TD><INPUT name="InputMan"  value="<%=adb.getInputMan()%>"></TD>
            <TD align="right">登记时间：</TD>
            <TD><INPUT id="regDate"  name="regDate" value="<%=adb.getRegDate()%>"></TD>
          </TR>
          <TR>
            <TD colspan="4" align="center"><input name="button2" type="submit" class="button1"  value="  确定  " >
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input name="button" type="button" class="button1" onClick="window.close()" value="  取消  ">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
          </TR>
        </TBODY>
      </FORM>
    </TABLE></td>
  </tr>

</table>
<br>
<br>
</body>
</html>
