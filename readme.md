# Smart Home Setup

My smart home setup.

## Docker

### Docker root path change

    sudo systemctl stop docker

Into `/etc/docker/daemon.json` paste

    {
        "data-root": "/mnt/data/docker-data"
    }

Copy `/var/lib/docker` to `/mnt/data/docker-data`

    sudo systemctl start docker

## InfluxDB

When image is build it automatically restores backup in `influxdb/init/backup`.

## SSL Certificates

### Install root on host OS

Copy Root CA in PEM format to `/usr/local/share/ca-certificates`, extension has to be `.crt`. Run `update-ca-certificates` to install it.