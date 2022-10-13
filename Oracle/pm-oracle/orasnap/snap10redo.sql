REM ===========================================================================================
REM
REM  Script:  snap10redo.sql
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


-- REDO LOGS
start sql/redoinfo      -- Redo Log Information
start sql/redoswitch    -- Redo Log Switches
start sql/redostat      -- Redo Buffer Statistics
start sql/redocont      -- Redo Log Buffer Contention


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
