#!/bin/bash

NAMESFILE=files.sh
ADDRESSABLE_JS=javascript/command/addressable.js
DEVICE_JS=javascript/command/device.js
COMMAND_JS=javascript/command/command.js
DEVICPROFILE_JS=javascript/command/deviceProfile.js
DEVICESERVICE_JS=javascript/command/deviceService.js

if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

DATA_BASE="metadata"
FLUSH_SCRIPTS=( $ADDRESSABLE_JS $DEVICE_JS $DEVICPROFILE_JS $DEVICESERVICE_JS $COMMAND_JS )

for index in "${!FLUSH_SCRIPTS[@]}"
do
    if [ -f ${FLUSH_SCRIPTS[index]} ]; then
        COPY_FROM="${FLUSH_SCRIPTS[index]}"
        COPY_TO="${RANDOM}.json"

        docker cp ${COPY_FROM} "$(docker-compose ps -q mongo)":${COPY_TO}
        docker-compose exec -T mongo /bin/bash -c "mongo ${DATA_BASE} ${COPY_TO}"

        echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

    else
        echo "Error: Mongo JS ${FLUSH_SCRIPTS[index]} file does not exist."

    fi


done