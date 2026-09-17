FROM ubuntu:22.04

# Install required packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
        curl \
        git \
        jq \
        libicu70 \
        maven \
        ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Azure DevOps agent architecture
ENV TARGETARCH="linux-x64"

# Azure DevOps agent working directory
WORKDIR /azp

# Copy startup script
COPY start.sh .

# Create agent user
RUN useradd -m -d /home/agent agent && \
    chown -R agent:agent /azp /home/agent && \
    chmod +x /azp/start.sh

# Run as non-root user
USER agent

# Azure DevOps agent startup
ENTRYPOINT ["./start.sh"]
