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
                // Navigates to where package.json lives
                dir('trend-app') { 
                    sh 'npm install'
                }
            }
        }
        stage('Docker Build & Push') {
            steps {
                // Points to the specific app folder for your Dockerfile
                sh "docker build -t sooryas20/trend-app:latest ./trend-app/app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20/trend-app:latest"
            }
        }
        stage('Deploy to EKS') {
            steps {
                // Applies the manifests found in the trend-app folder
                dir('trend-app') {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
    }
}
