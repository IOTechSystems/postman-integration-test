#!/usr/bin/env bash

export volume=docker.iotechsys.com/edgexpert/docker-edgex-volume-x86_64:1.0.0
export mongo=docker.iotechsys.com/edgexpert/docker-edgex-mongo-x86_64:1.0.0
export consul=consul:1.1.0
export configSeed=docker.iotechsys.com/edgexpert/docker-core-config-seed-go-x86_64:1.0.0

# Core service

export coreData=docker.iotechsys.com/edgexpert/core-data-go-x86_64:1.0.0
export coreMetadata=docker.iotechsys.com/edgexpert/core-metadata-go-x86_64:1.0.0
export coreCommand=docker.iotechsys.com/edgexpert/core-command-go-x86_64:1.0.0

# Support service

export supportLogging=docker.iotechsys.com/edgexpert/support-logging-go-x86_64:1.0.0
export supportNotifications=docker.iotechsys.com/edgexpert/support-notifications-java-x86_64:1.0.0
export supportScheduler=docker.iotechsys.com/edgexpert/support-scheduler-java-x86_64:1.0.0
export supportRulesengine=docker.iotechsys.com/edgexpert/support-rulesengine-java-x86_64:1.0.0

export exportClient=docker.iotechsys.com/edgexpert/export-client-go-x86_64:1.0.0
export exportDistro=docker.iotechsys.com/edgexpert/export-distro-go-x86_64:1.0.0


export deviceVirtual=docker.iotechsys.com/edgexpert/device-virtual-java-x86_64:1.0.0
