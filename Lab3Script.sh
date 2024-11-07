#!/bin/bash

mkdir -p $HOME/students

# check if the file is there
if [ ! -f $HOME/students/LCP_22-23_students.csv ]
then
    echo "the file ./$1 does not exist! Downloading the content."
	wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv -P $HOME/students
else
    echo "The file has already been downloaded."
fi

cd $HOME/students
touch "PoD_students.csv"
touch "Physics_students.csv"


grep "PoD" LCP_22-23_students.csv > PoD_students.csv
grep "Physics" LCP_22-23_students.csv > Physics_students.csv

# Use backtick to assign the output of grep to the variable j; ` = AltGr + '
# Also no spaces in the assegnation, neither before or after the equal
echo "Last names starting with...:"
echo "Letter PoD Physics"

# Initialize variables to store the max frequency and corresponding letter for last names
max_PoD=0
sur_PoD="A"
max_Phy=0
sur_Phy="A"

for i in {A..Z}
	do
	j=`grep -c ^$i PoD_students.csv`
	k=`grep -c ^$i Physics_students.csv`
	echo "$i $j $k"
	if [ $j -gt $max_PoD ]
		then
		max_PoD=$j
		sur_PoD=$i
		fi
	if [ $k -gt $max_Phy ]
		then
		max_Phy=$k
		sur_Phy=$i
		fi		
	done
echo "Highest frequency at Physics of Data:"
echo "$sur_PoD $max_PoD"
echo "Highest frequency at Physics of Data:"
echo "$sur_Phy $max_Phy"

line_count=`grep -c -v "^Family" LCP_22-23_students.csv`
echo "$line_count"
module=18
max_remainder=$(( module-1 ))
for (( i=0; i<=$max_remainder; i++ ))
	do
	awk "NR%$module==$i" LCP_22-23_students.csv > "Group$i.csv"
	done
