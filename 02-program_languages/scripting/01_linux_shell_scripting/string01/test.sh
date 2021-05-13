#!/bin/bash

cat self_mapping2 | while read line
do
	echo "$line" | awk '{for(i=1;i<=NF;i++) print $i}' | xargs -i mkdir {}
	echo "$line" | awk '{for(i=1;i<=NF;i++) print $i}' | xargs -i cp job001/* {}
	#echo "$line" | awk '{for(i=1;i<=NF;i++) print $i}' | xargs -i rm -fr {}
done
