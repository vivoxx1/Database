REM ===========================================================================================
REM
REM  Script:  snap8gen.sql
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


-- GENERAL INFORMATION 
start sql/dbi           -- Database Information
start sql/ver           -- Version Information
start sql/options       -- Database Options
start sql/license       -- License Information
start sql/initora       -- Init.ora Parameters
start sql/undoc         -- Undocumented Parameters
start sql/allinitora    -- All Init.ora Parameters
start sql/sga           -- SGA Information
start sql/datafiles     -- Datafile Information
start sql/dbfiles       -- Database File Listing


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
