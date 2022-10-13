REM ===========================================================================================
REM
REM  Script:  noextend.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Objects That Cannot Extend...
set termout off

spool output/noextend.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="noextend.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=9>
prompt  <FONT SIZE="4"><B>Objects That Cannot Extend</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Owner (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Object Name (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Object Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Tablespace</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Next Bytes</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Max Bytes</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Sum Bytes</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Current<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Avail<BR>Extents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_type||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ds.next_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.max,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.sum,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||ds.extents||'</FONT></TD>
<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||decode(floor(dfs.max/ds.next_extent),0,'<FONT COLOR="#FF0000">0</FONT>',floor(dfs.max/ds.next_extent))||'</FONT></TD>
 	</TR>'
from    dba_segments ds,
       (select max(bytes) max,
	sum(bytes) sum,
	tablespace_name
	from dba_free_space
	group by tablespace_name) dfs
where 	ds.next_extent > dfs.max
and     ds.tablespace_name = dfs.tablespace_name
and     ds.owner not in ('SYS','SYSTEM')
order 	by ds.owner, ds.tablespace_name, ds.segment_name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/noextend.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

