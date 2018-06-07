#!/bin/bash

POSTGRES_DATA_DIR=$(pwd)/postgres-data

mkdir -p $POSTGRES_DATA_DIR

docker run \
       --name forus-postgres \
       -e POSTGRES_PASSWORD=postgres \
       -e POSTGRES_USER=postgres \
       -e PGDATA=/var/lib/postgresql/data/pgdata \
       -p 5432:5432 \
       -d \
       -v $POSTGRES_DATA_DIR:/var/lib/postgresql/data/pgdata \
       postgres
