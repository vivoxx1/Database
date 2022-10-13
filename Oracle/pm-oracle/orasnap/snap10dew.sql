REM ===========================================================================================
REM
REM  Script:  snap10dew.sql
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


-- DISK I/O, EVENTS AND WAITS
start sql/sysstata      -- System Statistics (ALL)
start sql/sysevents     -- System Events (ALL)
start sql/sgastat       -- SGA Statistics
start sql/waitstat      -- Wait Statistics
start sql/sorts         -- Sort Statistics
start sql/datafileio    -- Datafile I/O


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
