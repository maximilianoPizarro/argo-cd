FROM gitpod/workspace-full

USER root

RUN curl -o /usr/local/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

RUN curl -L -o kubebuilder_2.3.1_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kubebuilder/releases/download/v2.3.1/kubebuilder_2.3.1_linux_amd64.tar.gz | \
    tar -xz -C /tmp/ && mv /tmp/kubebuilder_2.3.1_linux_amd64.tar.gz /usr/local/kubebuilder

RUN apt-get install redis-server -y
RUN go get github.com/mattn/goreman

USER gitpod

ENV ARGOCD_REDIS_LOCAL=true
ENV KUBECONFIG=/tmp/kubeconfig
