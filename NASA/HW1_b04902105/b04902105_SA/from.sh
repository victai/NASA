#!/usr/bin/env bash

IFS=$'\n'
tmp1=$(mktemp)
tmp2=$(mktemp)
last -i | awk '{print $3}' > $tmp1
for ip in $( cat $tmp1 ); do
	location=$(geoiplookup $ip | grep -v "can't")
	if [ ! -z "$location" ];then
		echo ${location#*: } >> $tmp2
	fi
done

#cat $tmp2 | sort | uniq -c | sort -n
sort $tmp2 | uniq -c | sort -n
rm -f $tmp1 $tmp2
