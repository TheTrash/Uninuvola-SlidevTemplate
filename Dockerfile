FROM quay.io/uninuvola/base:main

USER root

# Install Node.js 18 (with npm)
ARG version=v18.20.2
ENV NODE_DIR=/node-$version-linux-x64
ENV PATH=$NODE_DIR/bin:$PATH

RUN apt update -y && apt install curl -y \
    && curl -fsSL https://nodejs.org/dist/$version/node-$version-linux-x64.tar.gz -o node.tar.gz \
    && tar -xzf node.tar.gz && rm node.tar.gz

# Slidev will be installed in "/opt/slidev" by jovyan user
# This let the users to install other packages via npm without sudo privileges
# and this folder isn't overridden by docker bindmount
RUN mkdir -p /opt/slidev/ && chown -R jovyan:users /opt/slidev/

USER jovyan

ENV PATH="/opt/slidev/bin:$PATH"

# Install slidev
RUN npm config set prefix '/opt/slidev' && \
    npm install -g @slidev/cli && \
    npm install -g @slidev/theme-seriph && \
    npm install -g slidev-theme-academic
