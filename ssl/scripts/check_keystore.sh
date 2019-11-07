#!/bin/sh
#cd /usr/local/etc/scripts

expReg="(Alias name|Valid from|until)"
pathBin="/usr/java/default/bin"
passJks="Giros1234*!"
echo $passJks
if [ "$1" = "" ]; then
	echo "Error: Ruta a jks requerida."
	exit 1
else
	pathJks=$1
fi

if [ "$2" = "" ]; then
	echo "Error: Alias del certificado requerido."
	exit 2
else
	aliasCert=$2
fi

if [ "$3" != "" ]; then
	passJks=$3
fi

if [ "$4" != "" ]; then
	pathBin=$4
fi

if [[ ! -f "$pathJks" ]]; then
    echo "$pathJks doesn't exist."
	exit 0
fi

if [[ ! -f "$pathBin/keytool" ]]; then
    echo "'$pathBin/keytool' doesn't exist."
	exit 0
fi

$pathBin/keytool -list -v -keystore $pathJks -storepass $passJks -alias "$aliasCert" 2>/dev/null | grep 'Valid from' | awk -F": " '{print $3}' | while read dt
do
	UNTIL_SECONDS=`date -d "$dt" +%s`
	#REMAINING_DAYS=$(( ($UNTIL_SECONDS -  $(date +%s)) / 60 / 60 / 24 ))
	REMAINING_DAYS=$(( ($UNTIL_SECONDS -  $(date +%s)) ))
	printf "%d\n" $REMAINING_DAYS
done | sort -n | head -n 1 

