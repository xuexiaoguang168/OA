<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %><%@page import="cn.js.fan.util.*"%><%@page import="cn.js.fan.web.*"%><%@page import="cn.js.fan.module.cms.*"%><%@page import="java.util.*"%><%@page import="java.io.*"%><%@page import="java.net.*"%><%
  int id = ParamUtil.getInt(request, "id");
  int attId = ParamUtil.getInt(request, "attachId");
  int pageNum = 1;
  String pn = ParamUtil.get(request, "pageNum");
  if (StrUtil.isNumeric(pn))
  	pageNum = Integer.parseInt(pn);

  Document mmd = new Document();
  mmd = mmd.getDocument(id);
  Attachment att = mmd.getAttachment(pageNum, attId);
  
  String s = Global.getRealPath() + att.getVisualPath() + "/" + att.getDiskName();
  
  att.setDownloadCount(att.getDownloadCount() + 1);
  att.save();
  
  //String s = "e:\\tree.mdb"; 
  // RandomAccessFile Ҳʵ,Ȥɽעȥ,ע͵ FileInputStream 汾
  //java.io.RandomAccessFile raf = new java.io.RandomAccessFile(s,"r");

  java.io.File f = new java.io.File(s);
  java.io.FileInputStream fis = new java.io.FileInputStream(f);

  response.reset();

  //response.setHeader("Server", "playyuer@Microshaoft.com");

  //߿ͻϵ߳
  //Ӧĸʽ:
  //Accept-Ranges: bytes
  response.setHeader("Accept-Ranges", "bytes");

  long p = 0;
  long l = 0;
  //l = raf.length();
  l = f.length();

  //ǵһ,ûжϵ,״̬Ĭϵ 200,ʽ
  //Ӧĸʽ:
  //HTTP/1.1 200 OK

  if (request.getHeader("Range") != null) //ͻصļĿʼֽ
  {
   //ļķΧȫ,ͻֲ֧ʼļ
   //Ҫ״̬
   //Ӧĸʽ:
   //HTTP/1.1 206 Partial Content
   response.setStatus(javax.servlet.http.HttpServletResponse.SC_PARTIAL_CONTENT);//206

   //еõʼֽ
   //ĸʽ:
   //Range: bytes=[ļĿʼֽ]-
   p = Long.parseLong(request.getHeader("Range").replaceAll("bytes=","").replaceAll("-",""));
  }

  //صļ()
  //Ӧĸʽ:
  //Content-Length: [ļܴС] - [ͻصļĿʼֽ]
  response.setHeader("Content-Length", new Long(l - p).toString()); 

  if (p != 0)
  {
   //Ǵʼ,
   //Ӧĸʽ:
   //Content-Range: bytes [ļĿʼֽ]-[ļܴС - 1]/[ļܴС]
   response.setHeader("Content-Range","bytes " + new Long(p).toString() + "-" + new Long(l -1).toString() + "/" + new Long(l).toString());
  }

  //response.setHeader("Connection", "Close"); //д˾仰 IE ֱ

  //ʹͻֱ
  //Ӧĸʽ:
  //Content-Type: application/octet-stream
  response.setContentType("application/octet-stream");

  //ΪͻָĬϵļ
  //Ӧĸʽ:
  //Content-Disposition: attachment;filename="[ļ]"
  //response.setHeader("Content-Disposition", "attachment;filename=\"" + s.substring(s.lastIndexOf("\\") + 1) + "\""); // RandomAccessFile Ҳʵ,Ȥɽעȥ,ע͵ FileInputStream 汾
  response.setHeader("Content-Disposition", "attachment;filename=\"" + StrUtil.GBToUnicode(att.getName()) + "\"");

  //raf.seek(p);
  fis.skip(p);

  byte[] b = new byte[1024]; 
  int i;

  //while ( (i = raf.read(b)) != -1 ) // RandomAccessFile Ҳʵ,Ȥɽעȥ,ע͵ FileInputStream 汾
  while ( (i = fis.read(b)) != -1 )
  {
   response.getOutputStream().write(b,0,i);
  }
  //raf.close();// RandomAccessFile Ҳʵ,Ȥɽעȥ,ע͵ FileInputStream 汾
  fis.close();
%>