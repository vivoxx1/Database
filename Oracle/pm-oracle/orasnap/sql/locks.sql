REM ===========================================================================================
REM
REM  Script:  locks.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Lock Information...
set termout off

spool output/locks.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="locks.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=10>
prompt  <FONT SIZE="4"><B>Lock Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>OS User</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>OS PID</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Oracle User</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Oracle ID</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Lock Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Lock Held</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Lock Requested</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Object Owner</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Object Name</B></FONT></TD>
prompt </TR>
select  /*+ RULE */'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(os_user_name,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(process,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||oracle_username||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||l.sid||'</FONT></TD>
        <TD NOWRAP><FONT FACE="Arial" SIZE="2">'||DECODE(type,
                'MR', 'Media Recovery',
                'RT', 'Redo Thread',
                'UN', 'User Name',
                'TX', 'Transaction',
                'TM', 'DML',
                'UL', 'PL/SQL User Lock',
                'DX', 'Distributed Xaction',
                'CF', 'Control File',
                'IS', 'Instance State',
                'FS', 'File Set',
                'IR', 'Instance Recovery',
                'ST', 'Disk Space Transaction',
                'TS', 'Temp Segment',
                'IV', 'Library Cache Invalidation',
                'LS', 'Log Start or Switch',
                'RW', 'Row Wait',
                'SQ', 'Sequence Number',
                'TE', 'Extend Table',
                'TT', 'Temp Table', type)||'</FONT></TD>
        <TD NOWRAP><FONT FACE="Arial" SIZE="2">'||DECODE(lmode,
                0, 'None',
                1, 'Null',
                2, 'Row-S (SS)',
                3, 'Row-X (SX)',
                4, 'Share',
                5, 'S/Row-X (SSX)',
                6, 'Exclusive', to_char(lmode))||'</FONT></TD>
        <TD NOWRAP><FONT FACE="Arial" SIZE="2">'||DECODE(request,
                0, 'None', 
                1, 'Null',
                2, 'Row-S (SS)',
                3, 'Row-X (SX)', 
                4, 'Share', 
                5, 'S/Row-X (SSX)',
                6, 'Exclusive', to_char(request))||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||DECODE(block,
                0, 'Not Blocking',
                1, '<FONT COLOR="#FF0000" FACE="Arial" SIZE="2"><B>BLOCKING</B></FONT>', 
                2, 'Global', to_char(block))||'</FONT></TD>
        <TD><FONT FACE="Arial" SIZE="2">'||owner||'</FONT></TD>
        <TD><FONT FACE="Arial" SIZE="2">'||object_name||'</FONT></TD>
	</TR>'
from    sys.v_$locked_object lo,
        dba_objects do,
        sys.v_$lock l
where   lo.object_id = do.object_id
and     l.sid = lo.session_id;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/locks.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

