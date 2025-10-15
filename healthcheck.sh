#!/bin/sh

# Simple health check that uses built-in tools
# Check if TURN server port is open

if command -v nc >/dev/null 2>&1; then
    # Use netcat if available
    if nc -z localhost 3478; then
        echo "TURN server is running on port 3478"
        exit 0
    else
        echo "TURN server is not responding on port 3478"
        exit 1
    fi
else
    # Use built-in shell redirection
    if timeout 5 sh -c 'echo > /dev/tcp/localhost/3478'; then
        echo "TURN server is running on port 3478"
        exit 0
    else
        echo "TURN server is not responding on port 3478"
        exit 1
    fi
fi
