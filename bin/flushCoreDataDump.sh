#!/bin/bash

NAMESFILE=$(dirname "$0")/files.sh
EVENTDUMPJS=$(dirname "$0")/javascript/coredata/event.js
READINGDUMPJS=$(dirname "$0")/javascript/coredata/reading.js
VDDUMPJS=$(dirname "$0")/javascript/coredata/valueDescriptor.js


if [ -f $NAMESFILE ]; then 

	. $NAMESFILE

else 
	echo "Error: Names file does not exist."
	exit $?

fi

DATA_BASE="coredata"
FLUSH_SCRIPTS=( $EVENTDUMPJS $READINGDUMPJS $VDDUMPJS)

for index in "${!FLUSH_SCRIPTS[@]}"
do
    if [ -f ${FLUSH_SCRIPTS[index]} ]; then
        COPY_FROM="${FLUSH_SCRIPTS[index]}"
        COPY_TO="${RANDOM}.json"

        MONGO_CONTAINER=$(docker-compose ps -q mongo)
        MONGO_CONTAINER=`echo ${MONGO_CONTAINER} | cut -b 1-12`

        docker cp ${COPY_FROM} "${MONGO_CONTAINER}":${COPY_TO}
        docker-compose exec -T mongo /bin/bash -c "mongo ${DATA_BASE} ${COPY_TO}"

        echo "Info: ${FLUSH_SCRIPTS[index]} data flushed"

    else
        echo "Error: Mongo JS ${FLUSH_SCRIPTS[index]} file does not exist."

    fi


done