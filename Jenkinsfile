#!/usr/bin/env groovy

node ("${env.SLAVE}")
{
    stage ('Checkout')
    {
        checkout scm
    }
    stage ('integration-test')
    {
        sh 'bash ./arch.sh'
        script 
        {
            def rootDir = pwd()
            if (env.LANG == "GO")
            {
                def integrationTestJob = load "${rootDir}/integrationTestJob_go.groovy"
                integrationTestJob.runNode()
            }
            else if (env.LANG == "JAVA")
            {
                def integrationTestJob = load "${rootDir}/integrationTestJob_java.groovy"
                integrationTestJob.runNode()
            }
        }
    }
    stage ("Archive Artifacts")
    {
        archiveArtifacts artifacts: 'bin/testResult/**.xml'
    }
    stage ("Clean")
    { 
        cleanWs ()
    }
}
