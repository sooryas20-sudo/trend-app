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
                // package.json is in trend-app, not in dist
                dir('trend-app') { 
                    sh 'npm install'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                // Dockerfile is in trend-app/app
                sh "docker build -t sooryas20/trend-app:latest ./trend-app/app"
                sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                sh "docker push sooryas20/trend-app:latest"
            }
        }

        stage('Deploy to EKS') {
            steps {
                // YAML files are also in trend-app
                dir('trend-app') {
                    sh "kubectl apply -f deployment.yaml"
                    sh "kubectl apply -f service.yaml"
                }
            }
        }
            }
        }
		
    }
}
