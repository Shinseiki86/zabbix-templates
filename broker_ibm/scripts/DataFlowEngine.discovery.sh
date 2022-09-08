#!/bin/bash
. /opt/ibm/mqsi/8.0.0.9/bin/mqsiprofile
ODBCINI=/opt/ibm/mqsi/ODBC/odbc.ini
export ODBCINI
ODBCSYSINI=/opt/ibm/mqsi/ODBC
export ODBCSYSINI

groupsflow=(`mqsilist ESBBRK | grep ESBBRK | awk -F"'" '{print $2}'`)
t=""
printf "["
for i in ${!groupsflow[@]}; do
	port=`mqsireportproperties ESBBRK -e ${groupsflow[i]} -o ComIbmJVMManager -a | grep jvmSystemProperty | awk -F "=" 'BEGIN{RS=" -"} { print }' | grep Dcom.sun.management.jmxremote.port | awk -F "=" '{ print $2 }'`
	printf "$t { \"{#GROUPFLOW}\":\""${groupsflow[i]}"\" , \"{#JMXPORT}\":\""$port"\" }"
	t=","
done
printf "]"
