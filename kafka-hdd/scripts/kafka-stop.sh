#!/bin/bash

if [ -z "$REMOTEHOST" ] ; then
  echo "you must specify REMOTEHOST"
  exit 1
fi

echo "REMOTEHOST:  $REMOTEHOST"

ssh root@$REMOTEHOST -p 2222 "docker-compose down && docker volume prune -f"
