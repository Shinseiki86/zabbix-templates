#!/bin/bash

alias sqlplus='rlwrap sqlplus'
alias rman='rlwrap rman'
set -o emacs

path_sh=$(dirname "$0")
source $path_sh/exports.sh
export ORACLE_SID=ctc


cd /etc/zabbix/scripts
sqlplus -S cnb/cnbgyforabd0@ctc @qry_time_trx_apn.sql

