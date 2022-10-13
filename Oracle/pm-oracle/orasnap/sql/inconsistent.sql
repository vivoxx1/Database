REM ===========================================================================================
REM
REM  Script:  inconsistent.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Inconsistent Column Datatypes...
set termout off

spool output/inconsistent.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="inconsistent.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>Inconsistent Column Datatypes</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Owner</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Column (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Table Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Datatype (2)</B></FONT></TD>
prompt </TR>
select 	/*+ RULE */'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||column_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||table_name||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||data_type||'('||decode(data_type, 'NUMBER', data_precision, data_length)||')</FONT></TD>
	</TR>'
from 	dba_tab_columns 
where  (column_name, owner)
	IN
	(select column_name, owner
	 from   dba_tab_columns
	 group  by column_name, owner
	 having min(decode(data_type, 'NUMBER', data_precision, data_length))
	 < max(decode(data_type, 'NUMBER', data_precision, data_length)) )
	 and    owner not in ('SYS', 'SYSTEM')
order 	by column_name,data_type;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/inconsistent.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

