<%@ page contentType="text/html;charset=gb2312"%><%@page import="cn.js.fan.util.*"%><%@page import="cn.js.fan.web.*"%><%@page import="com.redmoon.forum.*"%><%@page import="com.redmoon.forum.person.*"%><%@page import="com.redmoon.forum.plugin.*"%><%@page import="com.redmoon.forum.plugin.base.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="java.net.*"%><jsp:useBean id="privilege" scope="page" class="com.redmoon.forum.Privilege"/><%
if (!privilege.isUserLogin(request)) {
	if (!ForumDb.getInstance().canGuestSeeAttachment()) {
		response.sendRedirect("../info.jsp?op=login&info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "info_please_login")));
		return;	
	}
}

int msgId = ParamUtil.getInt(request, "msgId");

MsgDb md = new MsgDb();
md = md.getMsgDb(msgId);

if (md==null || !md.isLoaded()) {
	out.print("<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>");
	out.println("Topic not found!");
	return;
}

if (!privilege.canUserDo(request, md.getboardcode(), "attach_download")) {
	response.sendRedirect("../info.jsp?info=" + StrUtil.UrlEncode(SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}

int attachId = ParamUtil.getInt(request, "attachId");
Attachment att = md.getAttachment(attachId);

// 检查该附件下载是否需付费
String groupCode = "";
if (privilege.isUserLogin(request)) {
   UserDb ud = new UserDb();
   ud = ud.getUser(privilege.getUser(request));
   groupCode = ud.getGroupCode();
   // 取得用户所在组
   if (groupCode.equals(""))
   		groupCode = UserGroupDb.EVERYONE;
}
else {
	groupCode = UserGroupDb.GUEST;
}

// 检查用户在此版块下载是否需付费
UserGroupPrivDb ugpd = new UserGroupPrivDb();
ugpd = ugpd.getUserGroupPrivDb(groupCode, md.getboardcode());
String moneyCode = StrUtil.getNullStr(ugpd.getString("money_code"));
if (!moneyCode.equals("")) {
	int sum = ugpd.getInt("money_sum");
	if (sum>0) {
		// 检查用户的金额是否足够
		ScoreMgr sm = new ScoreMgr();
		ScoreUnit su = sm.getScoreUnit(moneyCode);
		IPluginScore isc = su.getScore();
		if (isc != null) {
		   try {
			   isc.pay(privilege.getUser(request), isc.SELLER_SYSTEM, sum);
		   } catch (ResKeyException e) {
				out.print(SkinUtil.makeErrMsg(request, e.getMessage(request)));
				return;
		   }
		}
	}
}
// response.setContentType(MIMEMap.get(StrUtil.getFileExt(att.getDiskName())));
// response.setContentType(MIMEMap.get(att.getExt()));
// response.setHeader("Content-disposition","filename=" + StrUtil.GBToUnicode(att.getName()));

// 以询问下载的方式打开，会覆盖父窗口
response.setContentType("application/octet-stream");
response.setHeader("Content-disposition","attachment; filename=" + StrUtil.GBToUnicode(att.getName()));

BufferedInputStream bis = null;
BufferedOutputStream bos = null;

String filePath = application.getRealPath("/") + "forum/" + att.getVisualPath() + "/" + att.getDiskName();
try {
	bis = new BufferedInputStream(new FileInputStream(filePath)); // att.getFullPath()));
	bos = new BufferedOutputStream(response.getOutputStream());
	
	byte[] buff = new byte[2048];
	int bytesRead;
	
	while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	bos.write(buff,0,bytesRead);
	}

} catch(final IOException e) {
	System.out.println( "IOException: " + e );
} finally {
	if (bis != null)
		bis.close();
	if (bos != null)
		bos.close();
}

att.setDownloadCount(att.getDownloadCount() + 1);
att.save();
%>