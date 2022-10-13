REM ===========================================================================================
REM
REM  Script:  tabcache.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of Cached Tables...
set termout off

spool output/tabcache.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="tabcache.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=3>
prompt  <FONT SIZE="4"><B>Cached Tables</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Owner (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Table Name (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Cached?</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||table_name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||cache||'</FONT></TD>
	</TR>'
from dba_tables
where owner not in ('SYS','SYSTEM')
and cache like '%Y'
order by owner,table_name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/tabcache.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

