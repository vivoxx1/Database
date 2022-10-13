REM ===========================================================================================
REM
REM  Script:  userhit3.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Open User Cursors with Hit Ratios < 60%...
set termout off

break on se0.username dup

spool output/userhit3.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="3">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="userhit3.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Open Cursors With Low Hit Ratio (&lt;60%)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Username (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>SQL Text</B></FONT></TD>
prompt </TR>
select '<TR>
    <TD NOWRAP><FONT FACE="Arial" SIZE="2">'||nvl(se0.username,'ORACLE PROC')||'</FONT></TD>
    <TD NOWRAP ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||se0.sid||'</FONT></TD>
    <TD><FONT FACE="Arial" SIZE="2">'||sql_text||'</FONT></TD>
    </TR>'
from   sys.v_$open_cursor oc0, sys.v_$session se0
where  se0.saddr = oc0.saddr
and    se0.username != 'SYS'
and    60 < (
  select "Hit Ratio"
  from (select nvl(se.username,'ORACLE PROC') "Username",
    se.sid "SID",
    sum(decode(name, 'consistent gets',value, 0))  "Consistent Gets",
    sum(decode(name, 'db block gets',value, 0))  "DB Block Gets",
    sum(decode(name, 'physical reads',value, 0))  "Physical Reads",
    (sum(decode(name, 'consistent gets',value, 0))  +
    sum(decode(name, 'db block gets',value, 0))  -
    sum(decode(name, 'physical reads',value, 0)))  /
    (sum(decode(name, 'consistent gets',value, 0))  +
    sum(decode(name, 'db block gets',value, 0))  )  * 100 "Hit Ratio"
  from   sys.v_$sesstat ss, sys.v_$statname sn, sys.v_$session se
  where  ss.sid = se.sid
  and    sn.statistic# = ss.statistic#
  and    value != 0
  and    sn.name in ('db block gets', 'consistent gets', 'physical reads')
  and    se.audsid != userenv('sessionid')
  group by se.username, se.sid)
  where nvl(se0.username,'ORACLE PROC') = "Username"
  and se0.sid = "SID")
order by se0.username, se0.sid;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/userhit3.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

