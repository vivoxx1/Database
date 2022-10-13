REM ===========================================================================================
REM
REM  Script:  analrecent.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of Recently Analyzed Tables...
set termout off

spool output/analrecent.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="analrecent.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Recently Analyzed Tables (Last 14 Days)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Owner</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Table Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Last Analyzed (1)</B></FONT></TD>
prompt </TR>
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||table_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||to_char(last_analyzed,'MM/DD/YYYY HH24:MI:SS')||'</FONT></TD>
	</TR>'
from 	dba_tab_columns
where 	owner not in ('SYS','SYSTEM')
and 	last_analyzed is not null
and	column_id=1
and 	(SYSDATE - last_analyzed) < 14
order	by (SYSDATE-last_analyzed);
prompt </TABLE><BR>
prompt <FORM ACTION="../source/analrecent.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

