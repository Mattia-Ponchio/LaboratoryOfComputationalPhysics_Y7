#!/bin/bash

grep -v '^#' data.csv | sed -e 's/,/ /g' > data.txt
even=0
for i in `cat data.txt`
do
    if [ `echo "$i%2" | bc` -eq 0 ] #%2 gives 0 if even, that correspond to true in bash
    then
        let even++
    fi
done
echo "even numbers = $even"
m=0
l=0
sigma=$( echo 'scale=6;100*sqrt(3)/2.0' | bc)
FILE="data.txt"
lines=`grep '' -c $FILE`
i=1
while [ $i -le $lines ]
do
    line=`awk NR==$i $FILE`
    IFS=' ' read -r X Y Z x y z <<< "$line"
    d=$( echo "scale=6;sqrt($X*$X+$Y*$Y+$Z*$Z)" | bc)
    #echo $d
    if [ `echo "$d < $sigma" | bc` -eq 0 ]
    then
        let m++
    else
        let l++
    fi
    d2=$( echo "scale=6;sqrt($x*$x+$y*$y+$z*$z)" | bc)
    if [ `echo "$d2 < $sigma" | bc` -eq 0 ]
    then
        let m++
    else
        let l++
    fi
    let i++
done

echo "there are $m of distance greater than $sigma"
echo "there are $l of distance smaller than $sigma"
if [ -z $1 ]
then
    echo "This program requires an input for normalization"
    exit
fi
if [ $1 -lt 1 ]
then
    echo "This program requires an input greater than 1 for normalization"
    exit
fi


for (( j=1; j<=$1; j++ ))
do
	i=1
	OutName="data$j.txt"
   	rm $OutName
   	touch $OutName
	while [ $i -le $lines ]
	do
		line=`awk NR==$i $FILE`
   		IFS=' ' read -r X Y Z x y z <<< "$line"
   		X1=`echo "scale=3;$X/$j" | bc`
   		Y1=`echo "scale=3;$Y/$j" | bc`
   		Z1=`echo "scale=3;$Z/$j" | bc`
   		x1=`echo "scale=3;$x/$j" | bc`
   		y1=`echo "scale=3;$y/$j" | bc`
   		z1=`echo "scale=3;$z/$j" | bc`
   		echo "$X1 $Y1 $Z1 $x1 $y1 $z1" >> $OutName
   		let i++
   	done
done
   		
   	
