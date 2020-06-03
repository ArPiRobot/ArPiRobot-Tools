#!/bin/bash

# Usage: dt-update_program.sh full/path/to/project/folder relative/path/to/main/script.py

if [ $# -ne 1 ]; then
    printf "Usage: $0 project_folder\n"
    exit 1
fi

PROJ_FOLDER="$1"

rm -rf /home/pi/arpirobot/*
mkdir -p /home/pi/arpirobot/
cp -r "$PROJ_FOLDER"/* ~/arpirobot/
