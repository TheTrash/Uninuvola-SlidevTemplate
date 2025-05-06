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

# Installa dipendenze per Puppeteer (export PDF/HTML)
RUN apt-get install -y \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    wget \
    ca-certificates \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crea directory per slidev
RUN mkdir -p /home/jovyan/slidev

WORKDIR /home/jovyan/slidev

USER jovyan

CMD ["slidev", "dev"]
