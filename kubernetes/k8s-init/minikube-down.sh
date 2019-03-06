#! /bin/bash

if [ ! -x "$(command -v minikube)" ]; then
  echo "No minikube command found. Installing..."
  cd ~/Downloads ; curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64; and sudo install minikube-linux-amd64 /usr/local/bin/minikube
fi

minikube delete
