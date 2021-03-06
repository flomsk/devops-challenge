#!/bin/bash

INGRESSES=$(kubectl --context=minikube --all-namespaces=true get ingress | grep -v NAMESPACE | awk '{ print $3 }' | tr '\r\n' ' ')

MINIKUBE_IP=$(minikube ip)

HOSTS_ENTRY="$MINIKUBE_IP $INGRESSES"

if grep -Fq "$MINIKUBE_IP" /etc/hosts > /dev/null
then
    sudo sed -i '' "s/^$MINIKUBE_IP.*/$HOSTS_ENTRY/" /etc/hosts
    echo "Updated hosts entry"
else
    echo "$HOSTS_ENTRY" | sudo tee -a /etc/hosts
    echo "Added hosts entry"
fi
