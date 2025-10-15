#!/bin/bash

# Health check for TURN server
# Check if TURN server is responding on the control port

# Try to connect to the TURN port
if nc -z localhost 3478; then
    echo "TURN server is running on port 3478"
    exit 0
else
    echo "TURN server is not responding on port 3478"
    exit 1
fi
