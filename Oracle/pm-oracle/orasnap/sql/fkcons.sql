REM ===========================================================================================
REM
REM  Script:  fkcons.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving List of FK Constraints...
set termout off

spool output/fkcons.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="fkcons.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=7>
prompt  <FONT SIZE="4"><B>Foreign Key Constraints</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Table<BR>Owner (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Table<BR>Name (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Constraint<BR>Name (3)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Column<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Referenced<BR>Table</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Referenced<BR>Column</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Position (4)</B></FONT></TD>
prompt </TR>
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||c.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||c.table_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||c.constraint_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||cc.column_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||r.table_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||rc.column_name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||cc.position||'</FONT></TD>
	</TR>'
from 	dba_constraints c, dba_constraints r, dba_cons_columns cc, dba_cons_columns rc
where 	c.constraint_type = 'R'
and 	c.owner not in ('SYS','SYSTEM')
and 	c.r_owner = r.owner
and 	c.r_constraint_name = r.constraint_name
and 	c.constraint_name = cc.constraint_name
and 	c.owner = cc.owner
and 	r.constraint_name = rc.constraint_name
and 	r.owner = rc.owner
and 	cc.position = rc.position
ORDER 	BY c.owner, c.table_name, c.constraint_name, cc.position;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/fkcons.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

