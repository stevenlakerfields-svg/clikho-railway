FROM coturn/coturn:latest

# Install dependencies for health checks
RUN apt-get update && apt-get install -y \
    curl \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Create log directory
RUN mkdir -p /var/log/coturn

# Expose TURN server ports
EXPOSE 3478 3478/udp 5349 5349/tcp

# Copy configuration file
COPY turnserver.conf /etc/turnserver.conf

# Create a simple health check script
COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD /usr/local/bin/healthcheck.sh

# Run TURN server
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
