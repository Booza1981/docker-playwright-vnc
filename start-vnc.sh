#!/bin/bash

# Start Xvfb with consistent display (matches environment variable in Dockerfile)
Xvfb :1 -screen 0 1920x1080x24 &

# Display is already set as ENV in Dockerfile

# Start fluxbox (lightweight window manager)
fluxbox &

# Start VNC server
x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever &

# Start noVNC (using the system installed version)
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 --listen 6080 &

# Keep the script running
tail -f /dev/null