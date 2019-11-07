--select count(ID_TRX) from REPORT_TRXS_QUEUE_MX_V where trunc(fecha)=trunc(SYSDATE);
--select count(ID_TRX) from CNB.REPORT_TRXS_QUEUE_MX_V v where trunc(fecha)=trunc(sysdate) and ((tipo_trx in('REC','REC_CANCEL') and id_cliente is null) or tipo_trx not like 'REC%') and (not (v.tipo_trx like 'PG%' and v.forma_pago not in ('ACH','GYF')) or v.forma_pago is null );
select count(ID_TRX) from CNB.REPORT_TRXS_QUEUE_MX_V v where fecha between trunc(sysdate) and sysdate-(5/1440) and tipo_trx not in ('REC_ADM','RECCANCEL');
exit;
