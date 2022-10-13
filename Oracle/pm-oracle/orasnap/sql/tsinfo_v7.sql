REM ===========================================================================================
REM
REM  Script:  tsinfo_v7.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Tablespace Details...
set termout off

spool output/tsinfo.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="tsinfo.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=8>
prompt  <FONT SIZE="4"><B>Tablespace Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Tablespace<BR>Name (1)</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Initial Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Next Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Min<BR>Extents</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Max<BR>Extents</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Percent<BR>Increase</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Contents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(initial_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(next_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(min_extents,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(max_extents,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||decode(pct_increase,0,'0','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||pct_increase||'</FONT>')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||status||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(contents,'PERMANENT','PERMANENT','<FONT COLOR="#FF0000">'||contents||'</FONT>')||'</FONT></TD>
	</TR>'
from 	dba_tablespaces
order 	by tablespace_name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/tsinfo_v7.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

