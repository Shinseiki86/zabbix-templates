#!/bin/bash

path_sh=$(dirname "$0")
source $path_sh/exports.sh

export ORACLE_SID=$1

sqlplus -S / as sysdba @/etc/zabbix/scripts/qry_tablespace_info.sql $2