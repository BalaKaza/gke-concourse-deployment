#!/bin/bash
set -e

export PROJECT_ID=gemfire-testing
export CLUSTER_NAME=concourse-kube-cluster
#gcloud auth login
gcloud config set project $PROJECT_ID
gcloud container clusters get-credentials "$CLUSTER_NAME" \
 --zone us-central1-c --project "$PROJECT_ID"

kubectl cluster-info
kubectl describe nodes