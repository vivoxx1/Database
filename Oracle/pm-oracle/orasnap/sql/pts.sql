REM ===========================================================================================
REM
REM  Script:  pts.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Process Table Scan Information...
set termout off

spool output/pts.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="pts.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>Table Scan Statistics By User Process</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Username</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>SID</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Long Scans (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Short Scans</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Rows Retreived</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">'||"Username"||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||"SID"||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char("Long Scans",'999G999G999G999G999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char("Short Scans",'999G999G999G999G999')||'</FONT></TD>
	 <TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char("Rows Retreived",'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from  (select ss.username "Username",
              se.sid "SID",
              sum(decode(name,'table scans (short tables)',value)) "Short Scans",
              sum(decode(name,'table scans (long tables)', value)) "Long Scans",
              sum(decode(name,'table scan rows gotten',value)) "Rows Retreived"
       from   sys.v_$session ss,
              sys.v_$sesstat se,
              sys.v_$statname sn
       where  se.statistic# = sn.statistic#
       and    (name  like '%table scans (short tables)%'
               or name  like '%table scans (long tables)%'
               or name  like '%table scan rows gotten%')
       and    se.sid = ss.sid
       and    ss.username is not null
       and    ss.audsid != userenv('sessionid')
       group by ss.username, se.sid)
order 	by "Long Scans" desc;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/pts.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

