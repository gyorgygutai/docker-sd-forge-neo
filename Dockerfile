FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    libgl1 \
    libglib2.0-0 \
    libcairo2-dev \
    pkg-config \
    gcc \
    g++ \
    python3-dev \
    socat \
    && rm -rf /var/lib/apt/lists/*

RUN git clone -b neo https://github.com/Haoming02/sd-webui-forge-classic.git /app && \
    git checkout 205206478d5db909824dcd67fb4f85880ad308f2

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir joblib uvicorn

COPY entrypoint.sh /entrypoint.sh
COPY provisioning.sh /provisioning.sh
RUN chmod +x /entrypoint.sh /provisioning.sh

COPY ui-settings.json /app/ui-settings.json
COPY ui-config.json /app/ui-config.json

EXPOSE 7870

ENTRYPOINT ["/entrypoint.sh"]