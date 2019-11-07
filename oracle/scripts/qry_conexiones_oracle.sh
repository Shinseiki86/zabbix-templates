#!/bin/bash
path_sh=$(dirname "$0")
source $path_sh/exports.sh
export ORACLE_SID=ctc

sqlplus -S cnb/cnbgyforabd0 @/etc/zabbix/scripts/qry_conexiones_oracle.sql | grep -A 1 - | grep -v - | sed -e 's/^[[:space:]]*//'

