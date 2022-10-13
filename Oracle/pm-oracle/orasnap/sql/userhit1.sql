REM ===========================================================================================
REM
REM  Script:  userhit1.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving User Hit Ratios...
set termout off

spool output/userhit1.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="userhit1.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>User Hit Ratio</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Username</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Consistent Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>DB Blk Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical Reads</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Hit Ratio (1)</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||username||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(consistent_gets,'999G999G999G999G999')||'</FONT></TD>
   <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(block_gets,'999G999G999G999G999')||'</FONT></TD>
   <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(physical_reads,'999G999G999G999G999')||'</FONT></TD>
   <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round(((consistent_gets+block_gets-physical_reads) / (consistent_gets+block_gets)) * 100,2)||'</FONT></TD>
	</TR>'
from 	sys.v_$session a, sys.v_$sess_io b
where 	a.sid = b.sid
and 	(consistent_gets+block_gets) > 0
and 	username is not null
and	audsid != userenv('sessionid')
order	by round(((consistent_gets+block_gets-physical_reads) / (consistent_gets+block_gets)) * 100,2);
prompt </TABLE><BR>
prompt <FORM ACTION="../source/userhit1.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

