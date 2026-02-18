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
                // Based on your terminal, we must enter trend-app first
                dir('trend-app/dist') { 
                    sh 'npm install'
                }
            }
        }
        stage('Docker Build & Push') {
            steps {
                // We point to the folder containing the Dockerfile
                sh "docker build -t sooryas20/trend-app:latest ./trend-app/app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20/trend-app:latest"
            }
        }
        stage('Deploy to EKS') {
            steps {
                dir('trend-app') {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
    }
}
