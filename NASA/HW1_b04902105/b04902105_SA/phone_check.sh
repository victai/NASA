#!/usr/bin/env bash

tmp=$1
len=${#tmp}
if [ $len -eq 10 ]; then 
	echo $1 | grep "09[0-9]\{8\}"
fi
if [ $len -eq 11 ]; then
	echo $1 | grep "09[0-9]\{2\}-[0-9]\{6\}"
fi
if [ $len -eq 12 ]; then
	echo $1 | grep "09[0-9]\{2\}-[0-9]\{3\}-[0-9]\{3\}"
fi
