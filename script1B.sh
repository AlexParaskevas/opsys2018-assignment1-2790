#!/bin/bash

Afile=$1

dir_name=~/Desktop/OSProject

if [ ! -f $dir_name ]; then
	mkdir -p $dir_name
else
	break;
fi

> ~/Desktop/OSProject/outfile.txt

while IFS='\n' read line do 
    if [[$line == "#"*]]; then

	break
     
     else
	
	curlstatus=`curl -s -w -o /dev/null "%{http_code}" "$line" ` #curl each webpage/line
	pagetemp=`echo "$line" |  cut -d '/' -f 3` #keeps only the http://www.url.com/
	if [[$curlstatus == "200"]]; then
		if [[-f  ~/Desktop/OSProject/"$pagetemp".txt]]; then
			curl -s $line > /tmp/"$pagetemp".txt 
			if [[$(cmp -s ~/Desktop/OSProject/"$pagetemp".txt /tmp/"$pagetemp".txt)<>0]]; then 
				echo $line >> ~/Desktop/OSProject/outfile.txt 
				rm ~/Desktop/OSProject/outfile.txt  #removes the outdated output 
				mv /tmp/"$pagetemp".txt ~/Desktop/OSProject  #replaces it with the updated	
			fi
		
		else
			echo "$line INIT" &			
			pagetemp= echo "$1" |  cut -d '/' -f 3 & 
			curl -s $line > /tmp/"$pagetemp".txt &
		fi
	else
		echo "$line FAILED" 
	fi

     fi

done < "$1"

if [[-f ~/Desktop/OSProject/outfile.txt]] then
	echo "Changed URLs:"
	cat ~/Desktop/OSProject/outfile.txt
else
	echo "ERROR"
fi
rm ~/Desktop/OSProject/outfile.txt
