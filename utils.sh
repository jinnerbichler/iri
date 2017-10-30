#!/usr/bin/env bash

set -e    # Exits immediately if a command exits with a non-zero status.sadfaksjdflakjsdf

if [ "$1" == "full-deploy" ]; then

    mvn clean package -DskipTests
    docker build -t jinnerbichler/iri_testnet .
    docker push jinnerbichler/iri_testnet
    scp docker-compose.yml utils.sh root@138.68.102.72:/srv/iri-testnet/
    ssh root@138.68.102.72 "bash /srv/iri-testnet/utils.sh remote-testnet-start"

elif [ "$1" == "docker-build" ]; then

    mvn clean compile package -DskipTests
    docker build -t jinnerbichler/iri_testnet .

elif [ "$1" == "docker-run" ]; then

    docker run -p "14265:14265" jinnerbichler/iri_testnet

elif [ "$1" == "docker-push" ]; then

    docker push jinnerbichler/iri_testnet

elif [ "$1" == "deploy-testnet" ]; then

    scp docker-compose.yml utils.sh root@138.68.102.72:/srv/iri-testnet/
    ssh root@138.68.102.72 "bash /srv/iri-testnet/utils.sh remote-testnet-start"

elif [ "$1" == "logs-testnet" ]; then

    ssh root@138.68.102.72 "bash /srv/iri-testnet/utils.sh remote-testnet-logs"

elif [ "$1" == "remote-testnet-start" ]; then

    cd /srv/iri-testnet/
    docker-compose down -v
    docker-compose pull
    docker-compose up -d --force-recreate
    docker-compose logs -f

elif [ "$1" == "remote-testnet-logs" ]; then

    cd /srv/iri-testnet/
    docker-compose logs -f

fi
