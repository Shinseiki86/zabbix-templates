#!/bin/bash

path_sh=$(dirname "$0")
cd $path_sh

printf "[" #> tablespace.json

/opt/glassfish3/glassfish/bin/asadmin list-domains | grep "-domain " | awk -F"-domain " '{ print t "{\"{#DOMAIN_NAME}\":\""$1"\", \"{#DOMAIN_STATUS}\":\""$2"\" }"} {t=","}'

printf "]" #>> tablespace.json