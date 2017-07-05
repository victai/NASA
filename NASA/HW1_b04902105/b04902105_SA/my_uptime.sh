#!/usr/bin/env bash

#Get localtime
	localtime=$(zdump /etc/localtime | cut -d' ' -f 7)
	echo -n "$localtime, "

#Get uptime
	uptime=$(cat /proc/uptime | cut -d ' ' -f 1)
	day=$(echo "$uptime/86400" | bc)
	hour=$(echo "($uptime%86400)/3600" | bc)
	minute=$(echo "(($uptime%86400)%3600)/60" | bc)
	if [ $minute -lt 10 ] && [ $minute -gt 0 ] && [ $hour -gt 0 ]; then
		minute=0${minute}
	fi
	echo -n "up " 
	if [ $day -ge 1 ]; then
		if [ $day -eq 1 ]; then
			echo -n "1 day, "
		else
			echo -n "$day days, "
		fi
	fi
	if [ $hour -gt 0 ]; then
		if [ $hour -lt 10 ]; then
			echo -n " $hour:$minute, "
		else
			echo -n "$hour:$minute, "
		fi
	else
		if [ $minute -gt 0 ]; then
			echo -n "$minute min, "
		else
			echo -n "0 min, "
		fi
	fi
	
#Get logged-on users
	users=$(who -q | awk -F'=' '{printf $2}')
	if [ $users -gt 1 ]; then
		echo -n "$users users, "
	else
		echo -n "1 user, "
	fi

#Get load average
	echo -n "load average: "
	loadavg=$(cat /proc/loadavg\
		| awk -F' ' '{print $1 ", " $2 ", " $3}')
	echo $loadavg
	#	echo $loadavg[0], $loadavg[1], $loadavg[2]
