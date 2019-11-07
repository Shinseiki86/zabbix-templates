select count(*) from INTEGRACION.ESB_REPROCESS_REQUEST where trunc(transaction_date)=trunc(sysdate) and state='FALLO' and action!='REPROCESAR';
exit;
