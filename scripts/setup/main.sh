#!/bin/bash
set -e

BASE_DIR=$(pwd)

./scripts/setup/setup_gcp.sh
./scripts/setup/setup_helm.sh
./scripts/setup/install_concourse.sh