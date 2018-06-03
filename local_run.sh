#!/bin/sh

option="${1}"

. $(dirname "$0")/test_env.sh

echoAllAvailableCommand() {
    echo "[info] show below available command"

    COLLECTIONS=(
        "-localDeploy"
        "-copyPostmanTestScriptToNewman"

        "-testCoreData"
        "-importMetaData"

        "-testMetaData"
        "-importCoreData"

        "-testSupportNotification"
        "-importSupportNotification"
    )

    for index in "${!COLLECTIONS[@]}"
    do
        echo "${index}. ${COLLECTIONS[index]}"
    done
}

case ${option} in
    -localDeploy)
        sh local-deploy-edgex.sh
        ;;
    -copyPostmanTestScriptToNewman)
        VOLUME_CONTAINER=$(docker-compose ps -q volume)
        VOLUME_CONTAINER=`echo ${VOLUME_CONTAINER} | cut -b 1-12`
        docker cp $(dirname "$0")/bin/postman-test/. "${VOLUME_CONTAINER}":/etc/newman
        ;;

    # CoreData
    -testCoreData)
        $(dirname "$0")/bin/flushCoreDataDump.sh
        sh ./bin/run.sh -cd
        ;;
    -importCoreData)
        $(dirname "$0")/bin/flushCoreDataDump.sh
        $(dirname "$0")/bin/importCoreDataDump.sh
        ;;

    # MetaData
    -testMetaData)
        $(dirname "$0")/bin/flushMetaDataDump.sh
        sh ./bin/run.sh -md
        ;;
    -importMetaData)
        $(dirname "$0")/bin/flushMetaDataDump.sh
        $(dirname "$0")/bin/importMetaDataDump.sh
        ;;

    # SupportNotification
    -testSupportNotification)
        $(dirname "$0")/bin/flushSupportNotificationDump.sh
        sh ./bin/run.sh -sn
        ;;
    -importSupportNotification)
        $(dirname "$0")/bin/flushSupportNotificationDump.sh
        $(dirname "$0")/bin/importSupportNotificationDump.sh
        ;;

   	*)
      	echoAllAvailableCommand
      	;;
esac


