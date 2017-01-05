#!/usr/bin/env bash
images=(kube-proxy-amd64:v1.5.1 kubedns-amd64:1.9 kube-scheduler-amd64:v1.5.1 kube-controller-manager-amd64:v1.5.1 kube-apiserver-amd64:v1.5.1 kube-dnsmasq-amd64:1.4 exechealthz-amd64:v1.2.0)
for imageName in ${images[@]} ; do
  docker pull gysan/$imageName
  docker tag gysan/$imageName gcr.io/google-containers/google_containers/$imageName
  docker rmi gysan/$imageName
done