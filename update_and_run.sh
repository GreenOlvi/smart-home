#!/bin/bash

git pull
git submodule update --remote
docker compose build --pull && docker compose up -d
