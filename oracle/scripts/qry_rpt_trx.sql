set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;

select "group"||'_'||transaction_type, "COUNT" from CNB.RPT_ZABBIX_TRX;

exit;
