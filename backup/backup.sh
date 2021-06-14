#!/bin/bash

OUTPUT="$BACKUP_DIR./$(date +%Y%m%d%H%M%S)"
IMAGE="alpine:3.13"

mkdir -p $OUTPUT

cd $OUTPUT

docker stop mosquitto
docker run --rm --volumes-from mosquitto -v $(pwd):/backup $IMAGE sh -c "cd /mosquitto/data && tar cvjf /backup/mosquitto.tar.bz2 ."
docker start mosquitto

docker stop grafana
docker run --rm --volumes-from grafana -v $(pwd):/backup $IMAGE sh -c "cd /var/lib/grafana && tar cvjf /backup/grafana.tar.bz2 ."
docker start grafana

docker exec influxdb bash -c "rm -fv /backup/* && influxd backup --portable /backup/"
docker run --rm -v smart-home_db-backup:/db-backup -v $(pwd):/backup $IMAGE sh -c "cd /db-backup && tar cvjf /backup/influxdb.tar.bz2 ."