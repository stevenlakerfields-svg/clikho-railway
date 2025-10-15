FROM coturn/coturn:latest

# Use Alpine-based image which is more reliable
# The base coturn image already has necessary tools

# Create log directory
RUN mkdir -p /var/log/coturn

# Expose TURN server ports
EXPOSE 3478 3478/udp 5349 5349/tcp

# Copy configuration file
COPY turnserver.conf /etc/turnserver.conf

# Use built-in health check (no external dependencies needed)
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD timeout 5 sh -c 'echo > /dev/tcp/localhost/3478' || exit 1

# Run TURN server
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
