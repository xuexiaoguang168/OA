<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.io.*,
				 cn.js.fan.db.*,
				 cn.js.fan.util.*,
				 cn.js.fan.web.*,
				 com.redmoon.forum.*,
				 org.jdom.*,
                 java.util.*"
%>
<%
/**
 * $RCSfile: setup.jsp,v $
 * $Revision: 1.1.1.1 $
 * $Date: 2002/09/09 13:50:21 $
 *
 * Copyright (C) 1999-2001 CoolServlets, Inc. All rights reserved.
 *
 * This software is the proprietary information of CoolServlets, Inc.
 * Use is subject to license terms.
 */
%>

<%@ page import="java.io.*,
                 java.util.*,
                 java.lang.reflect.*"
%>
<%
XMLConfig cfg = new XMLConfig("config_oa.xml", false, "gb2312");
%>
<title>云网OA安装</title>
<link rel="stylesheet" type="text/css" href="../common.css">
<table cellpadding="6" cellspacing="0" border="0" width="100%">
<tr>
<td width="1%" valign="top"></td>
<td width="99%" valign="top">

    <b>欢迎您使用OA 版本<%=cfg.get("oa.version")%></b>
    <hr size="0">

    <font size="-1">
     在安装继续进行前，你的服务器环境必须通过以下所有检查: </font>

    <ul>
    <table border="0">
    <tr><td valign=top><img src="images/check.gif" width="13" height="13"></td>
        <td>
        <font size="-1">
        安装工具检测到你正运行在
        <%= application.getServerInfo() %>        </font>	    </td>
    </tr>

