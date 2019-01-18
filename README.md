# Solution

### Prerequisites
1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/#install-minikube). Make `minikube start` to initialize your local kubernetes cluster. Check that cluster is configured correctly with `kubectl get nodes` or `kubectl get all`
2. Install [helm](https://docs.helm.sh/using_helm/#installing-helm) and make `helm init`
3. You must have [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/) installed.
4. You must have an account on [Docker Hub](https://hub.docker.com/). *PS. In my example I will use my own **flomsk** account.*

### Installation steps
- Now you have to build containers and upload them to Docker Hub.
  - `docker login` - enter your credentials to Docker Hub
  - start script which builds and uploads images to docker hub. `/bin/bash upload-images.sh HUBUSERNAME HUBREPOSITORY`. In my case it will be `./upload-images.sh flomsk join-apps`. Repository name we will need in the next steps.
- Next step is to install nginx-ingress-controller. `helm install --namespace ingress --name proxy stable/nginx-ingress`
- Make a changes in `join-apps/values.yaml`. You must specify your image repository and prefered ingress hostname. Or you can leave as is and use my set.
- Start the main helm chart. `helm install --name acceleration join-apps`. Then you will see NOTES about how to verify your installation.
____________________________________________
# Infrastructure Engineer (DevOps) Challenge
![JOIN acceleration](https://github.com/join-com/devops-challenge/raw/master/illustration.png)

## The context
This challenge addresses a web application with a microservice architecture to calculate the [acceleration](http://www.softschools.com/formulas/physics/acceleration_formula/1/) of an object.
## The application
- The application contains 3 microservices
- Each microservice takes care of only one arithmetic operation
- The microservices take inputs from the URL query form and return the result in JSON format
- The microservices are not stable and can stop serving requests
## Services:
- `acceleration-dv` calculates `𝚫v=vf-vi`
```bash
curl http://127.0.0.1:3001/dv?vf=200&vi=5
{"dv":195}
```
- `acceleration-a` calculates `a=𝚫v/t`
```bash
curl http://127.0.0.1:3002/a?dv=200&t=5
{"a":40}
```
- `acceleration-calc` coordinates request to `acceleration-dv` and `acceleration-a` services
```bash
curl http://127.0.0.1:3000/calc?vf=200&vi=5&t=123
{"a":1.5853658536585367}
```

# Task
- Using [Helm](https://helm.sh), write the necessary Kubernetes deployment and service files that can be used to create the full application, running 2 instances of each microservice.
- Only  `/calc` of `acceleration-calc` microservices can be available outside of the kubernetes cluster.
- Run the application on a kubernetes cluster like Minikube or Docker for Mac.
- Make sure the application is stable.

# Environment Setup
- Microservices are written on Typescript and Node.js version 10.14.2
- You would need to setup `yarn`
- Run `yarn install` to setup all required components
- Run `yarn build` to build production ready code
- Run `yarn dev` to run a service in dev environment
- Run `yarn start` to run a service in production

# Instructions
- Fork this repo
- The challenge is on!
- Create a pull request
- Please complete your working solution within 7 days of receiving this challenge, and be sure to notify us when it is ready for review.

