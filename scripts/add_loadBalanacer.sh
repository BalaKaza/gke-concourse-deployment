#!/bin/bash
set -e

BASE_DIR=$(pwd)

#Reserving static IP address.
export REGION=us-central1
gcloud compute addresses create concourse-ip --region ${REGION}
gcloud compute addresses describe concourse-ip --region ${REGION}
export EXTERNAL_IP=$(gcloud compute addresses describe concourse-ip \
    --region ${REGION} --format=json | jq -r .address)
yq w -i configuration/concourse-service.yml spec.loadBalancerIP ${EXTERNAL_IP}
echo "external facing IP " ${EXTERNAL_IP}

#Deploy load balancer on the static IP
kubectl create -f configuration/concourse-service.yml
kubectl get pods -o wide
kubectl get nodes -o wide
echo "Concourse available at http://"${EXTERNAL_IP}":8080"