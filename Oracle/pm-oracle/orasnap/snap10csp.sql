REM ===========================================================================================
REM
REM  Script:  snap10csp.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle.books.com/orasnap
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

ttitle          off
btitle          off

alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';

set termout on
select 'Start Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off


-- CURSOR AND SQL PROCESSING
start sql/listsql1      -- Disk Intensive SQL
start sql/listsql2      -- Buffer Intensive SQL
start sql/listsql3      -- Buffer SQL With Most Loads
start sql/resource2     -- Open Cursors By User
start sql/resource3     -- Running Cursor By User
start sql/userhit3      -- Low Ratio Open Cursors        ***LONG RUNNING REPORT***
start sql/userhit4      -- Low Ratio Running Cursors
start sql/userhit2      -- Low Ratio Object Access       ***LONG RUNNING REPORT***


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
