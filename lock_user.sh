#!/bin/sh

set -e

if [ -d "/home/$1" ]; then
    printf "locking user $1 ... "
    usermod --expiredate 1 "$1"
    mv "/home/$1" "/data/users/$1"
    echo 'done.'
else
    echo "already locked $1"
fi
