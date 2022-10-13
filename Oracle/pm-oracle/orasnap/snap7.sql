REM ===========================================================================================
REM
REM  Script:  snap7.sql
REM  Author:  Stewart McGlaughlin (orasnap@hotmail.com)
REM  Website: http://www.oracle.books.com/orasnap
REM
REM  Desc:    This script generates HTML formatted reports.
REM        
REM  Notes:   This script is designed for an Oracle v7.3.x database.
REM           Use snap8.sql for v8.x databases.
REM           Use snap9.sql for v9.x databases.
REM           Use snap10.sql for v10.x databases.
REM
REM  Usage:   sqlplus sys/<password> @snap7 (from client)
REM
REM  Mods:    See README.TXT for revision history
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


-- MINISNAP
start sql/minisnap7     -- Quick DB Snapshot

-- GENERAL INFORMATION 
start sql/dbi_v7           -- Database Information
start sql/ver           -- Version Information
start sql/options       -- Database Options
start sql/license       -- License Information
start sql/initora       -- Init.ora Parameters
start sql/undoc         -- Undocumented Parameters
start sql/allinitora    -- All Init.ora Parameters
start sql/sga           -- SGA Information
start sql/datafiles     -- Datafile Information
start sql/dbfiles_v7    -- Database File Listing

-- TABLESPACE INFORMATION
start sql/tsinfo_v7     -- Tablespace Information
start sql/tsquota       -- Tablespace Quotas
start sql/tscoal        -- Tablespace Coalesced Extents
start sql/tsusage       -- Tablespace Usage
start sql/tssys         -- User Default Tablespace = SYSTEM
start sql/objsys        -- User Objects In SYSTEM Tablespace
start sql/addextent     -- Freespace And Largest Extent
start sql/autoext_v7    -- AutoExtend Information

-- ROLLBACK INFORMATION
start sql/rollback      -- Rollback Segments
start sql/rbscont       -- Rollback Contention
start sql/rbsgrowth     -- Rollback Growth
start sql/rbsuser       -- Rollback Users
start sql/rbsxaction    -- Rollback Transactions

-- USER INFORMATION
start sql/userobjs_v7   -- User Objects
start sql/spacealloc    -- User Space Allocated
start sql/invalid       -- Invalid Objects
start sql/usermod       -- User Modified Objects (Last 7 Days)
start sql/userprivs     -- User Privileges
start sql/useraccess    -- User Accessing
start sql/usersess      -- User Sessions
start sql/userhit1      -- User Hit Ratios
start sql/datatypes     -- Datatypes
start sql/defpass       -- Accounts With Default Password
 
-- TABLES AND INDEXES
start sql/tiloc     	-- Table/Index Locations
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

-- PARTITION INFORMATION
start sql/part_tabs_v7  -- Partition Tables
start sql/part_inds_v7  -- Partition Indexes
start sql/part_key_v7   -- Partition Key Columns
start sql/part_tabs2_v7 -- Table Level Partition Information
start sql/part_inds2_v7 -- Index Level Partition Information

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

-- HIT AND MISS RATIOS
start sql/buffhit       -- Buffer Hit Ratio
start sql/libhit        -- SQL Cache Hit Ratio
start sql/ddhit         -- Data Dictionary Hit Ratio
 
-- DISK I/O, EVENTS AND WAITS
start sql/sysstata      -- System Statistics (ALL)
start sql/sysevents     -- System Events (ALL)
start sql/sgastat       -- SGA Statistics
start sql/waitstat      -- Wait Statistics
start sql/sorts         -- Sort Statistics
start sql/datafileio    -- Datafile I/O

-- FULL TABLE SCANS
start sql/sysstatt      -- System Statistics (Table)
start sql/pts           -- Process Table Scans
start sql/ptsavg        -- Process Table Scans (Average)

-- DATA DICTIONARY INFO
start sql/dictcache     -- Dictionary Cache
start sql/latch         -- Latch Gets And Misses

-- CURSOR AND SQL PROCESSING
start sql/listsql1      -- Disk Intensive SQL
start sql/listsql2      -- Buffer Intensive SQL
start sql/listsql3      -- Buffer SQL With Most Loads
start sql/resource2     -- Open Cursors By User
start sql/resource3     -- Running Cursor By User
start sql/userhit3      -- Low Ratio Open Cursors       ***LONG RUNNING REPORT***
start sql/userhit4      -- Low Ratio Running Cursors 
start sql/userhit2      -- Low Ratio Object Access      ***LONG RUNNING REPORT***

-- LOCKS
start sql/locks         -- Lock Information             ***LONG RUNNING REPORT***
start sql/locksql       -- SQL Lock Information         ***LONG RUNNING REPORT***

-- SESSION STATISTICS
start sql/sesstime      -- Session Time
start sql/sessio        -- Session I/O By User
start sql/sescpu        -- CPU Usage By Session
start sql/resource1     -- Resource Usage By User
start sql/sesstat       -- Session Stats By Session
start sql/curusage      -- Cursor Usage By Session

-- SHARED POOL INFORMATION
start sql/shpool1       -- Library Cache Statistics
start sql/shpool2       -- Shared Pool Memory Usage
start sql/shpool3       -- Shared Pool Loads
start sql/shpool4       -- Shared Pool Executions
start sql/shpool5_v7    -- Shared Pool Details
start sql/reservepool   -- Reserve Pool Settings
start sql/pinned        -- Pinned Objects

-- REDO LOGS
start sql/redoinfo      -- Redo Log Information
start sql/redoswitch_v7 -- Redo Log Switches
start sql/redostat      -- Redo Buffer Statistics
start sql/redocont      -- Redo Log Buffer Contention

-- TWO PHASE COMMIT
start sql/tpcpending    -- Two Phase Commit Pending Information
start sql/tpcneighbor   -- Two Phase Commit Neighbor Information

-- MISCELLANEOUS REPORTS
start sql/dbgrowth_v7   -- Database Growth
start sql/cpinterval_v7 -- Check Point Interval Summary
start sql/avgwrque      -- Write Request Queue Size
start sql/dbwrlazy      -- Lazy DBWR Indicators


set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;

exit
