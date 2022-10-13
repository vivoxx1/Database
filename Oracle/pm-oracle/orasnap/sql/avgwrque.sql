REM ===========================================================================================
REM
REM  Script:  avgwrque.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Average Length of Write Request Queue...
set termout off

spool output/avgwrque.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="avgwrque.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Average Length Write Request Queue</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Summed Dirty Queue Length</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Write Requests</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Write Request Queue Length</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'|| nvl(to_char(sum(decode(name,'summed dirty queue length',value)),'999G999G999G999G999'),'0')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'|| nvl(to_char(sum(decode(name,'write requests',value)),'999G999G999G999G999'),'0')||'</FONT></TD>
	<TD ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2">'|| nvl(to_char(sum(decode(name,'summed dirty queue length',value)) /
		sum(decode(name,'write requests',value)),'999G999G999G999.90'),'0')||'</FONT></TD>
	</TR>'
from 	sys.v_$sysstat
where  	name in ('summed dirty queue length','write requests')
and  	value > 0;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/avgwrque.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

