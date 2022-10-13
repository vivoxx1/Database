REM ===========================================================================================
REM
REM  Script:  RMANBS.sql
REM  Author:  Sulistyo Ade Suryawan
REM  Website: 
REM
REM ===========================================================================================

set termout on
prompt Retrieving Available RMAN Backup Sets...
set termout off

spool output/RMANBS.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="RMANBS.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=15>
prompt  <FONT SIZE="4"><B>RMAN Backup Sets</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>

prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>BS Key</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Backup Type</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Device Type</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Controlfile Included</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>SPFILE Included</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Incremental Level</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B># of Pieces</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Start Time</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>End Time</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Elapsed Seconds</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Tag</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Block Size</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Keep</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Keep Until</B></FONT></TD>
prompt  <TD BGCOLOR="#CCCC99" ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2"><B>Keep Options</B></FONT></TD>
prompt </TR>


select '<TR>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.recid||'</FONT></TD>
	<TD NOWRAP><FONT FACE="Arial" SIZE="2">'||backup_type||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||device_type||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'|| DECODE(bs.controlfile_included, 'NO', '-', bs.controlfile_included)||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||NVL(sp.spfile_included, '-')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.incremental_level||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.pieces||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||TO_CHAR(bs.start_time, 'mm/dd/yyyy HH24:MI:SS')||'</FONT></TD>
    <TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||TO_CHAR(bs.completion_time, 'mm/dd/yyyy HH24:MI:SS')||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.elapsed_seconds||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bp.tag||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.block_size||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.keep||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||NVL(TO_CHAR(bs.keep_until, 'mm/dd/yyyy HH24:MI:SS'), '<br>') ||'</FONT></TD>
	<TD ALIGN="RIGHT"><FONT FACE="Arial" SIZE="2">'||bs.keep_options||'</FONT></TD>
	</TR>'
FROM
    v$backup_set                         bs
  , (select distinct
         set_stamp
       , set_count
       , tag
       , device_type
     from v$backup_piece
     where status in ('A', 'X'))           bp
 ,  (select distinct set_stamp, set_count, 'YES' spfile_included
     from v$backup_spfile)                 sp
WHERE
      bs.set_stamp = bp.set_stamp
  AND bs.set_count = bp.set_count
  AND bs.set_stamp = sp.set_stamp (+)
  AND bs.set_count = sp.set_count (+)
ORDER BY
    bs.recid;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/RMANBS.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

