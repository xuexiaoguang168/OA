<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.visual.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<%
String priv="read";
if (!privilege.isUserPrivValid(request,priv))
{
	// out.println(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	// return;
}
String myname = privilege.getUser( request );

String op = ParamUtil.get(request, "op");
String action = ParamUtil.get(request, "action"); // 用于有sales管理权限的人员管理时
String formCode = ParamUtil.get(request, "formCode");
if (formCode.equals("")) {
	out.print(SkinUtil.makeErrMsg(request, "编码不能为空！"));
	return;
}

FormMgr fm = new FormMgr();
FormDb fd = fm.getFormDb(formCode);
%>
<title>智能设计-查询</title>
<script src="<%=Global.getRootPath()%>/inc/flow_dispose_js.jsp"></script>
<script>
function setradio(myitem,v)
{
     var radioboxs = document.all.item(myitem);
     if (radioboxs!=null)
     {
       for (i=0; i<radioboxs.length; i++)
          {
            if (radioboxs[i].type=="radio")
              {
                 if (radioboxs[i].value==v)
				 	radioboxs[i].checked = true;
              }
          }
     }
}
</script>
<br />
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="0" class="main">
  <tr>
    <td align="left" class="right-title">&nbsp;<%=fd.getName()%></td>
  </tr>
  <tr>
    <td><br />
      <table cellspacing="1" width="98%" align="center" border="0">
	  <%
	  com.redmoon.oa.visual.Config cfg = new com.redmoon.oa.visual.Config();
	  String listViewPage = Global.getRootPath() + "/" + cfg.getView(formCode, "list");
	  %>
        <form action="<%=listViewPage%>?op=search" method="post" name="form2" id="form2">
          <tr>
            <td colspan="3" nowrap="nowrap"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td colspan="3"><b>表单数据信息（表单名称：<%=fd.getName()%>）</b> </td>
                </tr>
                <%
			Iterator ir = fd.getFields().iterator();
			while (ir.hasNext()) {
				FormField ff = (FormField)ir.next();
			%>
                <tr>
                  <td width="29%"><%=ff.getTitle()%>：</td>
                  <td width="19%" nowrap="nowrap"><%if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {%>
                    从
                    <input size="10" name="<%=ff.getName()%>FromDate" />
                    <img style="CURSOR: hand" onclick="SelectDate('<%=ff.getName()%>FromDate', 'yyyy-MM-dd')" src="<%=Global.getRootPath()%>/images/form/calendar.gif" align="absmiddle" border="0" width="26" height="26" />
                <%}else{%>
                <select name="<%=ff.getName()%>_cond">
                  <option value="1">等于</option>
                  <%if (ff.getType().equals(ff.TYPE_TEXTFIELD) || ff.getType().equals(ff.TYPE_TEXTAREA) || ff.getType().equals(ff.TYPE_MACRO) || ff.getType().equals(ff.TYPE_SELECT)) {%>
                  <option value="0" selected="selected">包含</option>
                  <%}%>
                </select>
                <%}%>                  </td>
                  <td width="52%"><%if (ff.getType().equals(ff.TYPE_DATE) || ff.getType().equals(ff.TYPE_DATE_TIME)) {%>
                    至
                    <input size="10" name="<%=ff.getName()%>ToDate" />
                    <img style="CURSOR: hand" onclick="SelectDate('<%=ff.getName()%>ToDate', 'yyyy-MM-dd')" src="<%=Global.getRootPath()%>/images/form/calendar.gif" align="absmiddle" border="0" width="26" height="26" />
                <%}else{%>
                <input name="<%=ff.getName()%>" />
                <%}%>
                    (<%=ff.getTypeDesc()%>) </td>
                </tr>
                <%}%>
            </table></td>
          </tr>
          <tr align="middle">
            <td height="35" colspan="3" align="center" nowrap="nowrap"><input name="submit" type="submit" class="BigButton"  value="查  询" />
            &nbsp;&nbsp;&nbsp;
            <input type="hidden" name="action" value="<%=action%>" />            &nbsp;</td>
          </tr>
          <tr>
            <td width="684"></tbody></td>
          </tr>
        </form>
    </table></td>
  </tr>
</table>
