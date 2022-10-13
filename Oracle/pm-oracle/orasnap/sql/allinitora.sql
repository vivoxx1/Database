REM ===========================================================================================
REM
REM  Script:  allinitora.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving All INIT.ORA Parameters...
set termout off

spool output/allinitora.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="allinitora.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>All INIT.ORA Parameters</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Parameter (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Desc</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Default?</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||ksppinm||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||ksppdesc||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(ksppstvl,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(ksppstdf,'FALSE','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||ksppstdf||'</FONT>',ksppstdf)||'</FONT></TD>
	</TR>'
from sys.x$ksppi x, sys.x$ksppcv y
where x.indx = y.indx
order by ksppinm;
prompt </TABLE>
prompt <P>

select '<FONT COLOR="#FF0000"><I>Note: You will receive an "ORA-00942: table or view does not exist" error if you are not running OraSnap as SYS.  This script is based directly on the X$ tables, which are only visible to SYS.  You can either rerun OraSnap as SYS or setup a view (as SYS) and modify this report (allinit.sql) to query against the new view.</I></FONT>'
from 	dual
where  	'SYS' not in (
	select username from sys.v_$session
	where audsid = userenv('sessionid'));
prompt <P>

prompt <FORM ACTION="../source/allinitora.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off
