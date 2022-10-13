REM ===========================================================================================
REM
REM  Script:  roleprivs.sql
REM  Author:  Stewart McGlaughlin (dba@pobox.com)
REM
REM  OraSnap (Oracle Performance Snapshot)
REM
REM ===========================================================================================

set termout on
prompt Retrieving User Privileges...
set termout off

spool output/roleprivs.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="roleprivs.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>Role Privileges</B></FONT>
prompt  <FONT SIZE="2"><BR>(Excluding SYS, SYSTEM, DBA, EXP_FULL_DATABASE, IMP_FULL_DATABASE)</FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Grantee (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Granted Role (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Admin Option</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Default Role</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Privilege (3)</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||rp.grantee||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(granted_role,
        	'DBA','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||granted_role||'</FONT>',granted_role)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(rp.admin_option,
		'YES','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||rp.admin_option||'</FONT>',rp.admin_option)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2" FACE="Arial" SIZE="2">'||default_role||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||privilege||'</FONT></TD>
	</TR>'
from   	dba_role_privs rp, dba_sys_privs sp
where  	rp.grantee = sp.grantee
and	rp.grantee not in ('SYS','SYSTEM','DBA','EXP_FULL_DATABASE','IMP_FULL_DATABASE')
order  by  rp.grantee, granted_role, privilege;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/roleprivs.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

