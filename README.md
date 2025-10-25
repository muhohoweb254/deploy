Kubernetes manifests for School App

This directory contains an all-in-one Kubernetes manifest that deploys the stack defined in docker-compose.yml to a Kubernetes cluster.

Contents
- all-in-one.yaml: Namespace, ConfigMaps, Services, Deployments/StatefulSets for:
  - Postgres
  - Keycloak
  - UI
  - API Gateway
  - Students, Library, Course, Exam services
  - Prometheus, Alertmanager, Grafana
  - SQL Server (for Fees) and Fees service

Quick start (local)
1) Create the namespace and apply all resources:
   kubectl apply -f kubernetes/all-in-one.yaml

2) Access services:
   - UI: NodePort 30200 on your node IP (e.g., http://localhost:30200 with minikube service ui --url)
   - Prometheus: NodePort (service prometheus)
   - Grafana: NodePort (service grafana)

Notes and required updates
- Environment variables: ConfigMaps ui-env, apigateway-env, students-env, library-env, course-env, exam-env are placeholders. Fill them with values from the respective .env files in this repo if required by your services.
- Database init script: db-init-sql ConfigMap includes a TODO placeholder. If you need to initialize Postgres with SQL, paste the content of database/init.sql into the init.sql key.
- Keycloak realm: keycloak-realm ConfigMap currently contains a minimal JSON. Replace its content with the full content of Keycloak/school-realm.json if you want automatic realm import.
- Images: The manifests reference Docker images from muhohoweb/* where available. Ensure these images are accessible from your cluster. For services that were built locally in docker-compose, publish images or update the image references accordingly.
- Storage: Postgres and SQL Server use PersistentVolumeClaims. On local clusters, ensure a default StorageClass exists, or edit the manifests to specify one.
- DNS and service discovery: Services are discoverable by their names within the namespace (e.g., postgres:5432, keycloak:8080).

Customize
- To change exposure types (e.g., LoadBalancer/Ingress), edit the Service types or add an Ingress resource.
- Add/adjust liveness/readiness probes according to your applications.

Delete
- To remove all resources:
  kubectl delete -f kubernetes/all-in-one.yaml
