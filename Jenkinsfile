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
        // Use -f to point to the Dockerfile, and '.' to use the root context
        sh "docker build -t sooryas20/trend-app:latest -f app/Dockerfile ."
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
