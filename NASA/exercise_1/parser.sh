#!/usr/bin/env bash

# Tell bash to loop by line, instead of by space
IFS=$'\n'

# Loop through each line
for entry in $(cat raw-ip-list.txt); do

    # Extract IP, we use 'grep' to validate the field
    ip=$(echo "$entry" \
        | cut -f 4 -d'"' \
        | grep "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}")
    
    # Extract coordinates, we use 'grep' to validate the field
    location=$(echo "$entry" \
        | cut -f24 -d'"' \
        | grep '[-0-9\.]\+,[-0-9\.]\+' | tr ',' ';')

    # Extract orgnization name
    org=$(echo "$entry" \
	| cut -f28 -d'"')

    # If the current entry does not match the pattern in grep
    # the corresponding variable will be empty
    if [ ! -z "$ip" ] && [ ! -z "$location" ]; then

	if [ -z "$org" ]; then
		org="Unknown"
	fi

        echo "$location;$ip;$org"

    fi
done

