REM ===========================================================================================
REM
REM  Script:  curusage.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Per Session Current Cursor Usage...
set termout off

spool output/curusage.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="curusage.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>Cursor Statistics (By Session)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Username</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Recursive Calls (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Opened Cursors</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Current Cursors</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||username||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||sid||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char("Recursive Calls",'999G999G999G999G999')||'</FONT></TD>
       	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char("Opened Cursors",'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||nvl(to_char("Current Cursors",'999G999G999G999G999'),'&nbsp;')||'</FONT></TD>
	</TR>'
from   (select nvl(ss.username,'ORACLE PROC') Username,
               se.sid SID,
               sum(decode(name,'recursive calls',value)) "Recursive Calls",
               sum(decode(name,'opened cursors cumulative',value)) "Opened Cursors",
               sum(decode(name,'opened cursors current',value)) "Current Cursors"
        from   sys.v_$session ss, sys.v_$sesstat se, sys.v_$statname sn
        where  se.statistic# = sn.statistic#
        and    (name  like '%opened cursors current%'
                or name  like '%recursive calls%'
                or name  like '%opened cursors cumulative%')
        and    se.sid = ss.sid
        and    ss.username is not null
        and    ss.audsid != userenv('sessionid')
       group by ss.username, se.sid)
order 	by "Recursive Calls" desc, username, sid;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/curusage.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

