select count(1) from INTEGRACION.ESB_REPROCESS_REQUEST where TRUNC(TRANSACTION_DATE)>=TRUNC(SYSDATE)-1 and ACTION='PENDIENTE' and STATE='FALLO' and SERVICE_NAME='SrvIntAPNNotifyStatus';
exit;
