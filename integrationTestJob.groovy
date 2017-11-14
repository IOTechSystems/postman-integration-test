def runNode() {

    try {

        stage('Startup test services') {
            sh 'env'
            sh 'docker ps'
            sh 'docker login -u bruce -p Txcx2sDHk5Ts3GO2 docker.iotechsys.com'
            sh 'bash ./deploy-edgeX.sh'
            sh 'docker logout docker.iotechsys.com'
        }

        stage('Run Postman test') {
            sh 'rm -rf bin/testResult'

            sh './bin/run.sh -all'

            junit 'bin/testResult/**.xml'

        }


    }catch (e) {
        echo 'Something failed!'
        throw e;
    }finally{
        stage('Shutdown test services') {
            echo '[INFO] test end !'
            sh 'docker-compose down -v'
        }
    }

}

return this
