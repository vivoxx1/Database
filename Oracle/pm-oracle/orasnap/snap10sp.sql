REM ===========================================================================================
REM
REM  Script:  snap10sp.sql
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


-- SHARED POOL INFORMATION
start sql/shpool1       -- Library Cache Statistics
start sql/shpool2       -- Shared Pool Memory Usage
start sql/shpool3       -- Shared Pool Loads
start sql/shpool4       -- Shared Pool Executions
start sql/shpool5       -- Shared Pool Details
start sql/reservepool   -- Reserve Pool Settings
start sql/pinned        -- Pinned Objects


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
