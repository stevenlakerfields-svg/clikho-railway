FROM coturn/coturn:latest

# Install any additional packages if needed
RUN apt-get update && apt-get install -y \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Expose TURN server ports
EXPOSE 3478 3478/udp 5349 5349/udp

# Copy configuration file
COPY turnserver.conf /etc/turnserver.conf

# Run TURN server
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
