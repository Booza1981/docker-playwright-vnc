#!/bin/bash

# Make sure VNC script is executable
chmod +x start-vnc.sh

# Build and start the container using docker compose
echo "Building and starting with docker compose..."
docker compose up -d

echo
echo "Container started successfully!"
echo "------------------------------------------------"
echo "You can access:"
echo "  - VNC: localhost:5900"
echo "  - noVNC Web Interface: http://localhost:6080"
echo "  - Jupyter Lab: http://localhost:8888"
echo
echo "To check container logs:"
echo "  docker compose logs"
echo
echo "To stop the container:"
echo "  docker compose down"
echo "------------------------------------------------"