#!/bin/sh

sh deploy-edgeX.sh

cd postman-test/bin
sh run.sh -cd integrationtest

cd ..
cd ..

docker-compose down