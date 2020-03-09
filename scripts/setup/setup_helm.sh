#!/bin/bash

brew install kubernetes-helm
helm search hub
helm repo add all-charts https://kubernetes-charts.storage.googleapis.com/
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo update
helm repo list
#helm pull all-charts
#helm pull concourse-repo