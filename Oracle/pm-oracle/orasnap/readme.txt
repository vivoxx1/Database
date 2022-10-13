____________________________________________________________

OraSnap (Oracle Snapshot), Version 2008.01.14
Written by Stewart McGlaughlin
http://www.oracle-books.com/orasnap
Resale is prohibited - All rights reserved
____________________________________________________________


CONTENTS OF THIS FILE
---------------------
- Platforms
- Introduction
- How to use OraSnap
- How to rerun reports
- Revision history
- OraSnap FAQ
- Terms of usage
- Disclaimer
- Special Thanks
- How to contact the author


PLATFORMS
---------
Windows 95/98/ME/NT/XP/2000/Vista, UNIX, Linux


INTRODUCTION
------------
OraSnap is a utility that gathers performance information from
an Oracle v7.3.x, v8.x, v9.x and v10.x database.  These scripts can
aid in tuning and optimizing your database - hopefully, making
your life a little easier.

These scripts are the same scripts that most of us already have
in our arsenal.  The "twist" is the way the information is
presented.  All of the statistics are generated with HTML
tags - which can then be viewed with a web browser.
Each report also contains a "notes"  section describing
relevant information about the statistics gathered (which you
can modify) and the source code that generated the report.

Once you've downloaded and installed OraSnap - click on the
new SQL*Plus shortcut, login as SYS and just run the main
snapshot script:
  - snap7.sql for v7.3.x databases
  - snap8.sql for v8.x databases
  - snap9.sql for v9.x databases
  - snap10.sql for v10.x databases
When the script completes, you then point your browser to the
index.htm file located in that working directory.

OraSnap is an updated/reworked version of Hayden Worthington's
free Performance Snapshot Library.  OraSnap now has over 110
reports.


HOW TO USE ORASNAP
------------------
1) ALWAYS uninstall the previous version of OraSnap

2) Run orasnapYYYY.MM.DD.exe to install OraSnap on your C: drive
   The following directories will be created:
     C:\OraSnap          (OraSnap default directory)
     C:\OraSnap\main     (html frame definition)
     C:\OraSnap\notes    (note directory)
     C:\OraSnap\output   (output directory)
     C:\OraSnap\source   (source code directory)
     C:\OraSnap\sql      (sql scripts)
   The following START MENU items will be created:
     OraSnap             (new folder - under PROGRAMS)
     OraSnap Output      (sample/last output from OraSnap)
     OraSnap Output(Mini)(last output from mini-OraSnap)
     Readme Notes        (this file)
     SQL-Plus (OS)       (shortcut to your SQL*Plus executable)
     SQL-Plus (OS) Wrap  (interactive reporting)
     Uninstall OraSnap   (uninstall OraSnap)
     Visit OraSnap       (internet shortcut)
     Yahoo! OraSnap      (internet shortcut)

     The installation will search your PC for a SQL*Plus
     executable and create a shortcut in the OraSnap folder

   To view a sample report, open "OraSnap Output"
   [Start Menu --> Programs --> OraSnap --> OraSnap Output]

3) Start a SQL*Plus session (use the "OraSnap SQL*Plus" shortcut!)
   [Start Menu --> Programs --> OraSnap --> SQL-Plus]
   Enter username, Password, and Host String
   - or -
   Open a DOS window, cd to your OraSnap directory, and
   login to SQL*Plus as SYS
     C:\>cd \orasnap
     C:\orasnap>sqlplusw "/ as sysdba"

4) Run snap.sql
   You should see the following output:
     SQL> @snap
     Start Time: 29-MAY-2007 21:10:24 ($ORACL_SID)
     Retrieving Mini Snapshot Information...
     Retrieving Database Information...
     Retrieving Version Information...
     Retrieving Database Options...
     Retrieving License Information...
     Retrieving INIT.ORA Parameters...
     Retrieving Undocumented INIT.ORA Parameters...
     Retrieving All INIT.ORA Parameters...
     .
     .
     End Time: 29-MAY-2007 21:18:04 ($ORACLE_SID)

