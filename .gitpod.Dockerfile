FROM gitpod/workspace-full

USER root

RUN curl -o /usr/local/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl


#WORKDIR /usr/local/

#RUN mkdir kubebuilder

#WORKDIR /usr/local/kubebuilder

#RUN curl -L -o kubebuilder_2.3.1_linux_amd64.tar.gz https://github.com/kubernetes-sigs/kubebuilder/releases/download/v2.3.1/kubebuilder_2.3.1_linux_amd64.tar.gz && \
#    tar xvzf kubebuilder_2.3.1_linux_amd64.tar.gz

RUN export K8S_VERSION=1.21.2
RUN curl -sSLo envtest-bins.tar.gz "https://go.kubebuilder.io/test-tools/${K8S_VERSION}/$(go env GOOS)/$(go env GOARCH)"

RUN mkdir /usr/local/kubebuilder
RUN tar -C /usr/local/kubebuilder --strip-components=1 -zvxf envtest-bins.tar.gz


RUN apt-get install redis-server -y
RUN go get github.com/mattn/goreman

USER root

ENV ARGOCD_REDIS_LOCAL=true
ENV KUBECONFIG=/tmp/kubeconfig
