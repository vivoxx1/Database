REM ===========================================================================================
REM
REM  Script:  snap9obj.sql
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


-- DATABASE OBJECTS
start sql/dbclusters    -- Database Clusters
start sql/dbjobs        -- Database Jobs
start sql/dblinks       -- Database Links
start sql/dbprocs       -- Database Procs/Packages
start sql/dbseqs        -- Database Sequences
start sql/dbsnaps       -- Database Snapshots
start sql/dbsyns        -- Database Synonyms
start sql/dbtrigs       -- Database Triggers
start sql/dbviews       -- Database Views


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