<%  // JDK check. See if they have Java2 or later installed by trying to
    // load java.util.HashMap.
    boolean isJDK1_2 = true;
    try {
        Class.forName("java.util.HashMap");
    }
    catch (ClassNotFoundException cnfe) {
        isJDK1_2 = false;
    }
    if (isJDK1_2) {
%>
	<tr><td valign=top><img src="images/check.gif" width="13" height="13"></td>
        <td>
		<font size="-1">
            你的JDK版本为1.2或者更新。		 </font>	    </td>
    </tr>
<%  }
    else {
%>
	<tr><td valign=top><img src="images/x.gif" width="13" height="13"></td>
        <td>
		<font size="-1">
            你的JDK版本好像低于JDK 1.2。因此安装不能继续。如果可能，请更新JDK版本并重新开始这个过程。     </font>	    </td>
    </tr>
<%  }

    // Servlet version check. The appserver must support at least support
    // the Servlet API 2.2.
    boolean servlet2_2 = true;
    try {
        Class sessionClass = session.getClass();
        Class[] setAttributeParams = new Class[1];
        setAttributeParams[0] = Class.forName("java.lang.String");
        Method getAttributeMethod = sessionClass.getMethod("getAttribute", setAttributeParams);
    }
    catch (SecurityException se) {
        // some class loaders might not let us do the reflection above, so use
        // the old method of finding the appserver version:
        servlet2_2 = application.getMajorVersion() >= 2
                        && application.getMinorVersion() >= 2;
    }
    catch (Exception e) {
        // ClassNotFoundException & MethodNotFoundException end up here.
        servlet2_2 = false;
    }
    if (servlet2_2) {
%>
	<tr><td valign=top><img src="images/check.gif" width="13" height="13"></td>
        <td>
		<font size="-1">
            你的应用服务器支持servlet 2.2或者更新。        </font>	    </td>
    </tr>
<%  }
    else {
%>
	<tr><td valign=top><img src="images/x.gif" width="13" height="13"></td><td>
		<font size="-1">     你的应用服务器不支持servlet 2.2或者更新。</font>
	</td></tr>
	<%
		}
	%>

	<%
		// cloudwebsoft
		boolean cloudInstalled = true;
		try {  Class.forName("com.redmoon.forum.MsgDb");  
		}
		catch (ClassNotFoundException cnfe) {  cloudInstalled = false;  }
		
        // workplan
		boolean workplanInstalled = true;
		try {  Class.forName("com.redmoon.oa.workplan.WorkPlanDb");
		}
		catch (ClassNotFoundException cnfe) { workplanInstalled = false; }
		
		// address
		boolean addressInstalled = true;
		try {  Class.forName("com.redmoon.oa.address.AddressDb");
		}
		catch (ClassNotFoundException cnfe) { addressInstalled = false; }
		
		// message
		boolean messageInstalled = true;
		try {  Class.forName("com.redmoon.oa.message.MessageDb");
		}
		catch (ClassNotFoundException cnfe) { messageInstalled = false; }
		
		// task
		boolean taskInstalled = true;
		try {  Class.forName("com.redmoon.oa.task.TaskDb");
		}
		catch (ClassNotFoundException cnfe) { taskInstalled = false; }
		
		// kaoqin
		boolean kaoqinInstalled = true;
		try {  Class.forName("com.redmoon.oa.kaoqin.KaoqinDb");
		}
		catch (ClassNotFoundException cnfe) { kaoqinInstalled = false; }
		
		// worklog
		boolean worklogInstalled = true;
		try {  Class.forName("com.redmoon.oa.worklog.WorkLogDb");
		}
		catch (ClassNotFoundException cnfe) { worklogInstalled = false; }
		
		// netdisk
		boolean netdiskInstalled = true;
		try {  Class.forName("com.redmoon.oa.netdisk.Leaf");
		}
		catch (ClassNotFoundException cnfe) { netdiskInstalled = false; }
		
		// book
		boolean bookInstalled = true;
		try {  Class.forName("com.redmoon.oa.book.BookDb");
		}
		catch (ClassNotFoundException cnfe) { bookInstalled = false; }
		
		// officeequip
		boolean officeequipInstalled = true;
		try {  Class.forName("com.redmoon.oa.officeequip.OfficeDb");
		}
		catch (ClassNotFoundException cnfe) { officeequipInstalled = false; }
		
		// asset
		boolean assetInstalled = true;
		try {  Class.forName("com.redmoon.oa.asset.AssetDb");
		}
		catch (ClassNotFoundException cnfe) { assetInstalled = false; }
		
		// vehicle
		boolean vehicleInstalled = true;
		try {  Class.forName("com.redmoon.oa.vehicle.VehicleDb");
		}
		catch (ClassNotFoundException cnfe) { vehicleInstalled = false; }
		
		// meeting
		boolean meetingInstalled = true;
		try {  Class.forName("com.redmoon.oa.meeting.BoardroomDb");
		}
		catch (ClassNotFoundException cnfe) { meetingInstalled = false; }
		
		// Lucene
		boolean luceneInstalled = true;
		try {  Class.forName("org.apache.lucene.document.Document");  }
		catch (ClassNotFoundException cnfe) {  luceneInstalled = false;  }

		// Lucene Chinese support
		boolean luceneChineseInstalled = true;
		try {  Class.forName("org.apache.lucene.analysis.cn.ChineseAnalyzer");  }
		catch (ClassNotFoundException cnfe) {  luceneChineseInstalled = false;  }

		// JavaMail
		boolean javaMailInstalled = true;
		try {
			Class.forName("javax.mail.Address");  // mail.jar
			Class.forName("javax.activation.DataHandler"); // activation.jar
			// Class.forName("dog.mail.nntp.Newsgroup"); // nntp.jar
		}
		catch (ClassNotFoundException cnfe) {  javaMailInstalled = false;  }

		// JDBC std ext
		boolean jdbcExtInstalled = true;
		try {  Class.forName("javax.sql.DataSource");  }
		catch (ClassNotFoundException cnfe) {  jdbcExtInstalled = false;  }

		boolean filesOK = cloudInstalled && workplanInstalled && addressInstalled && taskInstalled && kaoqinInstalled && worklogInstalled && messageInstalled && netdiskInstalled && bookInstalled && assetInstalled && officeequipInstalled && vehicleInstalled && meetingInstalled && javaMailInstalled && jdbcExtInstalled;
		if (filesOK) {
	%>
	<tr><td valign=top><img src="images/check.gif" width="13" height="13"></td><td>
		<font size="-1"> 所有的应用程序包都安装正确。
	<%  }
		else {
	%>
	<tr><td valign=top><img src="images/x.gif" width="13" height="13"></td><td>
		<font size="-1">一个或者多个应用程序包没有被安装。
	<%  }  %>
	<tr><td colspan="2" valign=top><ul>
		    <font size="-1"><img src="images/<%= workplanInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网工作流内核 (workplan.jar)
			<br> <img src="images/<%= addressInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网通讯录内核 (address.jar)
			<br> <img src="images/<%= taskInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网任务督办内核 (task.jar)
			<br> <img src="images/<%= messageInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网短消息内核 (message.jar)
			<br> <img src="images/<%= kaoqinInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网员工考勤内核 (kaoqin.jar)
			<br> <img src="images/<%= worklogInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网工作记事内核 (worklog.jar)
			<br> <img src="images/<%= netdiskInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网网络硬盘内核 (netdisk.jar)
			<br> <img src="images/<%= bookInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网图书管理内核 (book.jar)
			<br> <img src="images/<%= assetInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网资产管理内核 (asset.jar)
			<br> <img src="images/<%= vehicleInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网车辆管理内核 (vehicle.jar)
			<br> <img src="images/<%= officeequipInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网办工用品管理内核 (officeequip.jar)
			<br> <img src="images/<%= meetingInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网会议管理内核 (meeting.jar)
		    <br> <img src="images/<%= cloudInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    云网论坛内核 (forum.jar)
		    <br> <img src="images/<%= javaMailInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    JavaMail支持 (mail.jar, activation.jar,)
		    <br> <img src="images/<%= jdbcExtInstalled?"check.gif":"x.gif" %>" width="13" height="13">
		    JDBC 2.0 扩展 (jdbc2_0-stdext.jar)		    </font>
		  </ul></td></tr>

	<%
		//Check the status of JiveHome

		boolean propError = false;
		String errorMessage = null;
		String cloudHome = application.getRealPath("/");
		try {
			// Class jiveGlobals = Class.forName("com.jivesoftware.forum.JiveGlobals");

			// Method getJiveHome = jiveGlobals.getMethod("getJiveHome", null);
			// cloudHome = (String)getJiveHome.invoke(null, null);
			if (cloudHome != null) {
                // See if the cloudHome directory actually exists
                try {
                    File file = new File(cloudHome);
                    if (!file.exists()) {
                        propError = true;
                        errorMessage = "目录 <tt>" + cloudHome + "</tt> " +
                            "不存在。请编辑 <tt>jive_init.properties</tt> 文件" +
                            "指定正确的jiveHome目录。";
                    }
                }
                catch (Exception e) {}
                if (!propError) {
    				// See if cloudHome is readable and writable.
    				// Method jiveHomeReadable = jiveGlobals.getMethod("isJiveHomeReadable", null);
    				// boolean readable = ((Boolean)jiveHomeReadable.invoke(null, null)).booleanValue();
					boolean readable = (new File(cloudHome)).canRead();
    				if (!readable) {
    					propError = true;
    					errorMessage = "<tt>cloudHome</tt> 存在于<tt>" + cloudHome +
    					"</tt>, 但是你的应用服务器没有对它的读权限。请设置目录的权限修正此问题。";
    				}
    				// Method jiveHomeWritable = jiveGlobals.getMethod("isJiveHomeWritable", null);
    				// boolean writable = ((Boolean)jiveHomeWritable.invoke(null, null)).booleanValue();
					boolean writable = (new File(cloudHome)).canWrite();
    				if (!writable) {
    					propError = true;
    					errorMessage =  "<tt>cloudHome</tt> 存在于<tt>" + cloudHome +
    					"</tt>, 但是你的应用服务器没有对它的写权限。请设置目录的权限修正此问题。";
    				}
    				// Jive Home appears to exist and to be setup correctly. Make sure that all of the proper sub-dirs exist
    				// or create them as necessary.
    				File homeFile = new File(cloudHome);
    				String [] subDirs = new String [] { "log", "upfile" };
    				for (int i=0; i<subDirs.length; i++) {
    					File subDir = new File(cloudHome, subDirs[i]);
    					if (!subDir.exists()) {
    						subDir.mkdir();
    					}
    				}
                }
	    	}
        	else {
           		propError = true;
           		errorMessage = "<tt>cloudHome</tt> 目录设置不正确。请参考安装文档正确设置 <tt>jive_init.properties</tt> 文件中的值。";
        	}
		}
		catch (Exception e) {
			e.printStackTrace();
			propError = true;
           	errorMessage = "检查<tt>cloudHome</tt>目录时发生异常。" +
				"请确认你安装的是云网论坛程序是否完整！";
		}
		if (!propError) {
	%>
	<tr><td valign=top><img src="images/check.gif" width="13" height="13"></td>
	  <td>
		<tt>OA</tt> <font size="-1">目录正确配置于: </font><tt><%= cloudHome %></tt>.
	</td></tr>
	<%
		}
		else {
	%>
	<tr><td valign=top><img src="images/x.gif" width="13" height="13"></td><td>
		<font size="-1"><%= errorMessage %><font>
	</td></tr>
	<%
		}
	%>
</table>
</ul>

    <%
	if (propError || !isJDK1_2 || !servlet2_2) {
%>
	<font color="red" size="-1"><b>安装初始化检查过程中发现错误，请更正，然后重新启动服务器重新开始安装过程。</b></font>
<%
	}
	else {
%>
<form action="setup2.jsp">
    <hr size="0">
    <div align="center">
    <input type="submit" value="下一步">
    </form>
    <%
	}
%>
</td>
</tr>
</table>
