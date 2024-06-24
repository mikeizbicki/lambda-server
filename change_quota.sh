#!/bin/sh
set -e

for email in $(cat $1); do
    username=$(echo "$email" | sed 's/@.*$//')
    echo "username=$username"
    quotatool -u "$username" -b -q 500M -l 2G /
done

