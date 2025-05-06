FROM quay.io/uninuvola/base:main

# DO NOT EDIT USER VALUE
USER root

## -- ADD YOUR CODE HERE !! -- ##
# Installa Node.js 18 e Slidev
ARG version=v22.15.0

RUN apt update -y && apt install curl -y \
&& curl -fsSL https://nodejs.org/dist/$version/node-$version-linux-x64.tar.gz -o node.tar.gz \
&& tar -xzvf node.tar.gz && rm node.tar.gz \
&& echo "export PATH=$PATH:/node-$version-linux-x64/bin" >> /root/.bashrc
RUN npm install -g slidev

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

## --------------------------- ##

# DO NOT EDIT USER VALUE
USER jovyan

# Avvia slidev se necessario (modificabile con docker run override)
CMD ["slidev", "dev"]
