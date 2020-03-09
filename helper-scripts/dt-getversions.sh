#!/bin/bash

# Print in following order (each on new line) for deploy tool
# Image version
# Python interpreter version
# Python library version
# Raspbian tools version

# Output must match following example format
# IMAGE_VERSION_NAME
# PYTHON VERSION STRING from python3 --version
# PYLIB VERSION NAME form pip output
# RASPBIAN TOOLS VERSION

# Example:
# Beta2
# Python 3.7.1
# Version: 0.0.5
# 0.0.3

# Print image version (no newline)
head -n 1 /usr/local/arpirobot-image-version.txt | sed -z '$ s/\n$//'
printf "\n"

# Print python version
python3 --version

# Print pylib version
python3 -m pip show arpirobot-pythonlib | grep Version:

# Print raspbian tools version (no newline)
head -n 1 /usr/local/raspbian-tools-version.txt | sed -z '$ s/\n$//'
printf "\n"
