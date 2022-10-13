REM ===========================================================================================
REM
REM  Script:  dbfiles.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Database Files (arch logs/control files/datafiles/etc.)...
set termout off

spool output/dbfiles.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="dbfiles.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=2>
prompt  <FONT SIZE="4"><B>Database Files (archive/control/data/logfile)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>File Type</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Location</B></FONT></TD>
prompt </TR>
select '<TR>
	 <TD><FONT FACE="Arial" SIZE="2">Archived Log Directory</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||nvl(value,'&nbsp;')||'</FONT></TD>
	</TR>'
from 	sys.v_$parameter
where 	name = 'log_archive_dest%'
UNION ALL
select '<TR>
	 <TD NOWRAP><FONT FACE="Arial" SIZE="2">Control Files</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||value||'</FONT></TD>
	</TR>'
from 	sys.v_$parameter
where 	name = 'control_files'
UNION ALL
select '<TR>
	 <TD NOWRAP><FONT FACE="Arial" SIZE="2">Datafile</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	</TR>'
from 	sys.v_$datafile
UNION ALL
select '<TR>
	 <TD NOWRAP><FONT FACE="Arial" SIZE="2">Datafile (Temp File)</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	</TR>'
from 	sys.v_$tempfile
UNION ALL
select '<TR>
	 <TD NOWRAP><FONT FACE="Arial" SIZE="2">LogFile Member</FONT></TD>
	 <TD><FONT FACE="Arial" SIZE="2">'||member||'</FONT></TD>
	</TR>'
from 	sys.v_$logfile;
prompt </TABLE>
prompt <P>

select '<FONT COLOR="#FF0000"><I>Note: You will receive an "ORA-00942: table or view does not exist" error if you are running this against a v8.0.x database.  The SYS.V$_TEMPFILE view is introduced in v8.1.x (script name: dbfiles.sql)</I></FONT>'
from 	dual
where  	0 in (
	select count(*) from dba_views
	where view_name='V_$TEMPFILE');
prompt <P>

prompt <FORM ACTION="../source/dbfiles.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

