#!/bin/bash

Afile=$1


dir_name=~/Desktop/OSProject

if [ ! -f $dir_name ]; then
	mkdir -p $dir_name
else
	break;
fi

>~/Desktop/OSProject/outfile.txt

while IFS='\n' read line do
    if [[$line == "#"*]]; then

	break
     
     else
	
	curlstatus=`curl -s -w "%{http_code}" "$line" -o /dev/null`
	pagetemp=`echo "$line" |  cut -d '/' -f 3`
	if [[$curlstatus == "200"]]; then
		if [[-f  ~/Desktop/OSProject/"$pagetemp".txt]]; then
			curl -s $LINE > /tmp/"$pagetemp".txt 
			if [[$(cmp -s ~/Desktop/OSProject/"$pagetemp".txt /tmp/"$pagetemp".txt)<>0]]; then
				echo $line >> ~/Desktop/OSProject/outfile.txt
				rm ~/Desktop/OSProject/outfile.txt
				mv /tmp/"$pagetemp".txt ~/Desktop/OSProject	
			fi
		
		else
			echo "$line INIT"
			curl -s $line > ~/Desktop/OSProject/"$pagetemp".txt
		fi
	else
		echo "$line Failed"
	fi

     fi

done < "$1"

if [[-f ~/Desktop/OSProject/outfile.txt]] then
	echo "Changed URLs:"
	cat ~/Desktop/OSProject/outfile.txt
else
	echo "ERROR"
fi





