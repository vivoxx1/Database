REM ===========================================================================================
REM
REM  Script:  snapdroptemp.sql
REM  Author:  Stewart McGlaughlin (dba@pobox.com)
REM  Date:    03-02-1999
REM
REM  Desc:    Run this script to cleanup all temporary views
REM           (in the event snapX.sql hangs)
REM        
REM  Usage:   sqlplus sys/<password> @snapdroptemp (from client)
REM
REM  Mods:    03-02-1999 wsm
REM            Script creation
REM
REM  OraSnap (Oracle Performance Snapshot)
REM
REM ===========================================================================================

drop view sys.orasnap_pts;
drop view sys.orasnap_user_hr;
drop view sys.orasnap_user_cursors;

exit
