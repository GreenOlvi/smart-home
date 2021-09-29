#!/bin/bash

DIR_NAME=$(date +%Y%m%d%H%M%S)
OUTPUT=$(realpath "$BACKUP_DIR./$DIR_NAME")
DESTINATION="one-drive:backup/smart-home/$DIR_NAME"
RCLONE_CONFIG="$(pwd)/config"
IMAGE="alpine:3.13"

echo "Backup root: $BACKUP_DIR"
echo "Backup directory: $OUTPUT"
echo "Backup destination: $DESTINATION"
echo "rclone config: $RCLONE_CONFIG"

# read -p "Press [Enter] key to start backup..."

mkdir -p "$OUTPUT"

cd "$OUTPUT"

echo `pwd`

docker stop mosquitto
docker run --rm --volumes-from mosquitto -v $(pwd):/backup $IMAGE sh -c "cd /mosquitto/data && tar cjf /backup/mosquitto.tar.bz2 ."
docker start mosquitto

docker stop grafana
docker run --rm --volumes-from grafana -v $(pwd):/backup $IMAGE sh -c "cd /var/lib/grafana && tar cjf /backup/grafana.tar.bz2 ."
docker start grafana

docker exec influxdb bash -c "rm -f /backup/* && influxd backup --portable /backup/"
docker run --rm -v smart-home_db-backup:/db-backup -v $(pwd):/backup $IMAGE sh -c "cd /db-backup && tar cjf /backup/influxdb.tar.bz2 ."

docker run --rm -v $RCLONE_CONFIG:/config/rclone -v $BACKUP_DIR:/data:ro --user $(id -u):$(id -g) rclone/rclone copy -P /data/$DIR_NAME $DESTINATION
