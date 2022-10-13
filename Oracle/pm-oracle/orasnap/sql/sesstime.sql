REM ===========================================================================================
REM
REM  Script:  sesstime.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Session Time...
set termout off

spool output/sesstime.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="sesstime.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=10>
prompt  <FONT SIZE="4"><B>Session Time</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Serial#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Username (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>OSUser (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Server</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Program</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Logon</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Last Call</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||sid||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||serial#||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(username,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(osuser,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||server||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||status||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||type||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(program,'&nbsp;')||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||logon_time||'</FONT></TD>
	<TD ALIGN="RIGHT" NOWRAP><FONT FACE="Arial" SIZE="2">'||lpad(to_char(trunc(last_call_et/3600)),2,0)||':'||lpad(to_char(trunc(last_call_et/60)-(trunc(last_call_et/3600)*60)),2,0)||':'||lpad(to_char(last_call_et-(trunc(last_call_et/60)*60)),2,0)||'</FONT></TD>
	</TR>'
from 	sys.v_$session
order 	by username, osuser;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/sesstime.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

