#!/bin/sh
set -e

for email in $(cat $1); do
    username=$(echo "$email" | sed 's/@.*$//')
    echo "username=$username"
    quotatool -u "$username" -b -q 200G -l 250G /data
    bigdata_dir="/data/users_bigdata/$username/"
    mkdir -p "$bigdata_dir"
    chown "$username" "$bigdata_dir"
    chgrp "students" "$bigdata_dir"
    ln -s "$bigdata_dir" "/home/$username/bigdata"
done

