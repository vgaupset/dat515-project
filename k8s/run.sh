#! /bin/bash


kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl apply -f kube-flannel.yml

kubectl taint nodes --all  node-role.kubernetes.io/control-plane-

kubectl apply -k .