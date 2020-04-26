<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "java.io.*"%>
<%@ page import = "cn.js.fan.web.*"%>
<%@ page import = "cn.js.fan.db.*"%>
<%@ page import = "cn.js.fan.util.*"%>
<%@ page import = "com.redmoon.oa.address.*"%>
<%@ page import = "com.redmoon.oa.pvg.Privilege"%>
<jsp:useBean id="privilege" scope="page" class="com.redmoon.oa.pvg.Privilege"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>通讯录</title>
<link href="../common.css" rel="stylesheet" type="text/css">
<%
	String strtype = ParamUtil.get(request, "type");
	String strgroup = ParamUtil.get(request, "group");
	int group = 0;
	if (!strgroup.equals(""))
		group = ParamUtil.getInt(request, "group");
	int type = AddressDb.TYPE_USER;
	if (!strtype.equals(""))
		type = Integer.parseInt(strtype);
	if (type==AddressDb.TYPE_PUBLIC) {
		if (!privilege.isUserPrivValid(request, "admin.address.public")) {
			out.print(SkinUtil.makeErrMsg(request, SkinUtil.LoadString(request, "pvg_invalid")));
			return;
		}
	}
	String username = privilege.getUser(request);
	FileUpMgr fum = new FileUpMgr();
	boolean re = false;
	String op = ParamUtil.get(request, "op");
	String excelFile="";
	if (op.equals("add")) {
		try {
			excelFile = fum.uploadExcel(application, request);
			System.out.println("import_excel.jsp " + excelFile);
			//ExcelRead er = new ExcelRead(excelFile, username, type, group);
			if (!excelFile.equals("")) {
				ExcelRead er = new ExcelRead();
				er.Excelhad(excelFile, username, type, group);
				//out.print(excelFile);
				File file = new File(excelFile);
				file.delete();
%>
				<script>
				alert("导入成功，点击确定后请刷新页面查看导入结果!");
				window.close();
				</script>
<%			}
			else
				out.print(StrUtil.Alert("文件不能为空！"));
		}
		catch (ErrMsgException e) {
			out.print(StrUtil.Alert_Back(e.getMessage()));
		}
	}
%>
</head>
<body>
<table width="325" border="0" align="center" cellspacing="0" class="tableframe">
  <form name="form1" action="?op=add&type=<%=type%>&group=<%=group%>" method="post" encType="multipart/form-data">
    <tr>
      <td class="right-title">&nbsp;请选择Outlook导入的文件：</td>
    </tr>
    <tr>
      <td width="319" align="center">
        <input title="选择附件文件" type="file" size="30" name="excel">
		<input name="type" value="<%=type%>" type=hidden>
		</td>
    </tr>
    <tr>
      <td align="center"><input name="submit" type="submit" value="确  定">&nbsp;&nbsp;</td>
    </tr>
  </form>
</table>
</body>
</html>
