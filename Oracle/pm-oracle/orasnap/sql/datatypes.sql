REM ===========================================================================================
REM
REM  Script:  datatypes.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of Datatypes...
set termout off

spool output/datatypes.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="datatypes.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>Datatypes</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Datatype (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Owner (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Total</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||DATA_TYPE||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||OWNER||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(count(*),'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from    all_tab_columns
where   owner not in ('SYS','SYSTEM')
group 	by DATA_TYPE, OWNER;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/datatypes.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

