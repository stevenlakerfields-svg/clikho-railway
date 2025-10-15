FROM coturn/coturn:latest

COPY turnserver.conf /etc/turnserver.conf

EXPOSE 3478 3478/udp 5349 5349/tcp

CMD ["turnserver", "-c", "/etc/turnserver.conf"]
