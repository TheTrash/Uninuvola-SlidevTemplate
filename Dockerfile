FROM quay.io/uninuvola/base:main

USER root

# Installa Node.js 18 e Slidev
ARG version=v18.20.2
ENV NODE_DIR=/node-$version-linux-x64
ENV PATH=$NODE_DIR/bin:$PATH

RUN apt update -y && apt install curl -y \
    && curl -fsSL https://nodejs.org/dist/$version/node-$version-linux-x64.tar.gz -o node.tar.gz \
    && tar -xzf node.tar.gz && rm node.tar.gz

USER jovyan

# NOTE: in case of errors, could be added to .bashrc too !
ENV PATH="~/.local/bin:$PATH"

RUN npm config set prefix '~/.local/' && mkdir -p ~/.local/bin

RUN npm install -g @slidev/cli && \
    npm install -g @slidev/theme-seriph && \
    npm install -g slidev-theme-academic
