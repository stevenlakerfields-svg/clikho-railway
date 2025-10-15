FROM coturn/coturn:latest

# Create log directory
RUN mkdir -p /var/log/coturn

# Expose TURN server ports
EXPOSE 3478 3478/udp 5349 5349/tcp

# Copy configuration file
COPY turnserver.conf /etc/turnserver.conf

# Run TURN server (Render will handle health checks)
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
