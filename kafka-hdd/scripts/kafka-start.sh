#!/bin/bash

if [ -z "$REMOTEHOST" ] ; then
  echo "you must specify REMOTEHOST"
  exit 1
fi

if [ -z "$NUM_BROKERS" ] ; then
    NUM_BROKERS=1
fi

echo "REMOTEHOST:  $REMOTEHOST"
echo "NUM_BROKERS: $NUM_BROKERS"

if [ ! -z "$(ssh root@$REMOTEHOST -p 2222 'docker ps | grep -e kafka -e zookeper')" ] ; then
  echo "Kafka or Zookeeper already running on $REMOTEHOST, bailing out"
  exit 1
fi

scp -P 2222 $(dirname $(realpath $0))/create-docker-compose.sh root@$REMOTEHOST:~/

ssh root@$REMOTEHOST -p 2222 "COMPOSE_HTTP_TIMEOUT=14400 DOCKER_CLIENT_TIMEOUT=14400 NUM_BROKERS=$NUM_BROKERS HOSTNAME=$REMOTEHOST OVERWRITE=1 ./create-docker-compose.sh"
ssh root@$REMOTEHOST -p 2222 "docker-compose up -d"

echo -n "waiting for the cluster to be operational"
while (true) ; do
  echo -n "."
  kafkacat -b $REMOTEHOST:19091 -L 2> /dev/null | grep "$NUM_BROKERS brokers:" >& /dev/null
  if [ $? -eq 0 ] ; then
    break
  fi
  sleep 0.5
done
echo "done"
