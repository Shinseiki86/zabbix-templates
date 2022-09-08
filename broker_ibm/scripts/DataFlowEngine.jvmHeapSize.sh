#!/bin/bash

#jvmMinHeapSize|jvmMaxHeapSize
group=$1
param=$2

mqsireportproperties ESBBRK -e $group -o ComIbmJVMManager -a | grep $param | awk -F"=" '{gsub("\47", "", $2)}{print $2}'


