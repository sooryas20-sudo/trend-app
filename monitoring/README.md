# Project 2: Open-Source Monitoring Setup

This project uses the **kube-prometheus-stack** to monitor EKS cluster health.


1. Add Repo: `helm repo add prometheus-community https://prometheus-community.github.io/helm-charts`
2. Update: `helm repo update`
3. Install Stack: `helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace`


1. Port-Forward: `kubectl port-forward deployment/prometheus-grafana 3000:3000 -n monitoring`
2. Login: Access `http://localhost:3000` (User: admin)

Grafana dashboard screenshots showing Node CPU and Memory metrics are included in this folder.
