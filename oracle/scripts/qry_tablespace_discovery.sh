#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh
n=2 #cantidad de instancias (varios y unoee)

function getTbs(){
	tablespace=`sqlplus -S / as sysdba @$path_sh/qry_tablespace_discovery.sql`
	echo "$tablespace" | awk -v sid=$1 -v ver=$2 '{print t "{\"{#SID}\":\""sid"\", \"{#TABLESPACE}\":\""$1"\", \"{#VERSION}\":\""ver"\" }"} {t=","}' #>> tablespace.json
	n=$((n-1))
	if [ $n -ge 1 ]; then
		echo "," #>> tablespace.json
	fi
}

printf "[" #> tablespace.json


#10g
for sid in varios; do
	export ORACLE_SID=$sid
	getTbs $sid "10g"
done

#11g
export ORA_HOME=11gR2
export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P15
export ORACLE_HOME=$ORACLE_BASE/app/db/11.2.0.4
export TNS_ADMIN=$ORACLE_HOME/network/admin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/lib32
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$JAVA_HOME/bin:$PATH
for sid in unoee; do
	export ORACLE_SID=$sid
	getTbs $sid "11g"
done
printf "]" #>> tablespace.json
