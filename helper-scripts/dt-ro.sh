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
# script:      dt-ro.sh
# description: Mount the SD card readonly.
# author:      Marcus Behel
# version:     v1.0.0
#####################################################################################

sudo mount -o ro,remount /
sudo mount -o ro,remount /boot
