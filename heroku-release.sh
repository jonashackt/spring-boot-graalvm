#!/usr/bin/env bash

if [ -z "$1" ];
  then
    echo "[--> ERROR] Please provide your Heroku app name as script parameter like this: ./heroku-release.sh spring-boot-graal"
    exit
fi
echo "[-->] Releasing Dockerized Heroku app '$1'"

herokuAppName=$1
dockerImageId=$(docker inspect registry.heroku.com/$herokuAppName/web --format={{.Id}})

curl -X PATCH https://api.heroku.com/apps/$herokuAppName/formation \
          -d '{
                "updates": [
                {
                  "type": "web",
                  "docker_image": "'"$dockerImageId"'"
                }]
              }' \
          -H "Content-Type: application/json" \
          -H "Accept: application/vnd.heroku+json; version=3.docker-releases" \
          -H "Authorization: Bearer $DOCKER_PASSWORD"