FROM gitpod/workspace-full

USER root

RUN curl -o /usr/local/bin/kubectl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

ENV K8S_VERSION=1.21.2
ENV ARGO_VERSION=v2.12.13

#kubebuilder
RUN mkdir /usr/local/kubebuilder


RUN curl -L -o kubebuilder.tar.gz https://github.com/kubernetes-sigs/kubebuilder/releases/download/v2.3.1/kubebuilder_2.3.1_linux_amd64.tar.gz && \
    tar xvzf kubebuilder.tar.gz


# download kubebuilder and install locally.
#RUN curl -L -o kubebuilder.tar.gz https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH) && \
#    tar xvzf kubebuilder.tar.gz

RUN mv kubebuilder_2.3.1_linux_amd64/* /usr/local/kubebuilder

ENV PATH="/usr/local/kubebuilder/bin:${PATH}"

#ARGO CLI
RUN mkdir /usr/local/bin/argo

# Download the binary
RUN curl -L -o https://github.com/argoproj/argo-workflows/releases/download/${ARGO_VERSION}/argo-linux-amd64.gz

RUN tar xvzf argo-linux-amd64.gz

# Move binary to path
RUN mv argo-linux-amd64/* /usr/local/bin/argo


RUN apt-get install redis-server -y
RUN go install github.com/mattn/goreman@latest

USER root

ENV ARGOCD_REDIS_LOCAL=true
ENV KUBECONFIG=/tmp/kubeconfig
