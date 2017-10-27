def runNode(nodeName) {
        node(nodeName) {
            checkout scm

            try {

                stage('Startup test services') {
                    sh 'sh deploy-edgeX.sh'
                }


                stage('Run Postman test') {

                    sh './bin/run.sh -cd'

                    junit 'bin/postman-test/newman/**.xml'

                    sh 'docker-compose exec -T volume rm -rf /etc/newman/newman/'
                }


            }catch (e) {
                echo 'Something failed!'
                throw e;
            }finally{
                stage('Shutdown test services') {
                    echo '[INFO] test end !'
                    sh 'docker-compose down'
                }
            }
        }
}

return this