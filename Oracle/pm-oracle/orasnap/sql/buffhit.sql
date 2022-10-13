REM ===========================================================================================
REM
REM  Script:  buffhit.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retreiving Buffer Hit Ratio...
set termout off

spool output/buffhit.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="buffhit.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>Buffer Hit Ratio</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Consistent Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>DB Blk Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical Reads</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Hit Ratio</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(sum(decode(name, 'consistent gets',value, 0)),'999G999G999G999G999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(sum(decode(name, 'db block gets',value, 0)),'999G999G999G999G999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(sum(decode(name, 'physical reads',value, 0)),'999G999G999G999G999')||'</FONT></TD>
         <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round((sum(decode(name, 'consistent gets',value, 0)) +
         sum(decode(name, 'db block gets',value, 0)) - sum(decode(name, 'physical reads',value, 0))) /
         (sum(decode(name, 'consistent gets',value, 0))  + sum(decode(name, 'db block gets',value, 0)) )  * 100,3)||'</FONT></TD>
	</TR>'
from sys.v_$sysstat;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/buffhit.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

