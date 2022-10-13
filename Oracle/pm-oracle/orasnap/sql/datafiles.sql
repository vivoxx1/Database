REM ===========================================================================================
REM
REM  Script:  datafiles.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of Datafiles...
set termout off

spool output/datafiles.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="datafiles.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>Datafiles</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>File Name (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Tablespace (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Datafile Size</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Bytes Used</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Percent Used</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Bytes Free</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||FILE_NAME||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||d.TABLESPACE_NAME||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(d.BYTES,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(sum(nvl(e.BYTES,0)),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||round(sum(nvl(e.BYTES,0)) / (d.BYTES), 4) * 100||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char((d.BYTES - sum(nvl(e.BYTES,0))),'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from    dba_extents e,
        dba_data_files d
where   d.FILE_ID = e.FILE_ID (+)
group by FILE_NAME,d.TABLESPACE_NAME, d.FILE_ID, d.BYTES, STATUS
order by d.TABLESPACE_NAME,d.FILE_ID;
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="2"><B>TOTALS</B></FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2"><B>N/A</B></FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum(d.bytes),'999G999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum(nvl(sum(e.BYTES),0)),'999G999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>N/A</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>'||to_char(sum((d.BYTES - sum(nvl(e.BYTES,0)))),'999G999G999G999G999')||'</B></FONT></TD>
	</TR>'
from	dba_extents e,
	dba_data_files d
where	d.file_id = e.file_id (+)
group by d.file_id, d.bytes;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/datafiles.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

