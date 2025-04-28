FROM mcr.microsoft.com/playwright/python:latest

# Set non-interactive frontend and standardize DISPLAY
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1

# Install essential packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11vnc \
    fluxbox \
    wget \
    python3-pip \
    python3-notebook \
    jupyter \
    nano \
    dbus-x11 \
    net-tools \
    novnc \
    supervisor \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright
RUN pip install playwright && playwright install
RUN mkdir -p /root/.vnc \
    && mkdir -p /opt/bin \
    && mkdir -p /app

# Set up VNC password
RUN x11vnc -storepasswd password /root/.vnc/passwd

# Copy necessary scripts
COPY start-vnc.sh /opt/bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install Playwright and JupyterLab
RUN pip install playwright jupyterlab notebook && \
    playwright install && \
    playwright install-deps

# Expose ports (5900 for VNC, 6080 for noVNC, 8888 for Jupyter)
EXPOSE 5900 6080 8888

# Set working directory
WORKDIR /app

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]