REM ===========================================================================================
REM
REM  Script:  locksql.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle-books.com/orasnap
REM
REM ===========================================================================================

set termout on
prompt Retrieving SQL Associated with Locks...
set termout off

spool output/locksql.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY BGCOLOR="#C0C0C0">
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="locksql.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=9>
prompt  <FONT SIZE="4"><B>SQL Associated With Locks</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Oracle User (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>SID (2)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Serial#</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Type</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Held</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Requested</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>ID1</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>ID2</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>SQL</B></FONT></TD>
prompt </TR>
select 	/*+ RULE */'<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||nvl(sn.Username,'&nbsp;')||'</FONT></TD>
       	<TD><FONT FACE="Arial" SIZE="2">'||nvl(m.Sid,'&nbsp;')||'</FONT></TD>
       	<TD><FONT FACE="Arial" SIZE="2">'||sn.Serial#||'</FONT></TD>
       	<TD><FONT FACE="Arial" SIZE="2">'||m.Type||'</FONT></TD>
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
        <TD><FONT FACE="Arial" SIZE="2">'||m.Id1||'</FONT></TD>
        <TD><FONT FACE="Arial" SIZE="2">'||m.Id2||'</FONT></TD> 
        <TD><FONT FACE="Arial" SIZE="2">'||t.Sql_Text||'</FONT></TD>
	</TR>'
from sys.v_$session sn, sys.v_$lock m, sys.v_$sqltext t 
where t.Address = sn.Sql_Address 
and t.Hash_Value = sn.Sql_Hash_Value 
and ( (sn.Sid = m.Sid 
	and m.Request != 0) 
or (sn.Sid = m.Sid 
        and m.Request = 0 and Lmode != 4 
        and (id1, id2) in
        (select s.Id1, s.Id2 
        	from sys.v_$lock s 
             	where Request != 0 
               	and s.Id1 = m.Id1 
               	and s.Id2 = m.Id2)  ) )
order by sn.Username, sn.Sid, t.Piece;
prompt </TABLE><BR>
prompt <FORM ACTION="../source/locksql.htm" METHOD=GET>
prompt <INPUT TYPE=submit NAME=foo VALUE="Source Code"></FORM>
prompt </FONT></CENTER>
prompt <SCRIPT LANGUAGE="JavaScript" SRC="footer.js"></SCRIPT>
prompt </BODY></HTML>
spool off

