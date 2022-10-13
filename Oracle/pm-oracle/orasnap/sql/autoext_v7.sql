REM ===========================================================================================
REM
REM  Script:  autoext_v7.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of AutoExtend Datafiles...
set termout off

spool output/autoext.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="autoext.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>AutoExtend Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>File Name (2)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Tablespace Name (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>MaxBytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Increment By</B></FONT></TD>
prompt </TR>
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||FILE_NAME||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||TABLESPACE_NAME||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||TO_CHAR(BYTES,'999G999G999G999G999')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||STATUS||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||TO_CHAR(MAXEXTEND,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||TO_CHAR(INC,'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from    dba_data_files ddf, filext$ f
where   ddf.FILE_ID = f.FILE#
order 	by TABLESPACE_NAME, FILE_NAME;
prompt </TABLE><BR>
prompt <P>
prompt <I>If you receive an error on this report (i.e. ORA-00942: table or view does not exist) than you do not have any datafiles setup to autoextend.</I>
prompt <P>
prompt <FORM ACTION="../source/autoext_v7.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

