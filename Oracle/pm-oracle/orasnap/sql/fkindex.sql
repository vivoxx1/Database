REM ===========================================================================================
REM
REM  Script:  fkindex.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving FK Constraints Without an Index On Child Table...
set termout off

spool output/fkindex.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="fkindex.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>FK Constraints Without Index on Child Table</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Owner (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Constraint Name (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Column Name (3)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Position (4)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Problem</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||acc.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||acc.constraint_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||acc.column_name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||acc.position||'</FONT></TD> 
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||'No Index'||'</FONT></TD>
	</TR>'
from   	dba_cons_columns acc, dba_constraints ac
where  	ac.constraint_name = acc.constraint_name
and   	ac.constraint_type = 'R'
and     acc.owner not in ('SYS','SYSTEM')
and     not exists (
        select  'TRUE' 
        from    dba_ind_columns b
        where   b.table_owner = acc.owner
        and     b.table_name = acc.table_name
        and     b.column_name = acc.column_name
        and     b.column_position = acc.position)
order   by acc.owner, acc.constraint_name, acc.column_name, acc.position;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/fkindex.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

