# Trendify: End-to-End DevOps CI/CD Pipeline on AWS EKS

## 🚀 Project Overview
This project demonstrates a complete automated DevOps lifecycle for a web application named **Trendify** (The Trend Store). The goal of this project is to build a robust CI/CD pipeline that automates everything from infrastructure provisioning and containerization to automated deployment on a production-grade Kubernetes cluster (Amazon EKS) with full observability.

## 🛠️ Technology Stack
* **Infrastructure as Code (IaC):** Terraform
* **Containerization:** Docker
* **Container Registry:** DockerHub (`sooryas20/trend-app`)
* **CI/CD Orchestration:** Jenkins (Declarative Pipeline)
* **Container Orchestration:** Amazon EKS (Elastic Kubernetes Service)
* **Monitoring & Observability:** Prometheus, Grafana, AWS CloudWatch
* **Version Control:** GitHub

---

## 📅 Project Phases & Implementation History

### Phase 1: Initial Implementation (Baseline Setup)
In the initial phase of the project, the foundational infrastructure and application configurations were established:
* **VM & Jenkins Setup:** Provisioned an AWS EC2 instance and installed Jenkins for pipeline automation.
* **Containerization:** Developed a `Dockerfile` to containerize the Trendify web application using an Nginx base image.
* **Kubernetes Configuration:** Authored Kubernetes manifests (`deployment.yaml` and `service.yaml`) for deploying the application.
* **Basic CI/CD:** Created the initial `Jenkinsfile` to handle source code checkout, Docker build, and basic cluster integration.
* **CloudWatch:** Configured basic AWS CloudWatch metrics for the infrastructure.

### Phase 2: First Rework (Pipeline Stabilization & Authentication)
The first rework focused on resolving critical integration and authentication roadblocks between the CI/CD server and the AWS infrastructure:
* **EKS Authentication Resolution:** Resolved persistent `v1alpha1` API errors by upgrading the AWS CLI to v2 and reconfiguring the `kubeconfig` context for both the `ubuntu` and `jenkins` users.
* **DockerHub Integration:** Fixed pipeline credential mapping issues to successfully authenticate and push the built images to DockerHub.
* **Node Health:** Successfully registered and verified AWS worker nodes in the EKS cluster to reach the `Ready` status.

### Phase 3: Second Rework (IaC Automation & Open-Source Monitoring)
The final rework transformed the project from a manual deployment into a fully code-driven, observable, and automated architecture:
* **Infrastructure as Code (Terraform):** * Introduced a complete `terraform/` module (`main.tf`, `variables.tf`, `output.tf`).
  * Automated the provisioning of the AWS VPC, Subnets, EKS Cluster (`trend-cluster`), and Node Groups.
  * Automated the Jenkins server installation and configuration via an EC2 `user_data` script.
* **Automated Application Deployment:** * Finalized the Jenkins pipeline (Build #28) to successfully execute the `Deploy to EKS` stage automatically upon GitHub commits.
  * Exposed the live Trendify application to the internet via an AWS Application LoadBalancer (`trend-app-service` on Port 3000).
* **Open-Source Monitoring:** * Deployed the `kube-prometheus-stack` via Helm into the EKS cluster.
  * Configured Grafana dashboards (accessible via port-forwarding on Port 3000) to monitor live Kubernetes Compute Resources, Cluster Health, and Node CPU/Memory metrics.

---

## 🌐 Live Application Access
* **Trendify Store:** The application is highly available and accessible via the AWS LoadBalancer DNS at `http://[LoadBalancer-EXTERNAL-IP]:3000`.
* **Grafana Dashboard:** Cluster metrics can be viewed by port-forwarding the Grafana service: `kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80`.

## 📂 Repository Structure
* `/app` - Contains the application source code and `Dockerfile`.
* `/terraform` - Contains the IaC configurations (`main.tf`, `variables.tf`, `output.tf`) for EKS and Jenkins.
* `Jenkinsfile` - The declarative pipeline script for CI/CD automation.
* `deployment.yaml` - Kubernetes deployment manifest.
* `service.yaml` - Kubernetes LoadBalancer service manifest.
