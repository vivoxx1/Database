REM ===========================================================================================
REM
REM  Script:  datafileio.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving Disk I/O By Data File...
set termout off

spool output/datafileio.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="datafileio.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>Disk I/O By Datafile (Total Block I/Os)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>File Name</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical<BR>Reads</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Reads %</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical<BR>Writes</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Writes %</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Total Block<BR>I/O (1)</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(phyrds,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round((phyrds / pd.phys_reads)*100,2)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(phywrts,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round(phywrts * 100 / pd.phys_wrts,2)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(to_number(fs.phyblkrd+fs.phyblkwrt),'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	(select sum(phyrds) phys_reads,
	sum(phywrts) phys_wrts
	from sys.v_$filestat) pd,
	sys.v_$datafile df,
	sys.v_$filestat fs
where 	df.file# = fs.file#
order 	by fs.phyblkrd+fs.phyblkwrt desc;
prompt </TABLE><P>

prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>Disk I/O By Datafile (Reads)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>File Name</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical<BR>Reads (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Reads %</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Total Block<BR>I/O</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(phyrds,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round((phyrds / pd.phys_reads)*100,2)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(to_number(fs.phyblkrd+fs.phyblkwrt),'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	(select sum(phyrds) phys_reads,
	sum(phywrts) phys_wrts
	from sys.v_$filestat) pd,
	sys.v_$datafile df,
	sys.v_$filestat fs
where 	df.file# = fs.file#
order 	by phyrds desc;
prompt </TABLE><P>

prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=4>
prompt  <FONT SIZE="4"><B>Disk I/O By Datafile (Writes)</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>File Name</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Physical<BR>Writes (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Writes %</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Total Block<BR>I/O</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||name||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(phywrts,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||round(phywrts * 100 / pd.phys_wrts,2)||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(to_number(fs.phyblkrd+fs.phyblkwrt),'999G999G999G999G999')||'</FONT></TD>
	</TR>'
from 	(select sum(phyrds) phys_reads,
	sum(phywrts) phys_wrts
	from sys.v_$filestat) pd,
	sys.v_$datafile df,
	sys.v_$filestat fs
where 	df.file# = fs.file#
order 	by phywrts desc;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/datafileio.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

