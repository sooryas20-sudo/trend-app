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
        stage('Build App') {
            steps {
                // RUN DIRECTLY IN ROOT - package.json is here
                sh 'npm install' 
            }
        }
        stage('Docker Build & Push') {
            steps {
                // Dockerfile is in the 'app' folder at the root
                sh "docker build -t sooryas20/trend-app:latest ./app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20/trend-app:latest"
            }
        }
        stage('Deploy to EKS') {
            steps {
                // deployment.yaml and service.yaml are also at the root
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
            }
        }
    }
}
