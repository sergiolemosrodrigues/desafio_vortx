#!/bin/bash

existe=`ps -ef | grep java | grep metabase | awk '{print $2}' | wc -l`
if [ "$existe" -ge "1" ]
then
	ps -ef | grep java | grep metabase | awk '{print $2}' | xargs sudo kill -9
fi

if [ ! -d /var/opt/metabase ]
then
	sudo mkdir -p /var/opt/metabase
fi
cd /var/opt/metabase
sudo wget --quiet https://downloads.metabase.com/v0.35.4/metabase.jar

if [ "$existe" -eq "0" ]
then
	sudo nohup java -jar metabase.jar &
fi

sleep 120

exit 0
