#!/bin/bash

# Usage: dt-update_program.sh full/path/to/project/folder relative/path/to/main/script.py

if [ $# -ne 2 ]; then
    printf "Usage: $0 project_folder main_script_relative_to_proj_folder\n"
    exit 1
fi

PROJ_FOLDER="$1"
MAIN_SCRIPT="$2"

rm -rf /home/pi/arpirobot/*
mkdir -p /home/pi/arpirobot/
cp -r "$PROJ_FOLDER"/* ~/arpirobot/
printf "$2\n" >> /home/pi/arpirobot/main.txt
