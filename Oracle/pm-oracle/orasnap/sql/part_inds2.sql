REM ===========================================================================================
REM
REM  Script:  part_inds2.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Index Level Partitioning Information...
set termout off

spool output/part_inds2.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="part_inds2.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=28>
prompt  <FONT SIZE="4"><B>Index Level Partitioning Information</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Index<BR>Owner (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Index<BR>Name (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Partitioning<BR>Name (3)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>High Value<BR>Length</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Partition<BR>Position</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Status</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Tablespace<BR>Name</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Pctfree</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Initrans</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Maxtrans</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Initial<BR>Extent</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Next<BR>Extent</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Min<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Max<BR>Extents</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Pct<BR>Increase</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Freelists</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Freelist<BR>Groups</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Logging</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER"><FONT FACE="Arial" SIZE="2"><B>Blevel</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Leaf<BR>Blocks</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Distinct<BR>Keys</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Avg Leaf Blocks<BR>Per Key</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Avg Data Blocks<BR>Per Key</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" ALIGN="CENTER" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Clustering<BR>Factor</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Num<BR>Rows</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Sample<BR>Size</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Last<BR>Analyzed</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Buffer<BR>Pool</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||index_owner||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||index_name||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||partition_name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||high_value_length||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||partition_position||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||status||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||tablespace_name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||pct_free||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||ini_trans||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||max_trans||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||to_char(initial_extent,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||decode(next_extent,NULL,'&nbsp;',to_char(next_extent,'999G999G999G999G999'))||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||min_extent||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||max_extent||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(pct_increase,NULL,'&nbsp;',pct_increase)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(freelists,NULL,'&nbsp;',freelists)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(freelist_groups,NULL,'&nbsp;',freelist_groups)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||logging||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(blevel,NULL,'&nbsp;',blevel)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(leaf_blocks,NULL,'&nbsp;',leaf_blocks)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(distinct_keys,NULL,'&nbsp;',distinct_keys)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(avg_leaf_blocks_per_key,NULL,'&nbsp;',avg_leaf_blocks_per_key)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(avg_data_blocks_per_key,NULL,'&nbsp;',avg_data_blocks_per_key)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(clustering_factor,NULL,'&nbsp;',clustering_factor)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(num_rows,NULL,'&nbsp;',num_rows)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(sample_size,NULL,'&nbsp;',sample_size)||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||decode(last_analyzed,NULL,'&nbsp;',last_analyzed)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||decode(buffer_pool,NULL,'&nbsp;',buffer_pool)||'</FONT></TD>
	</TR>'
from 	dba_ind_partitions
where   index_owner not in ('SYS','SYSTEM')
order by index_owner, index_name, partition_name;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/part_inds2.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

