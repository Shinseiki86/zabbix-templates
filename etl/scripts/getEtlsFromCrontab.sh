#!/bin/bash
cd /root
#Inicio Json
printf "[\n" >  crontab.json
#Se filtran lineas que contengan programación de ETL
strCrontab=`sed '/^#/d;/^$/d;/kitchen.sh/!d;s/ root /°/;s/ \/file /°/;s/ \/level /°/;s/ > /°/;s/\"//g;s/\\\//g' /etc/crontab`
#Se mapean lineas con formato json
echo "$strCrontab" | awk -F"°" '{gsub(/^ +| +$/,"")} { v=substr($2,index($2,"pdi-ce-")); v=substr(v,0,index(v,"/")-1) ; n=split($5,f,"/"); gsub(f[n],"",$5); print t "{\"{#ETLCRON}\":\""$1"\", \"{#ETLVERSION}\":\""v"\", \"{#ETLFILE}\":\""$3"\", \"{#ETLLOGLEVEL}\":\""$4"\", \"{#ETLLOGNAME}\":\""f[n]"\", \"{#ETLLOGPATH}\":\""$5"\" }"} {t=","}' >> crontab.json
#Fin Json
printf "]\n" >>  crontab.json

#Imprime resultado
cat crontab.json
