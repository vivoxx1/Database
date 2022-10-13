REM ===========================================================================================
REM
REM  Script:  snap.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle.books.com/orasnap
REM
REM  Desc:    This script calls the appropriate snap#.sql script.
REM        
REM  Usage:   sqlplus sys/<password> @snap (from client)
REM
REM ===========================================================================================

set echo        off
set feedback    off
set verify      off
set heading     off
set termout     off
set pause       off
set define      off
set timing      off

set trimspool   on

set pagesize    0
set linesize    500

ttitle off
btitle off

spool snaprun.sql
select '@snap'||substr(version,1,instr(version,'.')-1) 
from   v$instance;
spool off

@snaprun

exit
