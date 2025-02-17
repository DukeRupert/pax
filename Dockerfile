FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Go and GCC
RUN apt-get update && apt-get install -y \
    golang-go \
    gcc \
    git \
    curl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Build Hugo Extended from source
ENV CGO_ENABLED=1
RUN go install -tags extended github.com/gohugoio/hugo@latest

# Install Tailwind CSS CLI
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
    && chmod +x tailwindcss-linux-x64 \
    && mv tailwindcss-linux-x64 /usr/local/bin/tailwindcss

# Add Go binaries to PATH
ENV PATH="/root/go/bin:${PATH}"

# Set working directory
WORKDIR /workspace
