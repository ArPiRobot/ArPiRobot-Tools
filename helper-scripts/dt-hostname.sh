#!/bin/bash


# If no arguments print the current hostname
if [ $# -eq 0 ]; then
    cat /etc/hostname
    exit 0
else
    if [ $# -ne 1 ]; then
        echo "Either call with zero or one arguments!"
        echo "$0 [NEW_HOSTNAME]"
        exit 1
    fi
fi

sudo dt-hostname_replace.py "$1"
