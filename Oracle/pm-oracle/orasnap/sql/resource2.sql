REM ===========================================================================================
REM
REM  Script:  resource2.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Cursors Open By User...
set termout off

spool output/resource2.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="resource2.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Open Cursors By User</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Username (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>SQL Text</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||nvl(username,'ORACLE PROC')||'</FONT></TD>
	<TD NOWRAP ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||s.sid||'</FONT></TD>
        <TD><FONT FACE="Arial" SIZE="2">'||replace(replace(sql_text,'<','&lt;'),'>','&gt;')||'</FONT></TD>
	</TR>'
from 	sys.v_$open_cursor oc, sys.v_$session s
where 	s.saddr = oc.saddr
and	s.audsid != userenv('sessionid')
order by username, s.sid;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/resource2.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