5) Open C:\OraSnap\index.htm with your favorite browser
   [Start Menu --> Programs --> OraSnap --> OraSnap Output]


IMPORTANT: Do NOT launch a SQL*Plus session and reference the
snap.sql script (i.e. @c:\orasnap\snap.sql) - you MUST BE in
your OraSnap directory when you start the script.  All of the
output is spooled to your current directory!

NOTE: If you downloaded the zip version (without installer), be
sure to specify the option which preserves directory structure
in the archive. Otherwise the directory tree will be flattened
and none of the necessary subdirs will be created.

HOW TO RERUN REPORTS
--------------------
As of version 1.2.0 of OraSnap, you can rerun a subset
of reports.  The script name is defined under each category
(in the left frame).

Example:
General Info & Init Params
(snap7gen or snap8gen or snap9gen or snap10gen)

You can rerun the reports associated with this category by
running snap7gen or snap8gen or snap9gen or snap10gen.

snap#gen:  General Information reports
snap#ts:   Tablespace Information reports
snap#rbs:  Rollabck Information reports
snap#user: User Information reports
snap#ti:   Tables & Index reports
snap#part: Partition reports
snap#obj:  Database Object reports
snap#hmr:  Hit & Miss Ratio reports
snap#dew:  Disk I/O, Events & Wait reports
snap#fts:  Full Table Scan reports
snap#dd:   Data Dictionary reports
snap#csp:  Cursor & SQL Processing reports
snap#lock: Lock reports
snap#sess: Session Statistic reports
snap#sp:   Shared Pool reports
snap#redo: Redo Log reports
snap#tpc:  Two Phase Commit reports
snap#misc: Miscellaneous reports

snap7mini/snap8mini/snap9mini/snap10mini: Mini Snapshot


I've also added a new short-cut "SQL*Plus v# Wrapper" to
the install.  This calls a script (snapwrap.sql) and
prompts you for the reports to run against the database.
You can choose to run one, several, or all the OraSnap
reports.  Keep in mind that the output spools to the
default output directory - which means it will replace
the most recent reports.


REVISION HISTORY
----------------
See changes.txt


ORASNAP FAQ
-----------
http://www.oracle-books.com/orasnap/faq.html


TERMS OF USAGE
--------------
This software is provided "as is" and any express or implied
warranties, including, but not limited to, the implied warranties
of merchantability and fitness for a particular purpose are
disclaimed.  In no event shall the author or contributors be
liable for any direct, indirect, incidental, special, exemplary,
or consequential damages (including, but not limited to,
procurement of substitute goods or services; loss of use, data,
or profits; or business interruption) however caused and on any
theory of liability, whether in contract, strict liability, or
tort (including negligence or otherwise) arising in any way out
of the use of this software, even if advised of the possibility
of such damage.


DISCLAIMER
----------
This version of OraSnap is distributed as Freeware.  This means
you don't have to pay for this software, just enjoy it!

You may distribute it by making it available on online-services and
distribution CD's and/or other media, provided the distribution
files are unmodified and kept together.  I would appreciate receiving
a copy of the CD and/or book it will be distributed on/with.

You may not ask money for the program itself, only for the
distribution of the program. Use of this program is at your
own risk.

I've had requests of people wanting to donate regardless of the
fact that OraSnap is free.  Since I can use the money to continue
the development of OraSnap and webhosting fees, I've decided to
accept donations via PayPal.

Some of the scripts have been gathered from various sources
and the author wishes to acknowledge this fact.


SPECIAL THANKS
--------------
James Ellis
Jeff Pell
Jordan Russell (Inno Setup)
Ned Voorhees
Paige, Peyton & Emory (My family)
Rich Gesler
Steve Baber
Carlos SS
Yahoo! OraSnap Group


HOW TO CONTACT THE AUTHOR
-------------------------
Please post all comments/suggestions on the OraSnap Yahoo
group website at http://tech.groups.yahoo.com/group/orasnap.
I would also appreciate any bug/error information that
would help me with future releases.

Enjoy!

Stewart McGlaughlin
http://www.oracle-books.com/orasnap
http://tech.groups.yahoo.com/group/orasnap
