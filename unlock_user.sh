#!/bin/sh

set -e

printf "unlocking user $1 ... "
usermod --expiredate 3000-01-01 "$1"
mv "/data/users/$1" "/home/$1"
echo 'done.'

