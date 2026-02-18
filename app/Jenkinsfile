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
                // Change 'app' to 'dist' here!
                dir('dist') { 
                    sh 'npm install'
                }
            }
        }
        stage('Docker Build & Push') {
            steps {
                // Keep 'app' here because that's where the Dockerfile is
                sh "docker build -t sooryas20/trend-app:latest ./app"
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
