FROM rancher/k3s:v1.23.3-k3s1

RUN mkdir -p /var/lib/rancher/k3s/agent/images/

COPY k3s-airgap-images-amd64.tar /var/lib/rancher/k3s/agent/images/
