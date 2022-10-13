REM ===========================================================================================
REM
REM  Script:  snap8part.sql
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


-- PARTITION INFORMATION
start sql/part_tabs        -- Partition Tables
start sql/part_inds        -- Partition Indexes
start sql/part_key         -- Partition Key Columns
start sql/part_tabs2       -- Table Level Partition Information
start sql/part_inds2       -- Index Level Partition Information


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
