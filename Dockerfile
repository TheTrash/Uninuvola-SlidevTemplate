FROM quay.io/uninuvola/base:main

USER root

# Installa Node.js 18 e Slidev
ARG version=v18.20.2
ENV NODE_DIR=/node-$version-linux-x64
ENV PATH=$NODE_DIR/bin:$PATH

RUN apt update -y && apt install curl -y \
    && curl -fsSL https://nodejs.org/dist/$version/node-$version-linux-x64.tar.gz -o node.tar.gz \
    && tar -xzf node.tar.gz && rm node.tar.gz

RUN npm install -g @slidev/cli

# Crea directory per slidev
RUN mkdir -p /home/jovyan/slidev

WORKDIR /home/jovyan/slidev

EXPOSE 3030

USER jovyan

CMD ["slidev", "dev"]
