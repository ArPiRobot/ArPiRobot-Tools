#!/bin/bash

file=$(head -n 1 ~/arpirobot/main.txt)
python3 ~/arpirobot/$file

exit 0
