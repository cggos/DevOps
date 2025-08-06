#!/bin/bash
#set -v

prefix="job"

######################## 1

for line in `cat independ`
do
    name=${prefix}$line
    echo ${name}
done

######################### 2

cat mapping | while read line
#for line in `cat mapping`
do
    #echo ${line}
    i=0
    first=""
    second=""
    for element in ${line}
    do
        let i+=1
        if [ $i -eq 1 ]
        then first=${element}
        fi
        if [ $i -eq 2 ]
        then second=${element}
        fi
        #echo $i
        #echo $element
    done
    path1=${prefix}${first}
    path2=${prefix}${second}

    testpath=${path1}${path2}
    echo $testpath
    
    #mv ${path2} ${path1}
done
