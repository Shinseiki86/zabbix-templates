set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;
col "Pct. used" for 990.90

SELECT round(100 * ( (df.bytes - fs.bytes)/ df.bytes), 2) "Pct. used"
FROM (SELECT tablespace_name ,Sum(bytes) AS bytes
        FROM dba_free_space
        GROUP BY tablespace_name
	) fs
	,(SELECT tablespace_name, SUM(bytes) AS bytes
        FROM dba_data_files
        GROUP BY tablespace_name
    ) df
WHERE fs.tablespace_name = df.tablespace_name
AND fs.tablespace_name='&1';

exit;
