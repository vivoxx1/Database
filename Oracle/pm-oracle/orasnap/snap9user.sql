REM ===========================================================================================
REM
REM  Script:  snap9user.sql
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


-- USER INFORMATION
start sql/userobjs      -- User Objects
start sql/spacealloc    -- User Space Allocated
start sql/invalid       -- Invalid Objects
start sql/usermod       -- User Modified Objects (Last 7 Days)
start sql/userprivs     -- User Privileges
start sql/useraccess    -- User Accessing
start sql/usersess      -- User Sessions
start sql/userhit1      -- User Hit Ratios
start sql/datatypes     -- Datatypes
start sql/defpass       -- Accounts With Default Password
 

set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
