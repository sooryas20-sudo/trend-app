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
        // STAGE REMOVED: npm install cannot run without package.json 

        stage('Docker Build & Push') {
            steps {
                // Points to the folder containing your Dockerfile
                sh "docker build -t sooryas20/trend-app:latest ./app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20/trend-app:latest"
            }
        }

        stage('Deploy to EKS') {
            steps {
                // Manifests are at the root level
                sh "kubectl apply -f deployment.yaml"
                sh "kubectl apply -f service.yaml"
            }
        }
    }
}
