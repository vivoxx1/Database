REM ===========================================================================================
REM
REM  Script:  sysstata.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving System Statistics (ALL)...
set termout off

spool output/sysstata.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="sysstata.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>System Statistics (All)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Stat# (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Class</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||statistic#||'</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||
	 decode(name,
       		'recursive calls','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'enqueue timeouts','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'enqueue waits','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'enqueue requests','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'enqueue deadlocks','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'db block gets','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'consistent gets','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'physical reads','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'redo log space requests','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'sorts (memory)','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'sorts (disk)','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'sorts (rows)','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'consistent changes','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'db block changes','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
       		'','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
        	name)||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||class||'</FONT></TD>
	 <TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(value,'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	sys.v_$sysstat
order	by statistic#;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/sysstata.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

