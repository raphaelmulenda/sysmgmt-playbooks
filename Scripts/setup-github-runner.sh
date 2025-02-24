#!/bin/bash

set -e

# Variables
RUNNER_VERSION="2.322.0"
RUNNER_DIR="$HOME/actions-runner"
RUNNER_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
RUNNER_HASH="b13b784808359f31bc79b08a191f5f83757852957dd8fe3dbfcc38202ccf5768"
GITHUB_URL="https://github.com/Opsmiths-Technologies"
TOKEN="AS2IEZURQUI3EX3J3JXSE7THXTOSK"

# Install dependencies
sudo apt update && sudo apt install -y curl jq

# Create the runner directory
mkdir -p "$RUNNER_DIR" && cd "$RUNNER_DIR"

# Download the runner
curl -o actions-runner-linux-x64.tar.gz -L "$RUNNER_URL"

# Validate the hash
echo "$RUNNER_HASH  actions-runner-linux-x64.tar.gz" | shasum -a 256 -c

# Extract the installer
tar xzf ./actions-runner-linux-x64.tar.gz

# Configure the runner
./config.sh --url "$GITHUB_URL" --token "$TOKEN"

# Start the runner
./run.sh
