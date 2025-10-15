# Use Alpine Linux base instead of coturn image
FROM alpine:latest

# Install coturn and dependencies
RUN apk update && \
    apk add --no-cache \
    coturn \
    bash

# Create directories
RUN mkdir -p /var/log/coturn && \
    mkdir -p /var/lib/coturn

# Copy configuration
COPY turnserver.conf /etc/turnserver.conf

# Expose ports
EXPOSE 3478/udp 3478/tcp 5349/udp 5349/tcp

# Run as non-root user (important for Render)
RUN adduser -D -s /bin/bash turnserver
USER turnserver

# Start TURN server
CMD ["turnserver", "-c", "/etc/turnserver.conf"]
