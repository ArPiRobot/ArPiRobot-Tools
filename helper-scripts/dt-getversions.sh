#!/bin/bash
#####################################################################################
#
# Copyright 2020 Marcus Behel
#
# This file is part of ArPiRobot-Tools.
# 
# ArPiRobot-Tools is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# ArPiRobot-Tools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with ArPiRobot-Tools.  If not, see <https://www.gnu.org/licenses/>.
#####################################################################################
# script:      dt-getversions.sh
# description: Print in following order (each on new line) for deploy tool
#              Image version
#              Python interpreter version
#              Python library version
#              Raspbian tools version
# 
#              Output must match following example format
#              IMAGE_VERSION_NAME
#              PYTHON VERSION STRING from python3 --version
#              PYLIB VERSION NAME
#              RASPBIAN TOOLS VERSION
#
#              Example:
#              Beta2
#              3.7.1
#              0.0.5
#              0.0.3
# author:      Marcus Behel
# version:     v1.0.0
#####################################################################################


# Print image version
VERSION=$(head -n 1 /usr/local/arpirobot-tools-version.txt 2>/dev/null | sed -z '$ s/\n$//')
if [ -z "$VERSION" ]; then
    VERSION="UNKNOWN"
fi
printf "$VERSION\n"

# Print python version
python3 --version | sed -z 's/Python //g'

# Print pylib version
# python3 -m pip show arpirobot-pythonlib | grep Version:
# This will use the latest version found. Should only be one, but just in case.
# cat `python3 -c "import arpirobot as a;print(a.__path__[0])"`/../ArPiRobot_PythonLib-*.dist-info/METADATA | awk '$1 ~ /^Version:/' | sed -z 's/Version: //g'

ARRAY=( `python3 -c "import arpirobot as a;print(a.__path__[0])"`/../ArPiRobot_PythonLib-*.dist-info/METADATA )
SELECTED_DIR=${ARRAY[-1]}
if [ -f "$SELECTED_DIR" ]; then
    PYLIB_VER=$(cat $SELECTED_DIR | awk '$1 ~ /^Version:/' | sed -z 's/Version: //g')
else
    PYLIB_VER="UNKNOWN"
fi
echo $PYLIB_VER

# Print raspbian tools version (no newline)
VERSION=$(head -n 1 /usr/local/raspbian-tools-version.txt 2> /dev/null | sed -z '$ s/\n$//')
if [ -z "$VERSION" ]; then
    VERSION="UNKNOWN"
fi
printf "$VERSION\n"

