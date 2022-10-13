REM ===========================================================================================
REM
REM  Script:  dbsnaps.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Database Snapshots...
set termout off

spool output/dbsnaps.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="dbsnaps.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=14>
prompt  <FONT SIZE="4"><B>Database Snapshots</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Owner (1)</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Name (2)</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Table<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Master<BR>View</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Master<BR>Owner</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Master</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Master Link</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Can Use<BR>Log?</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Updatable</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Last Refresh</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Error</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Type</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Next Refresh</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Refresh<BR>Group</B></FONT></TD>
prompt </TR>
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||table_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(to_char(master_view),'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||master_owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||master||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(master_link,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||can_use_log||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||updatable||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||nvl(to_char(last_refresh),'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||error||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||type||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||nvl(next,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(to_char(refresh_group),'&nbsp;')||'</FONT></TD>
	</TR>'
from  	dba_snapshots
order 	by owner,name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/dbsnaps.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

