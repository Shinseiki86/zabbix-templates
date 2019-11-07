#!/bin/sh
#cd /usr/local/etc/scripts
expReg="(Alias name|Valid from|until)"

if [ "$1" = "" ]; then
	pathBin="/usr/java/default/bin"
else
	pathBin=$1
fi

if [ "$2" = "" ]; then
	passJks="Giros1234*!"
else
	passJks=$2
fi

if [[ ! -f "$pathBin/keytool" ]]; then
    echo "'$pathBin/keytool' doesn't exist."
	exit 0
fi

printf "[" #> keystore.json
#Se obtienen jks de los glassfish que se encuentran en ejecución.
listKeystore=`ps -ea -o command ww | grep -v grep | grep -oP '(?<=keyStore=).*?(jks)'`

echo $passJks
#Se mapean lineas con formato json
#jsonKeystore=`echo "$listKeystore" | awk '{print t "{\"{#JKSPATH}\":\""$1"\" }"} {t=","}'`
n=`echo "$listKeystore" | wc -l`
for jks in $listKeystore; do
	$pathBin/keytool -list -v -keystore $jks -storepass "$passJks" 2>/dev/null | grep "Alias name" | awk -F": " -v jks=$jks '{printf t "{\"{#JKSPATH}\":\""jks"\", \"{#CERTALIAS}\":\""$2"\"}" } {t=",\n"}' #>> keystore.json
	n=$((n-1))
	if [ $n -gt 0 ]; then
		echo "," #>> keystore.json
	fi
done

#Imprime resultado
printf "]" #>> keystore.json
#cat keystore.json