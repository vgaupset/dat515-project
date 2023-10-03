#! /bin/bash

kubectl apply -f kube-flannel.yml

kubectl taint nodes --all  node-role.kubernetes.io/control-plane-

kubectl apply -k .