#!/bin/sh

PRGNAME=$(basename $0)
SERVICE=$1

# Check if we are root
if [ "Z$USER" != "Zroot" ] ; then
  echo "You need to execute this script as root:"
  echo "sudo sh $PRGNAME"
  exit 1
fi

# check argument
if [ -z $SERVICE ]; then
  echo "You need to provide an argument"
  echo "example:  sh $PRGNAME ceilometer"
  exit 1
fi

for s in $(ls /etc/init/ | grep $SERVICE | awk -F'.' '{print $1}'); do
  service $s stop
  service $s start
done
