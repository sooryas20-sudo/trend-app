Trendify: End-to-End DevOps CI/CD Pipeline on AWS EKS
🚀 Project Overview

This project demonstrates a complete automated DevOps lifecycle for a web application named Trendify. The goal was to build a robust CI/CD pipeline that automates everything from infrastructure provisioning and containerization to automated deployment on a production-grade Kubernetes cluster (Amazon EKS).
🛠️ Technology Stack

    Application: Web-based landing page running on Nginx.

    Infrastructure as Code (IaC): Terraform for EC2 and Security Group provisioning.

    Containerization: Docker for building portable application images.

    Container Registry: DockerHub (sooryas20) for image storage.

    CI/CD Orchestration: Jenkins (Declarative Pipeline).

    Orchestration: Amazon EKS (Elastic Kubernetes Service) for high availability.

    Version Control: GitHub (sooryas20-sudo/trend-app).

🏗️ Pipeline Architecture

The pipeline follows a strict declarative structure to ensure consistency across builds:

    Stage: Clone Code

        Jenkins pulls the latest code from the main branch of the GitHub repository.

    Stage: Build Docker Image

        Builds a lightweight Docker image using the provided Dockerfile.

    Stage: Push to DockerHub

        Authenticates with DockerHub and pushes the tagged image (sooryas20/trend-app:latest).

    Stage: Deploy to Kubernetes

        Uses kubectl and AWS credentials to apply the deployment.yaml and service.yaml files to the EKS cluster.

        Triggers a rollout restart to ensure the newest container image is served.

🔧 Setup & Configuration
Infrastructure Provisioning

The Jenkins server was provisioned using Terraform in the ap-south-1 region.
Bash

terraform init
terraform plan
terraform apply

The Kubernetes cluster was created using eksctl:
Bash

eksctl create cluster --name trend-cluster --region ap-south-1 --node-type t3.medium --nodes 2 --managed

Jenkins Configuration

    Plugins: Installed Docker, Pipeline, and Kubernetes CLI plugins.

    Credentials: Configured dockerhub-creds for registry access and aws-access-key/aws-secret-key for EKS authentication.

📊 Monitoring & Verification

The application health and deployment status are monitored directly through the AWS Load Balancer and Jenkins Stage View.

    Jenkins Build Status: Build #7 completed successfully with all stages verified.

    Live Application: The "Trendify" application is successfully reachable at the External LoadBalance
