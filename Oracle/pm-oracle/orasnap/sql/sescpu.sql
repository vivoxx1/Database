REM ===========================================================================================
REM
REM  Script:  sescpu.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving CPU Usage By Session...
set termout off

spool output/sescpu.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="sescpu.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>CPU Usage By Session</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Username</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>CPU Usage (1)</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(ss.username,'ORACLE PROC')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||se.sid||'</FONT></TD>
  <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||value||'</FONT></TD>
	</TR>'
from 	sys.v_$session ss, sys.v_$sesstat se, sys.v_$statname sn
where  	se.statistic# = sn.statistic#
and  	name  like '%CPU used by this session%'
and  	se.sid = ss.sid
and	ss.audsid != userenv('sessionid')
order  	by value desc;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/sescpu.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt <P>
select '<BR><HR><BR>Note: Requires <I>TIMED_STATISTICS</I> be set to TRUE.'
from 	dual
where 	'FALSE' in (select value from sys.v_$parameter where name='timed_statistics');
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

