set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;

SELECT TABLESPACE_NAME, SEGMENT_SPACE_MANAGEMENT FROM DBA_TABLESPACES where CONTENTS!='TEMPORARY' and STATUS='ONLINE';

exit;
