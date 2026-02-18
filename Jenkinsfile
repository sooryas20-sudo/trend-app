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
        // SKIPPING BUILD STAGE because package.json is missing
        /*
        stage('Build App') {
            steps {
                sh 'npm install'
            }
        }
        */
        stage('Docker Build & Push') {
            steps {
                // Ensure your Dockerfile in the 'app' folder doesn't also rely on 'npm install'
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
