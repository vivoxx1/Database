REM ===========================================================================================
REM
REM  Script:  initora.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving INIT.ORA Parameters...
set termout off

spool output/initora.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="initora.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>INIT.ORA Parameters</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Parameter (1)</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Is Default<B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Session Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>System Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Is Modified</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(name,
             'always_anti_join','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'db_block_buffers','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2"><B>'||name||'</B></FONT>',
             'db_block_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2"><B>'||name||'</B></FONT>',
             'db_block_multiblock_read_count','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'db_file_multiblock_read_count','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'db_file_simultaneous_writes','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'db_writers','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'enqueue_resources','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'compatible','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'control_files','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'cursor_space_for_time','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'hash_join_enabled','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'hash_area_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'hash_multiblock_io_count','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_buffer','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_buffers','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_archive_start','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_archive_buffer_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_archive_dest','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_checkpoint_interval','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'log_simultaneous_copies','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'optimizer_mode','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'parallel_max_servers','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'parallel_min_percent','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'processes','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'row_cache_cursors','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'rollback_segments','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'shared_pool_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2"><B>'||name||'</B></FONT>',
             'shared_pool_reserved_min_alloc','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'shared_pool_reserved_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'small_table_threshold','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sort_area_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2"><B>'||name||'</B></FONT>',
             'sort_area_retained_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sort_read_fac','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sort_direct_writes','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sort_write_buffer_size','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sort_write_buffers','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'sql_trace','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'timed_statistics','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
             'user_dump_dest','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||name||'</FONT>',
              name)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(value,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(isdefault,
             'FALSE','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||isdefault||'</FONT>',isdefault)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(isses_modifiable,
             'TRUE','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||isses_modifiable||'</FONT>',isses_modifiable)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(issys_modifiable,
             'IMMEDIATE','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||issys_modifiable||'</FONT>',
             'DEFERRED','<FONT COLOR="#FF0000" FACE="Arial" SIZE="2">'||issys_modifiable||'</FONT>',issys_modifiable)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||ismodified||'</FONT></TD>
	</TR>' 
from 	sys.v_$parameter
order  	by name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/initora.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

