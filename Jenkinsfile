pipeline {

  agent any

  stages {
    stage('Build Image') {
      steps {
        sh 'docker build -t geeks-profile .'
      }
    }

    stage('Push Image') {
      steps {

        // use the docker token saved in the jenkins credentials to login
        withCredentials([string(credentialsId: 'DockerSecret', variable: 'TOKEN')]) {
            sh 'docker login -u waseemtannous -p ${TOKEN}'
            sh 'docker tag geeks-profile waseemtannous/geeks-profile:latest'
            sh 'docker push waseemtannous/geeks-profile:latest'
        }
      }
    }
  }

  post {
      failure {
        script {
          slackSend(
            color: "#FF0000",
            channel: "personal-projects",
            message: "geeks-profile Status: FAILED"
          )
        }
      }

     success {
        script {
          slackSend(
            color: "#00FF00",
            channel: "personal-projects",
            message: "geeks-profile Status: SUCCESS"
          )
        }
      }
    }
}