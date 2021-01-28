select count(1) 
from BDM.TRANSACTION_DISPERSION txd --MODULO BANCOS BDM
where txd.TRANSACTION_STATUS = 'B100' --delegadas
      and (BDM.get_last_resp_bankfile(txd.bash_banks_file_id,txd.ID)!='9999Pendiente de Respuesta otros bancos')
      and trunc(txd.TRANSACTION_DATE)>=trunc(sysdate)-5;
exit;
