REM ===========================================================================================
REM
REM  Script:  snap8sess.sql
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


-- SESSION STATISTICS
start sql/sesstime      -- Session Time
start sql/sessio        -- Session I/O By User
start sql/sescpu        -- CPU Usage By Session
start sql/resource1     -- Resource Usage By User
start sql/sesstat       -- Session Stats By Session
start sql/curusage      -- Cursor Usage By Session


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
