#!/bin/bash

# Print in following order (each on new line) for deploy tool
# Image version
# Python interpreter version
# Python library version
# Raspbian tools version

# Output must match following example format
# IMAGE_VERSION_NAME
# PYTHON VERSION STRING from python3 --version
# PYLIB VERSION NAME
# RASPBIAN TOOLS VERSION

# Example:
# Beta2
# 3.7.1
# 0.0.5
# 0.0.3

# Print image version (no newline)
head -n 1 /usr/local/arpirobot-image-version.txt | sed -z '$ s/\n$//'
printf "\n"

# Print python version
python3 --version | sed -z 's/Python //g'

# Print pylib version
# python3 -m pip show arpirobot-pythonlib | grep Version:
# This will use the latest version found. Should only be one, but just in case.
# cat `python3 -c "import arpirobot as a;print(a.__path__[0])"`/../ArPiRobot_PythonLib-*.dist-info/METADATA | awk '$1 ~ /^Version:/' | sed -z 's/Version: //g'

ARRAY=( `python3 -c "import arpirobot as a;print(a.__path__[0])"`/../ArPiRobot_PythonLib-*.dist-info/METADATA )
cat `echo ${ARRAY[-1]}` | awk '$1 ~ /^Version:/' | sed -z 's/Version: //g'

# Print raspbian tools version (no newline)
head -n 1 /usr/local/raspbian-tools-version.txt | sed -z '$ s/\n$//'
printf "\n"
