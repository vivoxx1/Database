REM ===========================================================================================
REM
REM  Script:  waitstat.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Wait Statistics...
set termout off

spool output/waitstat.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="waitstat.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Wait Statistics</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Class (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Count</B></FONT></TD>
prompt  <TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Time</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(class,
             'data block','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
             'free list','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
             'segment header','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
             'sort block','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
             'undo block','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
             'undo header','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||class||'</FONT>',
		class)||'</FONT></TD>
	 <TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||count||'</FONT></TD>
	 <TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||time||'</FONT></TD>
	</TR>'
from sys.v_$waitstat
order by class;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/waitstat.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

