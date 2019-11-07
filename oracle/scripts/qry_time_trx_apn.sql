set pagesize 0 heading off feedback off verify off echo off trimspool on;
set LINESIZE 200;
spool qry_time_trx_apn.log append;

select to_char(txa.transaction_date,'RRRR-MM-DD HH24:MI:SS.FF')||';'||to_char(TRUNC(SYSDATE-(2/1440),'MI'),'HH24:MI:SS')||';'||txa.transaction_id_wu||';'||extract(second from (aud_end.DATE_OP-aud_ini.DATE_OP)) as resp
from GYF_APN.TRANSACTION_APN txa, CNB.AUDIT_TRANSACTION_DET aud_ini, CNB.AUDIT_TRANSACTION_DET aud_end 
where txa.TRANSACTION_TYPE_ID=1 and txa.TRANSACTION_DATE >= TRUNC(SYSDATE-(2/1440),'MI')
    and aud_ini.ID_TRANSACTION=txa.TRANSACTION_ID_WU and aud_ini.ID_SENDER='TBD'
    and aud_end.ID_TRANSACTION=txa.TRANSACTION_ID_WU and aud_end.ID_SENDER='TBD'
    and aud_ini.DATE_OP=(select min(aud.DATE_OP) from CNB.AUDIT_TRANSACTION_DET aud
                    where aud.ID_TRANSACTION=txa.TRANSACTION_ID_WU and aud.SERVICE_NAME='SrvIntAPN|FcdRest|Req' and trunc(aud.date_op)=trunc(txa.transaction_date))
    and aud_end.DATE_OP=(select min(aud.DATE_OP) from CNB.AUDIT_TRANSACTION_DET aud
    where aud.ID_TRANSACTION=txa.TRANSACTION_ID_WU and aud.SERVICE_NAME='SrvIntAPN|FcdRest|Resp' and trunc(aud.date_op)=trunc(txa.transaction_date))
;
spool off;
exit;