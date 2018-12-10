#!/bin/bash

urlcheck()
{
	curl -s $1 > ~/Desktop/opsysB/"$pagetemp".txt #$1=$line
}

Afile=$1

if [ ! -f $1 ]; then
	echo "Wrong directory/cannot find List of Adresses"
	exit $?
fi

dir_name=~/Desktop/opsysB

if [ ! -f $dir_name ]; then
	mkdir -p $dir_name
else
	break;
fi

> ~/Desktop/opsysB/outfile.txt

while IFS=$'\n' read line; do 

    if [[ ! $line == "#"* ]]; then

	curlstatus=`curl -s -w "%{http_code}\n" "$line" -o /dev/null` #curl each webpage/line
	pagetemp=`echo "$line" |  cut -d '/' -f 3` #keeps only the http://www.url.com/
	if [ $curlstatus == "200" ]; then
		if [ -f  ~/Desktop/opsysB/"$pagetemp".txt ]; then
			curl -s $line > /tmp/"$pagetemp".txt 
			if [ "$cmp -s ~/Desktop/opsysB/"$pagetemp".txt /tmp/"$pagetemp".txt" != "" ]; then 
				echo $line >> ~/Desktop/opsysB/outfile.txt 
				rm ~/Desktop/opsysB/"$pagetemp".txt  #removes the outdated output 
				mv /tmp/"$pagetemp".txt ~/Desktop/opsysB  #replaces it with the updated	
			fi
		
		else
			echo "$line INIT" 			
			urlcheck "$line" & #passes line as first argument/with & runs in the backround
		fi
	else
		echo "$line FAILED" 
	fi

     fi

done < "$1"

if [ -s ~/Desktop/opsysB/outfile.txt ]; then
	echo "Changed URLs:"
	cat ~/Desktop/opsysB/outfile.txt

fi

rm ~/Desktop/opsysB/outfile.txt
