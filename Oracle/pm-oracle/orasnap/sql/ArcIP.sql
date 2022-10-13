REM ===========================================================================================
REM
REM  Script:  ArcIP.sql
REM  Author:  Sulistyo Ade Suryawan
REM  Website: 
REM
REM ===========================================================================================

set termout on
prompt Retrieving Archiving Instance Parameters...
set termout off

spool output/ArcIP.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="ArcIP.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=2>
prompt  <FONT SIZE="4"><B>Archiving Instance Parameters</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt </TR>
COLUMN name      HEADING 'Parameter Name'   ENTMAP off
COLUMN value     HEADING 'Parameter Value'  ENTMAP off
select  '<TR>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||a.name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||a.value||'</FONT></TD>
	</TR>'
FROM
    v$parameter a
WHERE
    a.name like 'log_%'
ORDER BY
    a.name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/ArcIP.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

