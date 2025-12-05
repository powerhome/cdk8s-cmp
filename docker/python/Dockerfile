ARG PYTHON_TAG_SHA=latest@sha256:595140b768992c05b096570e5ae487a02a2c6b3ae23ba33ce0fc34b99579c98e
FROM python:${PYTHON_TAG_SHA}

ENV VENV_PATH=/opt/venv
ENV PATH="$VENV_PATH/bin:$PATH"

USER root

COPY plugin.yaml ./home/argocd/cmp-server/config/

# Create argocd group and user
RUN groupadd -g 1000 argocd && \
    useradd -u 999 -g argocd -d /home/argocd -m -s /bin/bash argocd && \
    chown argocd:root /home/argocd && \
    chmod g=u /home/argocd

# Install node and cdk8s-cli
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g cdk8s-cli@2.200.103

# Install helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
    apt-get install -y apt-transport-https && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update && \
    apt-get install helm=3.18.1-1

# Install sops
RUN curl -sSL https://github.com/getsops/sops/releases/download/v3.10.2/sops-v3.10.2.linux.amd64 \
    -o /usr/local/bin/sops && \
    chmod +x /usr/local/bin/sops

# Set up pipenv
RUN python3 -m venv $VENV_PATH && \
    $VENV_PATH/bin/pip install --upgrade pip && \
    $VENV_PATH/bin/pip install pipenv==2025.0.3

USER argocd
WORKDIR /home/argocd
