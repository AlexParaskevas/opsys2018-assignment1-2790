#/!/bin/bash


Afile=$1

if [ ! -f $1 ]; then
	echo "Wrong directory/cannot find compressed file"
	exit $?
fi



if [ ! -d ~/Desktop/repos_temp ]; then

	mkdir -p ~/Desktop/repos_temp
fi

cd ~/Desktop/repos_temp

tar -xvzf $1 #command tar extracts to the repos_temp directory

if [ ! -d ~/Desktop/repos ]; then

	mkdir -p ~/Desktop/repos
fi

find ~/Desktop/repos_temp -type f -name "*.txt" | while read txt; do 
	mv $txt ~/Desktop/repos #finds txt files in the temp dir and moves them to the repos dir
done

dir_name=~/Desktop/Assignments
if [ ! -f $dir_name ]; then

	mkdir -p $dir_name
fi

cd ~/Desktop/Assignments

for file in ~/Desktop/repos/*.txt; do

	while IFS=$'\n' read -r line; do

		if [[ ! $line == "#"* ]]; then
			if [[ $line == "https"* ]]; then
			
				repourl=`echo "$line" | cut -d'/' -f 5` #keeps the fixed repo link
				if [ ! -d ~/Desktop/Assignments/$repourl ]; then
				
					mkdir ~/Desktop/Assignments/$repourl
				fi
	
				git clone $line ~/Desktop/Assignments/$repourl
				if [ $? == "0" ]; then #if cloning is successfull then returns 0
			
					echo "$line Cloning OK";
				fi

			else
				echo "$line Cloning FAILED"
	
			fi

	done < "$1"

done 





for file1 in ~/Desktop/Assignments/*; do

	countdir=`find $file1/* -type d | wc -l`
	counttxt=`find $file1/* -type f -name '*.txt' | wc -l`
	countother=`find $file1/* | wc -l` #checks all the files cause of *
	countother=$(($countother-$counttxt-$countdir)) #remaining other files except dirs and txts
	reponame=`echo $file1 | cut -d'/' -f 6`
	echo -e "\e$reponame:\e"
	echo -e "Number of Directories:\e$countdir\e"
	echo -e "Number of txt files:\e$counttxt\e"
	echo -e "Number of other files:\e$countother\e"
	if [ -f $file1/dataA.txt ]; then
		if [ -d $file1/more ]; then
			if [ -f $file1/dataB.txt ]; then
				if [ -f $file1/dataC.txt ]; then
					echo "Directory structure is OK"
				fi
			fi
		fi
	else
		echo "Directory structure is NOT OK"
	fi


done			
