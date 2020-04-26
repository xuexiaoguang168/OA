<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*,
				 java.text.*,
				 cn.js.fan.util.*,
				 cn.js.fan.module.cms.*,
				 cn.js.fan.cache.jcs.*,
				 cn.js.fan.web.*,
				 cn.js.fan.module.pvg.*"
%>
<%@ taglib uri="/WEB-INF/tlds/LabelTag.tld" prefix="lt" %>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../common.css" rel="stylesheet" type="text/css">
<link href="default.css" rel="stylesheet" type="text/css">
<%
String priv="class";
String op = ParamUtil.get(request, "op");
RMCache rmcache = RMCache.getInstance();
if (op.equals("startcache")) {
	rmcache.setCanCache(true);
}

if (op.equals("stopcache")) {
	rmcache.setCanCache(false);
}

if (op.equals("clear")) {
	rmcache.clear();
}

if (op.equals("refreshfulltext")) {
	DocCacheMgr dcm = new DocCacheMgr();
	dcm.refreshFulltext();
}

if (op.equals("reloadConfig")) {
	Global.init();
}
%>
<%!	// global variables

	// decimal formatter for cache values
	static final DecimalFormat mbFormat = new DecimalFormat("#0.00");
	static final DecimalFormat percentFormat = new DecimalFormat("#0.0");
    // variable for the VM memory monitor box
    static final int NUM_BLOCKS = 50;
%>
<p>

<font size="-1">
</font><font size="-1"><b>
<jsp:useBean id="privilege" scope="page" class="cn.js.fan.module.pvg.Privilege"/>
<jsp:useBean id="backup" scope="page" class="cn.js.fan.util.Backup"/>
<jsp:useBean id="cfg" scope="page" class="cn.js.fan.web.Config"/>
<%
if (!privilege.isUserPrivValid(request, Priv.PRIV_ADMIN))
{
	out.print(cn.js.fan.web.SkinUtil.makeErrMsg(request, cn.js.fan.web.SkinUtil.LoadString(request, "pvg_invalid")));
	return;
}
%>
</b></font>
<table cellSpacing="0" cellPadding="0" width="100%">
  <tbody>
    <tr>
      <td class="head"><lt:Label res="res.label.blog.admin.cache" key="system_info"/></td>
    </tr>
  </tbody>
</table>
<br>
<TABLE 
style="BORDER-RIGHT: #a6a398 1px solid; BORDER-TOP: #a6a398 1px solid; BORDER-LEFT: #a6a398 1px solid; BORDER-BOTTOM: #a6a398 1px solid" 
cellSpacing=0 cellPadding=3 width="95%" align=center>
  <!-- Table Head Start-->
  <TBODY>
    <TR>
      <TD class=thead style="PADDING-LEFT: 10px" noWrap width="70%"><font size="-1"><b><lt:Label res="res.label.blog.admin.cache" key="java_memory"/></b></font> </TD>
    </TR>
    <TR class=row style="BACKGROUND-COLOR: #fafafa">
      <TD height="175" align="center" style="PADDING-LEFT: 10px"><p>      
        <ul>
          <%	// The java runtime
	Runtime runtime = Runtime.getRuntime();

    double freeMemory = (double)runtime.freeMemory()/(1024*1024);
	double totalMemory = (double)runtime.totalMemory()/(1024*1024);
	double usedMemory = totalMemory - freeMemory;
	double percentFree = ((double)freeMemory/(double)totalMemory)*100.0;
    int free = 100-(int)Math.round(percentFree);
%>
          <table border=0>
            <tr>
              <td><font size="-1"><lt:Label res="res.label.blog.admin.cache" key="used_memory"/></font></td>
              <td><font size="-1"><%= mbFormat.format(usedMemory) %> MB</font></td>
            </tr>
            <tr>
              <td><font size="-1"><lt:Label res="res.label.blog.admin.cache" key="memory_total"/></font></td>
              <td><font size="-1"><%= mbFormat.format(totalMemory) %> MB</font></td>
            </tr>
          </table>
          <br>
          <table border=0>
            <td><table bgcolor="#000000" cellpadding="1" cellspacing="0" border="0" width="200" align=left>
          <td><table bgcolor="#000000" cellpadding="1" cellspacing="1" border="0" width="100%">
                <%    for (int i=0; i<NUM_BLOCKS; i++) {
        if ((i*(100/NUM_BLOCKS)) < free) {
    %>
                <td bgcolor="#00ff00" width="<%= (100/NUM_BLOCKS) %>%"><img src="images/blank.gif" width="1" height="15" border="0"></td>
                    <%		} else { %>
                    <td bgcolor="#006600" width="<%= (100/NUM_BLOCKS) %>%"><img src="images/blank.gif" width="1" height="15" border="0"></td>
                    <%		}
    }
%>
            </table></td>
              </table></td>
                <td><font size="-1"> &nbsp;<b><%= percentFormat.format(percentFree) %>% <lt:Label res="res.label.blog.admin.cache" key="free"/></b> </font> </td>
          </table>
          <br>
        </ul>
      </TD>
    </TR>
    <!-- Table Body End -->
    <!-- Table Foot -->
    <TR>
      <TD class=tfoot align=right><DIV align=right> </DIV></TD>
    </TR>
    <!-- Table Foot -->
  </TBODY>
</TABLE>
