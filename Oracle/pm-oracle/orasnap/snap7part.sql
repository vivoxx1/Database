REM ===========================================================================================
REM
REM  Script:  snap7part.sql
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
start sql/part_tabs_v7   -- Partition Tables
start sql/part_inds_v7   -- Partition Indexes
start sql/part_key_v7    -- Partition Key Columns
start sql/part_tabs2_v7  -- Table Level Partition Information
start sql/part_inds2_v7  -- Index Level Partition Information


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
