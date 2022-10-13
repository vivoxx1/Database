REM ===========================================================================================
REM
REM  Script:  snap9sec.sql
REM  Author:  Stewart McGlaughlin (dba@pobox.com)
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
start sql/profiles      -- Profiles
start sql/roles         -- Roles
start sql/roleprivs     -- Role Privileges
start sql/sysprivs      -- System Privileges
 

set termout on;
select 'Stop Time: '||sysdate||' ('||name||')' from sys.v_$database;
set termout off;
