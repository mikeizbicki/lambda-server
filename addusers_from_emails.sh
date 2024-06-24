#!/bin/sh

set -e

for email in $(cat "$1"); do
    echo "========================================"
    echo "email=$email"
    sh scripts/adduser.sh "$email" "$2"
    read tmp
done
