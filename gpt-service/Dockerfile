# ---- Base Node ----
FROM node:19-alpine AS base
WORKDIR /app
COPY package*.json ./

# ---- Dependencies ----
FROM base AS dependencies
RUN npm ci

# ---- Build ----
FROM dependencies AS build
COPY . .
RUN npm run build

# ---- Production ----
FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOST=0.0.0.0
ENV CUDA_DOCKER_ARCH=all
ENV LLAMA_CUBLAS=1

WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/package*.json ./
COPY --from=build /app/next.config.js ./next.config.js
COPY --from=build /app/next-i18next.config.js ./next-i18next.config.js

## Add the wait script to the image
COPY --from=ghcr.io/ufoscout/docker-compose-wait:latest /wait /wait

# Install system dependencies
# Install Node.js 19.x
RUN apt-get update && apt-get install -y --assume-yes \
    wget python3-pip curl \
    && rm -rf /var/lib/apt/lists/* \
    && wget -qO- https://deb.nodesource.com/setup_19.x | bash - \ 
    && apt-get install -y nodejs \
    && CMAKE_ARGS="-DLLAMA_CUBLAS=on" FORCE_CMAKE=1 pip install llama-cpp-python \
    && pip install numpy diskcache uvicorn fastapi sse-starlette pydantic-settings \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd \
    && apt-get clean 

COPY ./run.sh ./run.sh

# Expose any necessary ports
EXPOSE 3000 8000

# Entrypoint or CMD to start your application
CMD ["/bin/sh", "/app/run.sh"]

