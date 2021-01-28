set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;

Select name,total_mb,free_mb from v$asm_diskgroup;

exit;
