<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.redmoon.oa.visual.*"%>
<%@ page import="com.redmoon.oa.flow.*"%>
<link href="common.css" rel="stylesheet" type="text/css">
<%
String op = ParamUtil.get(request, "op");

String formCode = ParamUtil.get(request, "formCode");
// formCode = "contract";
if (formCode.equals("")) {
	out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

FormMgr fm = new FormMgr();
FormDb fd = fm.getFormDb(formCode);
if (fd==null || !fd.isLoaded()) {
	out.println(StrUtil.Alert("表单不存在！"));
	return;
}

if (op.equals("saveformvalue")) {
	boolean re = false;
	com.redmoon.oa.visual.FormDAOMgr fdm = new com.redmoon.oa.visual.FormDAOMgr(fd);
	try {
		re = fdm.create(application, request);
	}
	catch (ErrMsgException e) {
		out.print(StrUtil.Alert(e.getMessage()));
	}
	if (re) {
	  	com.redmoon.oa.visual.Config cfg = new com.redmoon.oa.visual.Config();
	  	String listViewPage = cfg.getView(formCode, "list");
		// System.out.println("visual_add.jsp formCode=" + formCode + " " + listViewPage);
		out.print(StrUtil.Alert_Redirect("保存成功！", Global.getRootPath() + "/"+ listViewPage));
		return;
	}
}
%>
<title>智能设计-添加内容</title>
<script src="<%=Global.getRootPath()%>/inc/flow_dispose_js.jsp"></script>
<script src="<%=Global.getRootPath()%>/inc/flow_js.jsp"></script>
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

function SubmitResult() {
	// 检查是否已选择意见
	if (getradio("resultValue")==null || getradio("resultValue")=="") {
		alert("您必须选择一项意见!");
		return false;
	}
	visualForm.op.value='finish';
	visualForm.submit();
}

// 控件完成上传后，调用Operate()
function Operate() {
	// alert(redmoonoffice.ReturnMessage);
}

function openWin(url,width,height)
{
  var newwin=window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,top=50,left=120,width="+width+",height="+height);
}

var attachCount = 1;
function AddAttach() {
	updiv.innerHTML += "<table width=100%><tr>文件&nbsp;<input type='file' name='filename" + attachCount + "' style='width:300px'><td></td></tr></table>";
	attachCount += 1;
}
</script>
<br />
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <form action="?op=saveformvalue&amp;formCode=<%=StrUtil.UrlEncode(formCode)%>" method="post" enctype="multipart/form-data" name="visualForm" id="visualForm">
    <tr>
      <td align="left"><%com.redmoon.oa.visual.Render rd = new com.redmoon.oa.visual.Render(request, fd);
			out.print(rd.rendForAdd());
		  %>文件&nbsp;
          <input type="file" name="filename" style="width: 300px" />
        &nbsp;&nbsp;
        <input name="button" type="button" onclick="AddAttach()" value="增加附件" />
        <div id="updiv" name="updiv"></div></td>
    </tr>
    <tr>
      <td height="30" align="center"><input type="submit" name="Submit" value=" 添 加 " />
        &nbsp;&nbsp;</td>
    </tr>
  </form>
</table>
