#!/bin/bash

for path in /home/*/bigdata; do
    if [ -L $path ]; then
        echo "TRUE $path"
    else
        echo "FALSE $path"
    fi
done
