# LANDING_PAGE

## 📌 Project Overview

This project demonstrates how to:

1. **Design and build a company landing page** using HTML & CSS.

2. **Containerize** the application using Docker with Nginx as the base image.

3. **Push** the container image to Docker Hub.

4. **Deploy** the application to a local Kubernetes cluster using [Kind](https://kind.sigs.k8s.io/).

5. **Access** the application via a Kubernetes ClusterIP service.

## 🛠️ 1. Building the Landing Page

The landing page was created with:

* `index.html` — Contains the page structure and content.

* `styles.css` — Contains the styling for the landing page.

The layout includes:

* Navigation bar

* Hero section with headline and CTA

* About section

* Services section

* Contact CTA

* Footer

## 📦 2. Containerizing the Application

We used **Nginx** as the base image to serve our static files.

**Dockerfile:**

```
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY . .
EXPOSE 80

```

Steps to build locally:

```
# Build the Docker image
docker build -t landing_page .

# Test locally
docker run -d -p 8080:80 landing_page

```

## ☁️ 3. Pushing to Docker Hub

Log in to Docker Hub:

```
docker login

```

Tag the image:

```
docker tag landing_page nnanaibe/techcorp:v1.0

```

Push the image:

```
docker push nnanaibe/techcorp:v1.0

```

## 🚀 4. Deploying on Kubernetes with Kind

Install prerequisites:

* Docker

* kubectl

* Kind

Create the Kind cluster:

```
kind create cluster --name tech-corp-cluster

```

Verify:

```
kubectl cluster-info --context kind-tech-corp-cluster
kubectl get nodes

```

## 📄 5. Kubernetes Manifests

We created one YAML file containing both Deployment and Service:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: landing-page
spec:
  replicas: 1
  selector:
    matchLabels:
      app: landing-page
  template:
    metadata:
      labels:
        app: landing-page
    spec:
      containers:
      - name: landing-page
        image: yourusername/company-landing:latest
        ports:
        - containerPort: 80
```
```
apiVersion: v1
kind: Service
metadata:
  name: landing-service
spec:
  type: ClusterIP
  selector:
    app: landing-page
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

```

## 📥 6. Deploy to the cluster

```
kubectl apply -f landing_page.yaml
kubectl apply -f landing_service.yaml
kubectl get pods
kubectl get svc

```

## 🌐 7. Accessing the Landing Page

Since we used ClusterIP, it’s only accessible inside the cluster.
We use port-forwarding to access it locally:

```
kubectl port-forward service/landing-service 8080:80

```

Then open your browser:

```
http://localhost:8080

