set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;
col "Pct. used" for 990.90

WITH files AS (SELECT tablespace_name, COUNT (*) tbs_files, SUM (BYTES) total_tbs_bytes
                FROM dba_data_files
                GROUP BY tablespace_name),
     fragments AS (SELECT tablespace_name, COUNT (*) tbs_fragments, SUM (BYTES) total_tbs_free_bytes, MAX (BYTES) max_free_chunk_bytes
                FROM dba_free_space
                GROUP BY tablespace_name),
     AUTOEXTEND AS (SELECT   tablespace_name, SUM (size_to_grow) total_growth_tbs
                FROM (SELECT  tablespace_name, SUM (maxbytes) size_to_grow
                        FROM dba_data_files
                        WHERE autoextensible = 'YES'
                        GROUP BY tablespace_name
                        UNION
                        SELECT   tablespace_name, SUM (BYTES) size_to_grow
                            FROM dba_data_files
                           WHERE autoextensible = 'NO'
                        GROUP BY tablespace_name)
                GROUP BY tablespace_name)
SELECT round( (files.total_tbs_bytes - fragments.total_tbs_free_bytes)/AUTOEXTEND.total_growth_tbs *100 ,2) "Pct. used"
FROM dba_tablespaces a, files, fragments, AUTOEXTEND
WHERE a.tablespace_name = files.tablespace_name
    AND a.tablespace_name = fragments.tablespace_name
    AND a.tablespace_name = AUTOEXTEND.tablespace_name
    and a.tablespace_name='&1'
   --and a.BIGFILE='NO'
;


exit;
