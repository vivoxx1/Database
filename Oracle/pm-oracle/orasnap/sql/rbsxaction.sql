REM ===========================================================================================
REM
REM  Script:  rbsxaction.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Rollback on Transaction Table Information...
set termout off

spool output/rbsxaction.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="rbsxaction.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=2>
prompt  <FONT SIZE="4"><B>Rollback Statistics on Transaction Tables</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Statistic Name (1)</B></FONT></TD>
prompt  <TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(value,'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	sys.v_$sysstat
where 	name in
   	('consistent gets',
    	 'consistent changes',
    	 'transaction tables consistent reads - undo records applied',
    	 'transaction tables consistent read rollbacks',
	 'data blocks consistent reads - undo records applied',
      	 'no work - consistent read gets',
     	 'cleanouts only - consistent read gets',
     	 'rollbacks only - consistent read gets',
     	 'cleanouts and rollbacks - consistent read gets')
order by name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/rbsxaction.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER><P>

prompt <B>Other Info:</B><BR>
prompt <PRE>
select 'Tran Table Consistent Read Rollbacks > 1% of Consistent Gets' aa,
       'Action: Create more Rollback Segments'
  from sys.v_$sysstat
 where decode (name,'transaction tables consistent read rollbacks',value)
                   * 100 /
       decode (name,'consistent gets',value) > 0.1
   and name in ('transaction tables consistent read rollbacks',
		'consistent gets')
   and value > 0;

select 'Undo Records Applied > 10% of Consistent Changes' aa,
       'Action: Create more Rollback Segments'
  from sys.v_$sysstat
 where decode
    (name,'transaction tables consistent reads - undo records applied',value)
                   * 100 /
       decode (name,'consistent changes',value) > 10
   and name in
         ('transaction tables consistent reads - undo records applied',
         	'consistent changes')
   and value > 0;
prompt </PRE><BR>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

