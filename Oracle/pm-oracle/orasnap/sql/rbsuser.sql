REM ===========================================================================================
REM
REM  Script:  rbsuser.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Rollback Users...
set termout off

spool output/rbsuser.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="rbsuser.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=7>
prompt  <FONT SIZE="4"><B>Rollback Users</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Segment<BR>Name (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Xacts</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Serial#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Username</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>OS User</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>SQL Text</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||a.name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||b.xacts||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||c.sid||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||c.serial#||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||c.username||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(c.osuser,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||d.sql_text||'</FONT></TD>
	</TR>'
from sys.v_$rollname a, sys.v_$rollstat b, sys.v_$session c, sys.v_$sqlarea d, sys.v_$transaction e
where a.usn = b.usn
and b.usn = e.xidusn
and c.taddr = e.addr
and c.sql_address = d.address
and c.sql_hash_value = d.hash_value
and c.audsid != userenv('sessionid')
order by a.name, c.sid;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/rbsuser.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

