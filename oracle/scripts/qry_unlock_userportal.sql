set pagesize 0 heading off feedback off verify off echo on trimspool on;
set LINESIZE 200;

update PORTAL_TRANSACCIONAL_GYF.USUARIO set IP_CONEXION_ACTUAL=null, FECHA_CONEXION_ACTUAL=null, SESSION_ID=null where NUMERO_DOCUMENTO='662556';
commit;
select * from PORTAL_TRANSACCIONAL_GYF.USUARIO
where NUMERO_DOCUMENTO='662556';
--where NUMERO_DOCUMENTO='&1';

exit;
