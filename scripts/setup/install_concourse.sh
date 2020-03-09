#!/bin/bash
set -e

helm fetch all-charts/concourse
helm install bala-concourse all-charts/concourse

echo "Getting all k8s configuration files."
mkdir concourse-config

pushd concourse-config
  kubectl get pod $(kubectl get pods --namespace default -l "app=bala-concourse-web" -o jsonpath="{.items[0].metadata.name}") -o yaml > concourse-web.yml
  kubectl get pod $(kubectl get pods --namespace default -l "app=postgresql" -o jsonpath="{.items[0].metadata.name}") -o yaml > concourse-postgresql.yml
  kubectl get pod $(kubectl get pods --namespace default -l "app=bala-concourse-worker" -o jsonpath="{.items[0].metadata.name}") -o yaml > concourse-worker-0.yml
  kubectl get pod $(kubectl get pods --namespace default -l "app=bala-concourse-worker" -o jsonpath="{.items[1].metadata.name}") -o yaml > concourse-worker-1.yml
popd

export POD_NAME=$( kubectl get pods --namespace default -l "app=bala-concourse-web" -o jsonpath="{.items[0].metadata.name}")
#Uncomment this if running locally
#echo "Visit http://127.0.0.1:8080 to use Concourse"
#kubectl port-forward --namespace default $POD_NAME 8080:8080