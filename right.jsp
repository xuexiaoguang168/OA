<%@ page contentType="text/html;charset=gb2312" %>
<HTML><HEAD><TITLE>Left Menu</TITLE>
<link rel="stylesheet" href="oa.css">
<SCRIPT language=JavaScript src="lefttree.js"></script>

<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY bgColor=white class=menubar leftMargin=4 
oncontextmenu=self.event.returnValue=false;showmenu() 
ondragstart=self.event.returnValue=false 
onselectstart=self.event.returnValue=false rightMargin=0 topMargin=8 onload="AllClose();">
<BR>
<DIV id=menutool style="DISPLAY: none">
<TABLE cellPadding=0 cellSpacing=0 class=menus>
  <TBODY>
  <TR>
        <TD width=80 height=20 align="center" bgcolor="#333333"> <NOBR><font color="#ffffff">��ͼ&nbsp;&nbsp;OA</font></NOBR></TD>
      </TR>  
  <TR>
    <TD height=20 onclick=AllOpen();hidemenu() 
    onmouseout="this.style.backgroundColor='';this.style.color='';" 
    onmouseover="this.style.backgroundColor='darkblue';this.style.color='white';" 
    width=80><NOBR>&nbsp;&nbsp;ȫ����</NOBR></TD></TR>
  <TR>
    <TD height=20 onclick=AllClose();hidemenu() 
    onmouseout="this.style.backgroundColor='';this.style.color='';" 
    onmouseover="this.style.backgroundColor='darkblue';this.style.color='white';">
    <NOBR>&nbsp;&nbsp;ȫ���ر�</NOBR></TD></TR>
  <TR>
    <TD height=20 onclick=self.location.reload();hidemenu() 
    onmouseout="this.style.backgroundColor='';this.style.color='';" 
    onmouseover="this.style.backgroundColor='darkblue';this.style.color='white';">
    <NOBR>&nbsp;&nbsp;ˢ&nbsp;&nbsp;��</NOBR></TD></TR></TBODY></TABLE></DIV>
<DIV><IMG src="images/left/icon_unctitle.gif"></DIV>
<DIV></DIV>
<DIV><img align=absMiddle alt="" border=0 src="images/left/t.gif"><IMG 
align=absMiddle alt="" border=0 src="images/left/icon_newmail.gif"> <A 
class=item href="javascript:;" 
onclick="onCoolInfo()">���ʼ�</A></DIV>


<DIV><IMG align=absMiddle alt="" border=0 id=xingzheng 
onclick=swapimg(xingzheng,foldx,openx) src="images/left/tminus.gif" 
style="CURSOR: hand"><img align=absMiddle alt="" border=0 class=havechild
id=openx src="images/left/icon_folderopen.gif">&nbsp;��������</DIV>
<DIV class=off id=foldx>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('tongzhi.jsp')">�ڲ�֪ͨ</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('learn.jsp')">�ļ�ѧϰ</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;"
onclick="load_Href('addfile.jsp')">�ϱ��ļ�</A> 
</DIV></DIV>

<!--- my add start -->
<DIV><IMG align=absMiddle alt="" border=0 id=public 
onclick=swapimg(public,foldu,openu) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=openu src="images/left/icon_folderopen.gif"> ������Ϣ</DIV>
<DIV class=off id=foldu>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('wtongzhi.jsp')">��������</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('tel.jsp')">���õ绰</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('url.jsp')">������ַ</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('postcode.jsp')">�ʱ�����</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left//i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_delete.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('shouji.jsp')">�ֻ�IP��ѯ</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_delete.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('rili/cal.htm')">������</A> 
</DIV></DIV>

<!--- my add start -->
<DIV><IMG align=absMiddle alt="" border=0 id=communication 
onclick=swapimg(communication,foldt,opent) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=opent src="images/left/icon_folderopen.gif"> ��������</DIV>
<DIV class=off id=foldt>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('bbs.jsp')">��������</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('chat.jsp')">��������</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('soft.jsp')">�������</A> 
</DIV></DIV>

<DIV><IMG align=absMiddle alt="" border=0 id=person 
onclick=swapimg(person,foldp,openp) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=openp src="images/left/icon_folderopen.gif"> ��������</DIV>
<DIV class=off id=foldp>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('txl.jsp')">ͨѶ¼</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('calendar.jsp')">�ճ̰���</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('passwd.jsp')">�޸�����</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('archives.jsp')">���˵���</A> 
</DIV></DIV>

<DIV><IMG align=absMiddle alt="" border=0 id=mailbox 
onclick=swapimg(mailbox,foldm,openm) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=openm src="images/left/icon_folderopen.gif"> ��������</DIV>
<DIV class=off id=foldm>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('mailbox.jsp?mailbox=0')">�ռ���</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('mailbox.jsp?mailbox=1')">������</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('mailbox.jsp?mailbox=2')">������</A> 
</DIV>
</DIV>

<DIV><IMG align=absMiddle alt="" border=0 id=admin 
onclick=swapimg(admin,folda,opena) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=opena src="images/left/icon_folderopen.gif"> ��������</DIV>
<DIV class=off id=folda>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:load_Href('mm.jsp')">��λ����</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('userchk.jsp')">�û�����</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('afile.jsp')">�ļ�����</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('shouqu.jsp')">���Ĺ���</A> 
</DIV>
</DIV>

<DIV><IMG align=absMiddle alt="" border=0 id=system 
onclick=swapimg(system,folds,opens) src="images/left/tminus.gif" 
style="CURSOR: hand"><IMG align=absMiddle alt="" border=0 class=havechild 
id=opens src="images/left/icon_folderopen.gif"> ϵͳ����</DIV>
<DIV class=off id=folds>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_inbox.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('admin_bckdb.jsp?kind=1')">���ݱ���</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_draft.gif"> <A class=folderlink href="javascript:;" 
onclick="load_Href('admin_bckdb.jsp?kind=2')">���ݻָ�</A> 
</DIV>
<DIV><NOBR><IMG align=absMiddle src="images/left/i.gif"><IMG align=absMiddle 
src="images/left/t.gif"><IMG align=absMiddle alt=Folder 
src="images/left/icon_sent.gif"> <A class=folderlink href="mailto:zccraft@public.qd.sd.cn">����֧��</A> 
</DIV></DIV>
<!--  my add end-->

<DIV><IMG align=absMiddle alt="" border=0 src="images/left/l.gif"><IMG 
align=absMiddle alt="" border=0 src="images/left/icon_exit.gif"> <A 
href="javascript:onCoolExit()">�˳�</A></DIV>
</BODY></HTML>
