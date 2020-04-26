<title>档案查询</title><%@ page contentType="text/html; charset=utf-8"%><%@ page import = "java.util.*"%><%@ page import = "cn.js.fan.db.*"%><%@ page import = "cn.js.fan.util.*"%><%@ page import = "com.redmoon.oa.archive.*"%><%@ page import="cn.js.fan.web.*"%><%@ page import="java.io.*"%><%
String sql = ParamUtil.get(request, "sql");
String showFieldName = ParamUtil.get(request, "showFieldName");
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-disposition","attachment; filename="+StrUtil.GBToUnicode("档案查询"));  
ArchiveExcelHandle.writeExcel(response.getOutputStream(),showFieldName,sql); 
%>