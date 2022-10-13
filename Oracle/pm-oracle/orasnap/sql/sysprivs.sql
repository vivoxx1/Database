REM ===========================================================================================
REM
REM  Script:  sysprivs.sql
REM  Author:  Stewart McGlaughlin (dba@pobox.com)
REM
REM  OraSnap (Oracle Performance Snapshot)
REM
REM ===========================================================================================

set termout on
prompt Retrieving System Privileges...
set termout off

spool output/sysprivs.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="sysprivs.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Role Privileges</B></FONT>
prompt  <FONT SIZE="2"><BR>(Excluding SYS, SYSTEM, DBA, IMP_FULL_DATABASE, EXP_FULL_DATABASE)</FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Grantee (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Privilege (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Admin Option</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||grantee||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||privilege||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(admin_option,
		'YES','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||admin_option||'</FONT>',admin_option)||'</FONT></TD>
	</TR>'
from   	dba_sys_privs 
where   grantee not in ('SYS','SYSTEM','DBA','IMP_FULL_DATABASE','EXP_FULL_DATABASE')
order  by  grantee, privilege;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/sysprivs.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

