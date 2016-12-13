#!/usr/bin/env bash
images=(kube-proxy-amd64:v1.5.0 kubedns-amd64:1.9 kube-scheduler-amd64:v1.5.0 kube-controller-manager-amd64:v1.5.0 kube-apiserver-amd64:v1.5.0 kube-dnsmasq-amd64:1.4 exechealthz-amd64:v1.2.0)
for imageName in ${images[@]} ; do
  docker pull gysan/$imageName
  docker tag gysan/$imageName 123.206.77.131:5000/google_containers/$imageName
  docker rmi gysan/$imageName
done