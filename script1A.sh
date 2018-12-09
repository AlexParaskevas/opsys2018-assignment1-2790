#!/bin/bash

Afile=$1

if [ ! -f $1 ]; then
	echo "Wrong directory/cannot find List of Adresses"
	exit $?
fi


dir_name=~/Desktop/opsysA

if [ ! -f $dir_name ]; then
	mkdir -p $dir_name
else
	break;
fi

> ~/Desktop/opsysA/outfile.txt

while IFS=$'\n' read -r line; do

    if [[ ! $line == "#"* ]]; then

	curlstatus=`curl -s -w "%{http_code}\n" "$line" -o /dev/null` #curl each webpage/line
	pagetemp=`echo "$line" |  cut -d '/' -f 3` #keeps only the http://www.url.com/
	if [ $curlstatus == "200" ]; then
		if [ -f  ~/Desktop/opsysA/"$pagetemp".txt ]; then
			curl -s $lINE > /tmp/"$pagetemp".txt 
			if [ ! $(cmp -s ~/Desktop/opsysA/"$pagetemp".txt /tmp/"$pagetemp".txt) == "0" ]; then
				echo $line >> ~/Desktop/opsysA/outfile.txt
				rm ~/Desktop/opsysA/"$pagetemp".txt #removes the outdated output 
				mv /tmp/"$pagetemp".txt ~/Desktop/opsysA #replaces it with the updated		
			fi
		
		else
			echo "$line INIT"
			curl -s $line > ~/Desktop/opsysA/"$pagetemp".txt
		fi
	else
		echo "$line FAILED"
	fi

     fi

done < "$1"

if [ -s ~/Desktop/opsysA/outfile.txt ]; then
	echo "Changed URLs:"
	cat ~/Desktop/opsysA/outfile.txt
fi





