FROM gitpod/workspace-full

USER root

RUN curl -o /usr/local/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl


#WORKDIR /usr/local/

RUN mkdir /usr/local/kubebuilder

#WORKDIR /usr/local/kubebuilder

RUN curl -L -o kubebuilder.tar.gz https://github.com/kubernetes-sigs/kubebuilder/releases/download/v2.3.1/kubebuilder_2.3.1_linux_amd64.tar.gz && \
    tar xvzf kubebuilder.tar.gz

RUN export K8S_VERSION=1.21.2

# download kubebuilder and install locally.
#RUN curl -L -o kubebuilder.tar.gz https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH) && \
#    tar xvzf kubebuilder.tar.gz

RUN mv /usr/local/kubebuilder_2.3.1_linux_amd64 /usr/local/kubebuilder

RUN chmod +x kubebuilder 

RUN apt-get install redis-server -y
RUN go get github.com/mattn/goreman

USER root

ENV ARGOCD_REDIS_LOCAL=true
ENV KUBECONFIG=/tmp/kubeconfig
