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
                // Use './app' for the Dockerfile location
                sh "docker build -t sooryas20-sudo/trend-app:latest ./app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20-sudo/trend-app:latest"
            }
        }
        stage('Deploy to EKS') {
            steps {
                // Ensure these yaml files are also in your root
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
            }
        }
    }
}
