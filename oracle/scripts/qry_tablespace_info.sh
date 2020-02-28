#!/bin/bash

path_sh=$(dirname "$0")
source $path_sh/exports.sh

export ORACLE_SID=$1
if [ "$3" == "10g" ]; then
	export ORA_HOME=10gR2
	export ORACLE_HOME=$ORACLE_BASE/app/db/10.2.0
	export TNS_ADMIN=$ORACLE_HOME/network/admin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib32
	export LD_LIBRARY_PATH_64=$ORACLE_HOME/lib
	export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$ORACLE_HOME/perl/bin:$PATH
else
	export ORA_HOME=11gR2
	export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P15
	export ORACLE_HOME=$ORACLE_BASE/app/db/11.2.0.4
	export TNS_ADMIN=$ORACLE_HOME/network/admin
	export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/lib32
	export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$JAVA_HOME/bin:$PATH
fi

sqlplus -S / as sysdba @$path_sh/qry_tablespace_info.sql $2
