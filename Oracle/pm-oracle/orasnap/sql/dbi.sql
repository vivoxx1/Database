REM ===========================================================================================
REM
REM  Script:  dbi.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Database Information...
set termout off

spool output/dbi.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="dbi.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>Database Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Database Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Created</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Log Mode</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>CheckPoint<BR>Change #</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Archive<BR>Change #</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2">'||created||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||log_mode||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||checkpoint_change#||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||archive_change#||'</FONT></TD>
	</TR>'
from 	sys.v_$database;
prompt </TABLE>
prompt <P>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Started</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Uptime</B></FONT></TD>
prompt </TR>
SELECT  '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(startup_time, 'DD-MON-YYYY HH24:MI:SS')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||trunc( sysdate - ( startup_time) ) || ' day(s), ' ||
        trunc(  24*((sysdate-startup_time) -
                trunc(sysdate-startup_time)))||' hour(s), ' ||
        mod(trunc(1440*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' minute(s), ' ||
        mod(trunc(86400*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' seconds' ||'</FONT></TD>
	</TR>'
FROM    sys.v_$instance;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/dbi.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

