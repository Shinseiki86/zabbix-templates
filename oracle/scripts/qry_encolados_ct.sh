#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh
source $path_sh/exports.sh
export ORACLE_SID=ctc

sqlplus -S cnb/cnbgyforabd0 @qry_encolados_ct.sql | grep -A 1 - | grep -v - | awk '{print $1}'
