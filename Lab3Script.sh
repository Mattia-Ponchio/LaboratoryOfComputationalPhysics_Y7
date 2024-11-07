#!/bin/bash

mkdir -p /home/ponchiom/students

# check if the file is there
if [ ! -f /home/ponchiom/students/LCP_22-23_students.csv ]
then
    echo "the file ./$1 does not exist! Downloading the content."
	wget https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv -P /home/ponchiom/students
else
    echo "The file has already been downloaded."
fi

cd /home/ponchiom/students
touch "PoD_students.csv"
touch "Physics_students.csv"


grep "PoD" LCP_22-23_students.csv > PoD_students.csv
grep "Physics" LCP_22-23_students.csv > Physics_students.csv

for i in {A..Z}; do grep -c ^$i PoD_students.csv | echo $j; echo "$i $j" done
#for i in {A..Z}; do grep -c ^$i Physics_students.csv; done
