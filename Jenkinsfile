pipeline {
    agent any
    
    environment {
        // Ensure 'docker-hub-creds' exists in your Jenkins Credentials
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-creds') 
        DOCKER_IMAGE = "sooryas20/trend-app" 
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build App') {
            steps {
                dir('app') { 
                    sh 'npm install'
                    sh 'npm run build'
                }
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                // Builds using the Dockerfile inside the 'app' folder
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ./app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
            }
        }
        
        stage('Deploy to EKS') {
            steps {
                // Updates your EKS deployment with the version-specific tag
                sh "kubectl set image deployment/trend-app trend-app=${DOCKER_IMAGE}:${BUILD_NUMBER}"
            }
        }
    }
}
