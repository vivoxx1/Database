REM ===========================================================================================
REM
REM  Script:  sysevents.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving System Events...
set termout off

spool output/sysevents.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="sysevents.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>System Events (All)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Event Name</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Total<BR>Waits (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Total<BR>Timeouts</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Time<BR>Waited</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Average<BR>Wait</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">'||decode(event,'buffer busy waits','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||event||'</font>',event)||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(total_waits,'999G999G999G999G999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(total_timeouts,'999G999G999G999G999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(time_waited,'999G999G999G999G999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round(average_wait,2)||'</FONT></TD></TR>'
from sys.v_$system_event
order by total_waits desc;
prompt </TABLE>
prompt <P>

select '<I>Note: <B>Time Waited</B>, <B>Average Wait</B> are not available since TIMED_STATISTICS has not been set to TRUE.</I>'
from 	dual
where  'FALSE' in (
	select value from sys.v_$parameter where name='timed_statistics');
prompt <P>

prompt <FORM ACTION="../source/sysevents.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

