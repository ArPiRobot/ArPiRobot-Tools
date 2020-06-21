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
# script:      install.sh
# description: Install ArPiRobot-Tools helper scripts and services.
# author:      Marcus Behel
# version:     v1.0.0
#####################################################################################

if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root."
   exit 1
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Install scripts
cp $DIR/helper-scripts/*.sh /usr/local/bin
chmod 755 /usr/local/bin/*.sh
cp $DIR/helper-scripts/*.py /usr/local/bin
chmod 755 /usr/local/bin/*.py

# Install services
SERVICES=$DIR/services/*.service
for s in $SERVICES
do
    systemctl stop `basename $s`
    systemctl disable `basename $s`
done
cp $DIR/services/*.service /lib/systemd/system/
systemctl daemon-reload
for s in $SERVICES
do
    systemctl enable `basename $s`
done

# Copy version text file
cp $DIR/version.txt /usr/local/arpirobot-tools-version.txt
