pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        } 

        stage('Docker Build & Push') {
    steps {
        sh "docker build -t sooryas20/trend-app:latest -f app/Dockerfile ."
        sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
        sh "docker push sooryas20/trend-app:latest"
           }
	}

        stage('Deploy to EKS') {
            steps {
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
            }
        }
    }
}
