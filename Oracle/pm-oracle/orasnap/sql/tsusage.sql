REM ===========================================================================================
REM
REM  Script:  tsusage.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Tablespace Usage Information...
set termout off

spool output/tsusage.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="tsusage.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>Tablespace Usage</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Bytes<BR>Allocated</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Bytes Used</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Percent<BR>Used (1)</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Bytes Free</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Percent<BR>Free</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||ddf.tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(ddf.bytes,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char((ddf.bytes-dfs.bytes),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(round(((ddf.bytes-dfs.bytes)/ddf.bytes)*100,2),'990.90')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(dfs.bytes,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(round((1-((ddf.bytes-dfs.bytes)/ddf.bytes))*100,2),'990.90')||'</FONT></TD>
	</TR>'
from 	(select	tablespace_name,
	sum(bytes) bytes
	from dba_data_files
	group by tablespace_name) ddf,
	(select tablespace_name,
	sum(bytes) bytes
	from dba_free_space
	group by tablespace_name) dfs
where 	ddf.tablespace_name=dfs.tablespace_name
order 	by ((ddf.bytes-dfs.bytes)/ddf.bytes) desc;

select '<TR>
	<TD><FONT FACE="Arial" SIZE="2"><B>'||'TOTALS'||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum(ddf.bytes),'999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum(ddf.bytes-dfs.bytes),'999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||'&nbsp;'||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum(dfs.bytes),'999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||'&nbsp;'||'</FONT></TD>
	</TR>'
from 	(select	tablespace_name,
	sum(bytes) bytes
	from dba_data_files
	group by tablespace_name) ddf,
	(select tablespace_name,
	sum(bytes) bytes
	from dba_free_space
	group by tablespace_name) dfs
where	ddf.tablespace_name = dfs.tablespace_name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/tsusage.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

