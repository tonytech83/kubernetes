#!/bin/bash

# Get Kubernetes version
K8S_VERSION=$(kubectl version | grep "Server Version" | awk '{print $3}')

# Get OS name
K8S_OS=$(cat /etc/os-release | grep ^ID= | awk -F'=' '{print $2}')

# Create ConfigMap yaml file
cat > cm.yaml << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: hwcm
data:
  k8sver: "${K8S_VERSION}"
  k8sos: "${K8S_OS}"
EOF