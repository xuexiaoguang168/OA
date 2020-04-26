<%@ page contentType="text/html; charset=utf-8"%><%@ page import = "java.util.*"%><%@ page import = "cn.js.fan.db.*"%><%@ page import = "cn.js.fan.util.*"%><%@ page import = "com.redmoon.oa.address.*"%><%@ page import="cn.js.fan.web.*"%><%@ page import="java.io.*"%><%
String sql = ParamUtil.get(request, "sql");
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-disposition","attachment; filename="+StrUtil.GBToUnicode("通讯录"));  
// File fileWrite = new File("f:/testWrite.xls");
// fileWrite.createNewFile();
// new FileOutputStream(fileWrite);
// ExcelHandle.writeExcel(new FileOutputStream(fileWrite));
ExcelHandle.writeExcel(response.getOutputStream(),sql); // new FileOutputStream(fileWrite));
%>