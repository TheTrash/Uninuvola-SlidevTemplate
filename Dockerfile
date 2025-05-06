FROM quay.io/uninuvola/base:main

# DO NOT EDIT USER VALUE
USER root

## -- ADD YOUR CODE HERE !! -- ##

# Installa Node.js 18 e Slidev
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g slidev

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
