REM ===========================================================================================
REM
REM  Script:  snap10ti.sql
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


-- TABLES AND INDEXES
start sql/tiloc         -- Table/Index Locations
start sql/unsureidx     -- Tables With Questionable Indexes
start sql/index5        -- Tables With More Than 5 Indexes
start sql/noindex       -- Tables Without Indexes
start sql/nopk          -- Tables Without Primary Key
start sql/chained       -- Tables Experiencing Chaining
start sql/discons       -- Disabled Constraints
start sql/fkcons        -- Foreign Key Constraints
start sql/fkindex       -- Foreign Key Problems 
start sql/inconsistent  -- Inconsistent Column Names    ***LONG RUNNING REPORT***
start sql/noextend      -- Object Extent Warning        ***LONG RUNNING REPORT***
start sql/large_objs    -- Large Objects
start sql/segfrag       -- Segments With Extents >= MaxExtents
start sql/segmax        -- Segment MaxExtents
start sql/analyzed      -- Analyzed Tables
start sql/analrecent    -- Recently Analyzed Tables (Last 14 Days)
start sql/tabcache      -- Cached Tables


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
