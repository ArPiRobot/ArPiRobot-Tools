#!/bin/bash

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

# Link scripts
ln -f $DIR/helper-scripts/*.sh /usr/local/bin
chmod +x /usr/local/bin/*.sh

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


