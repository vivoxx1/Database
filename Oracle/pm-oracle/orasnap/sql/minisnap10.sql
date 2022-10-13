REM ===========================================================================================
REM
REM  Script:  minisnap10.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set echo        off
set feedback    off
set verify      off
set heading     off
set termout     off
set define      on
set pause       off
set timing      off
set trimspool   on
set pagesize    0
set linesize    500
ttitle          off
btitle          off

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';

-- column dbname1 new_value dbname noprint
-- select rtrim(name) dbname1 from v$database;

set termout on
prompt Retrieving Mini Snapshot Information...
set termout off

-- spool minisnap/&dbname..htm
spool output/minisnap.htm
set define off

prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="1">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2">'||SYSDATE||'</FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>

-----------------------
-- Database Information
-----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Database Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Instance Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Host Name</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Version</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Status</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Started</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Uptime</B></FONT></TD>
prompt </TR>
SELECT  '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||upper(instance_name)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||upper(host_name)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||version||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||status||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(startup_time, 'DD-MON-YYYY HH24:MI:SS')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||trunc(sysdate - (startup_time)) || ' day(s), ' ||
        trunc(24*((sysdate-startup_time) -
                trunc(sysdate-startup_time)))||' hour(s), ' ||
        mod(trunc(1440*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' minute(s), ' ||
        mod(trunc(86400*((sysdate-startup_time) -
                trunc(sysdate-startup_time))), 60) ||' seconds' ||'</FONT></TD>
	</TR>'
FROM    sys.v_$instance;
prompt </TABLE><P><HR WIDTH="100%"><P>

----------------------
-- Segment Information
----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=10>
prompt  <FONT SIZE="3"><B>Segments With More Than 50% Of Max Extents</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Segment<BR>Size</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next<BR>Extent</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Pct<BR>Incr</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Max<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||segment_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||segment_type||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(bytes,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(next_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||pct_increase||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||max_extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char((extents/max_extents)*100,'999.90')||'</FONT></TD>
	</TR>'
from 	dba_segments
where 	segment_type in ('TABLE','INDEX')
and 	extents > max_extents/2
order 	by (extents/max_extents) desc;
prompt </TABLE><P><HR WIDTH="100%"><P>

---------------------
-- No Extend (Tables)
---------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=8>
prompt  <FONT SIZE="3"><B>Tables That Cannot Extend</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Table Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Max Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Sum Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Avail<BR>Extents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ds.next_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.max,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.sum,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||ds.extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||decode(floor(dfs.max/ds.next_extent),0,'<FONT COLOR="#FF0000">0</FONT>',floor(dfs.max/ds.next_extent))||'</FONT></TD>
	</TR>'
from   	dba_segments ds,
       (select max(bytes) max,
	sum(bytes) sum,
	tablespace_name
	from dba_free_space
	group by tablespace_name) dfs
where  	ds.segment_type = 'TABLE'
and    	ds.next_extent > dfs.max
and    	ds.tablespace_name = dfs.tablespace_name
and    	ds.owner not in ('SYS','SYSTEM')
order 	by ds.owner, ds.tablespace_name, ds.segment_name;
prompt </TABLE><P><HR WIDTH="100%"><P>

----------------------
-- No Extend (Indexes)
----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=8>
prompt  <FONT SIZE="3"><B>Indexes That Cannot Extend</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Owner</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Index Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Next Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Max Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Sum Bytes</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Current<BR>Extents</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>Avail<BR>Extents</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.tablespace_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ds.segment_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ds.next_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.max,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.sum,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||ds.extents||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||decode(floor(dfs.max/ds.next_extent),0,'<FONT COLOR="#FF0000">0</FONT>',floor(dfs.max/ds.next_extent))||'</FONT></TD>
	</TR>'
from   	dba_segments ds,
       (select max(bytes) max,
	sum(bytes) sum,
	tablespace_name
	from dba_free_space
	group by tablespace_name) dfs
where  	ds.segment_type  = 'INDEX'
and    	ds.next_extent > dfs.max
and    	ds.tablespace_name = dfs.tablespace_name
and    	ds.owner not in ('SYS','SYSTEM')
order 	by ds.owner, ds.tablespace_name, ds.segment_name;
prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------
-- Tablespace Usage
-------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Tablespace(s) With Less Than 20% Freespace</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes<BR>Allocated</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes Used</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent<BR>Used</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Bytes Free</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Percent<BR>Free</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||ddf.tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(ddf.bytes,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char((ddf.bytes-dfs.bytes),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(round(((ddf.bytes-dfs.bytes)/ddf.bytes)*100,2),'990.90')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(dfs.bytes,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(round((1-((ddf.bytes-dfs.bytes)/ddf.bytes))*100,2),'990.90')||'</FONT></TD>
	</TR>'
from 	(select tablespace_name,
	sum(bytes) bytes
	from dba_data_files
	group by tablespace_name) ddf,
	(select tablespace_name,
	sum(bytes) bytes
	from dba_free_space
	group by tablespace_name) dfs
where 	ddf.tablespace_name=dfs.tablespace_name
and     ((ddf.bytes-dfs.bytes)/ddf.bytes)*100 > 80
order 	by ((ddf.bytes-dfs.bytes)/ddf.bytes) desc;
prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------------
-- Tablespace Information
-------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="3"><B>Tablespace Extent Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Largest Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Smallest Extent</B></FONT></TD>
prompt 	<TD ALIGN="RIGHT" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Total Free</B></FONT></TD>
prompt 	<TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Pieces</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||tablespace_name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(max(bytes),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(min(bytes),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(sum(bytes),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(count(*),'999G999')||'</FONT></TD>
	</TR>'
from 	dba_free_space
group 	by tablespace_name
order   by tablespace_name;
prompt </TABLE><P><HR WIDTH="100%"><P>

-----------------------
-- Datafile Information
-----------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Datafile / Tablespace (Location and Size)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>File Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Tablespace<BR>Name</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Datafile Size</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Bytes Used</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Percent<BR>Used</B></FONT></TD>
prompt </TR>
select  '<TR>
	<TD NOWRAP><FONT FACE="Arial" SIZE="1">'||FILE_NAME||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||d.TABLESPACE_NAME||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(d.BYTES,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(sum(nvl(e.BYTES,0)),'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||round(sum(nvl(e.BYTES,0)) / (d.BYTES), 4) * 100||'</FONT></TD>
	</TR>'
from    dba_extents e,
        dba_data_files d
where   d.FILE_ID = e.FILE_ID (+)
group by FILE_NAME,d.TABLESPACE_NAME, d.FILE_ID, d.BYTES, STATUS
order by d.TABLESPACE_NAME,d.FILE_ID;
select 	'<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>TOTALS</B></FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1"><B>N/A</B></FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1"><B>'||to_char(sum(d.bytes),'999G999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>'||to_char(sum(nvl(sum(e.BYTES),0)),'999G999G999G999G999')||'</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>N/A</B></FONT></TD>
	</TR>'
from	dba_extents e,
	dba_data_files d
where	d.file_id = e.file_id (+)
group by d.file_id, d.bytes;
prompt </TABLE><P><HR WIDTH="100%"><P>

-------------------
-- Sort Information
-------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=2>
prompt  <FONT SIZE="3"><B>Sort Statistics</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Sort Parameter</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1">'||to_char(value,'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	sys.v_$sysstat
where 	name like 'sort%';
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>'||'% of disk sorts'||'</B></FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="1"><B>'||to_char(100*a.value/decode((a.value+b.value),0,1,(A.value+b.value)),'999.90')||'</B></FONT></TD>
	</TR>'
from 	sys.v_$sysstat a, sys.v_$sysstat b
where 	a.name = 'sorts (disk)'
and 	b.name = 'sorts (memory)';
prompt </TABLE><P><HR WIDTH="100%"><P>

------------------
-- SGA Information
------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="3"><B>SGA Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>'||name||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1">'||to_char(value,'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	sys.v_$sga;
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1"><B>TOTAL SGA</B></FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="1"><B>'||to_char(sum(value),'999G999G999G999G999')||'</B></FONT></TD>
	</TR>'
from 	sys.v_$sga;
prompt </TABLE><P><HR WIDTH="100%"><P>

--------------------------
-- Key init.ora Parameters
--------------------------
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="3"><B>Key INIT.ORA Parameters</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Parameter</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Value</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Is Default<B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>Session<BR>Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="1"><B>System<BR>Modifiable</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="1"><B>Is Modified</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="1">'||name||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="1">'||nvl(value,'&nbsp;')||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||isdefault||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||isses_modifiable||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||issys_modifiable||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="1">'||ismodified||'</FONT></TD>
	</TR>'
from 	sys.v_$parameter
where   name in (
	'background_dump_dest',
	'compatible',
	'db_block_buffers',
	'db_block_size',
	'db_files',
	'db_name',
	'dml_locks',
	'ifile',
	'log_archive_start',
	'max_dump_file_size',
	'open_links',
	'optimizer_mode',
	'processes',
	'shared_pool_size',
	'sort_area_size',
	'sql_trace',
	'timed_statistics',
	'user_dump_dest',
	'utl_file_dir')
or      name like 'log_archive_dest%'
order  	by name;
prompt </TABLE><BR>
prompt </FONT></CENTER>

prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
spool off

