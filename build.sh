#!/bin/bash
# Make sure VNC script is executable
chmod +x start-vnc.sh

# Check if the previous container exists and remove it if necessary
if [ "$(docker ps -aq -f name=playwright-vnc)" ]; then
    echo "Removing previous container..."
    docker stop playwright-vnc >/dev/null 2>&1
    docker rm playwright-vnc >/dev/null 2>&1
fi

# Build the Docker image
echo "Building Docker image for Playwright VNC..."
docker build -t playwright-vnc .

# Run the container with port mappings
echo "Starting container..."
docker run -d \
    --name playwright-vnc \
    -p 5900:5900 \
    -p 6080:6080 \
    -p 8888:8888 \
    -v "$(pwd)/data:/app/data" \
    playwright-vnc

echo
echo "Container started successfully!"
echo "------------------------------------------------"
echo "You can access:"
echo "  - VNC: localhost:5900"
echo "  - noVNC Web Interface: http://localhost:6080"
echo "  - Jupyter Lab: http://localhost:8888"
echo
echo "To check container logs:"
echo "  docker logs playwright-vnc"
echo
echo "To stop and remove the container:"
echo "  docker stop playwright-vnc"
echo "  docker rm playwright-vnc"
echo "------------------------------------------------"