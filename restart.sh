#!/bin/sh

set -e

sudo ls > /dev/null

wall 'the server will restart in 60 seconds for maintenance; it will be back online in about 5 minutes'
sleep 10
wall 'the server will restart in 50 seconds for maintenance; it will be back online in about 5 minutes'
sleep 10
wall 'the server will restart in 40 seconds for maintenance; it will be back online in about 5 minutes'
sleep 10
wall 'the server will restart in 30 seconds for maintenance; it will be back online in about 5 minutes'
sleep 10
wall 'the server will restart in 20 seconds for maintenance; it will be back online in about 5 minutes'
sleep 10
wall 'the server will restart in 10 seconds for maintenance; it will be back online in about 5 minutes'
sleep 5
wall 'the server will restart in 5 seconds for maintenance; it will be back online in about 5 minutes'
sleep 1
wall 'the server will restart in 4 seconds for maintenance; it will be back online in about 5 minutes'
sleep 1
wall 'the server will restart in 3 seconds for maintenance; it will be back online in about 5 minutes'
sleep 1
wall 'the server will restart in 2 seconds for maintenance; it will be back online in about 5 minutes'
sleep 1
wall 'the server will restart in 1 seconds for maintenance; it will be back online in about 5 minutes'
sleep 1

shutdown -r now
