#! /bin/bash
sudo apt update -y
sudo apt upgrade -y

# docker

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo systemctl enable docker
sudo systemctl start docker


#kube

sudo apt-get install -y apt-transport-https ca-certificates curl vim git 

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# disable swap space

sudo swapoff -a

sudo sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab

# install container runtime

sudo tee /etc/modules-load.d/k8s.conf <<EOF
overlay
br_netfilter
EOF


sudo modprobe overlay 

sudo modprobe br_netfilter 

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


sudo sysctl --system

sudo apt install -y containerd.io 


sudo mkdir -p /etc/containerd

sudo containerd config default | sudo tee /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml



sudo systemctl restart containerd

sudo systemctl enable containerd

# Initilize control plane

sudo systemctl enable kubelet

sudo kubeadm config images pull --cri-socket /run/containerd/containerd.sock




wget https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/kustomization.yaml
sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/resources/frontend-service.yaml 
sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/resources/frontend-deployment.yaml 
sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/resources/backend-service.yaml 
sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/resources/backend-deployment.yaml 
sudo wget https://raw.githubusercontent.com/vgaupset/dat515-project/main/kustomize/resources/backend-persistent-volume.yaml 

mkdir /home/ubuntu/resources

mv kube-flannel.yml /home/ubuntu
mv kustomization.yaml /home/ubuntu

mv frontend-service.yaml /home/ubuntu/resources
mv frontend-deployment.yaml /home/ubuntu/resources
mv backend-service.yaml /home/ubuntu/resources
mv backend-deployment.yaml /home/ubuntu/resources
mv backend-persistent-volume.yaml /home/ubuntu/resources






sudo kubeadm init   --pod-network-cidr=10.244.0.0/16   --cri-socket /run/containerd/containerd.sock

mkdir -p /home/ubuntu/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
sudo chown 1000:1000 /home/ubuntu/.kube/config


