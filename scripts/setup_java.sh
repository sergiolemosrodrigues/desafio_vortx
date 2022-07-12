#!/bin/bash

if [ -f "/usr/lib/jvm/java-11-openjdk-amd64/bin/java" ]
then
	echo "Java ja instalado!"
else
	sudo apt install openjdk-11-jre -y
fi

exit 0
