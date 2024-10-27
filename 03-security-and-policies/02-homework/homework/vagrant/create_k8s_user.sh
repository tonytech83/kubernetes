#!/bin/bash

# Function to create OS Linux local users
create_os_users() {
  local username=$1

  sudo useradd -m -s /bin/bash ${username}
  sudo passwd ${username}

  printf "OS Linux local user %s was created successfully\n" "$username"
}

# Function to create a private key for user
create_private_key() {
  local username=$1

  cd /home/${username}
  sudo mkdir -p .certs && cd .certs

  printf "Generating private key for %s...\n" "$username"
  sudo openssl genrsa -out ${username}.key 2048

  printf "Private key generated for user %s\n" "$username"
}

# Function to create certificates for a Kubernetes user
create_certificates() {
  local username=$1
  local groupname=$2

  printf "Creating Certificate Signing Request (CSR) for %s...\n" "$username"
  sudo openssl req -new -key ${username}.key -out ${username}.csr -subj "/CN=${username}/O=${groupname}"

  printf "Signing the CSR with Kubernetes CA...\n"
  sudo openssl x509 -req -in ${username}.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out ${username}.crt -days 365

  printf "Certificates generated for user %s.\n" "$username"
}

# Function to create kubeconfig for a Kubernetes user
create_kubeconfig() {
  local username=$1

  printf "Creating kubeconfig for %s...\n" "$username"
  kubectl config set-credentials ${username} --client-certificate=/home/${username}/.certs/${username}.crt --client-key=/home/${username}/.certs/${username}.key
  kubectl config set-context ${username}-context --cluster=kubernetes --user=${username}

  printf "Kubeconfig created for user %s.\n" "$username"
}

# Function to create user config file
create_user_config() {
  local username=$1

  sudo mkdir -p /home/${username}/.kube
  cd /home/${username}/.kube

  cat > config << EOF
contexts:
- context:
    cluster: kubernetes
    user: ${username}
  name: ${username}-context
current-context: ${username}-context
kind: Config
preferences: {}
users:
- name: ${username}
  user:
    client-certificate: /home/${username}/.certs/${username}.crt
    client-key: /home/${username}/.certs/${username}.key
EOF

  sudo chown -R ${username}: /home/${username}/
}

# Read user input
read -p "Enter the username: " username
read -p "Enter the group name: " groupname

# Create certificates and config for the user
create_os_users $username
create_private_key $username
create_certificates $username $groupname
create_kubeconfig $username
create_user_config $username

printf "User %s from group %s has been registered in Kubernetes.\n" "$username" "$groupname"
