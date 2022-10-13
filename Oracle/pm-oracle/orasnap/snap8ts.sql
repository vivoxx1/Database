REM ===========================================================================================
REM
REM  Script:  snap8ts.sql
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


-- TABLESPACE INFORMATION
start sql/tsinfo        -- Tablespace Information
start sql/tsquota       -- Tablespace Quotas
start sql/tscoal        -- Tablespace Coalesced Extents
start sql/tsusage       -- Tablespace Usage
start sql/tssys         -- User Default Tablespace = SYSTEM
start sql/objsys        -- User Objects In SYSTEM Tablespace
start sql/addextent     -- Freespace And Largest Extent
start sql/autoext       -- AutoExtend Information


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
