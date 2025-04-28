# Docker Playwright VNC

A minimal Docker container with:
- Playwright for browser automation
- X11VNC for visual monitoring
- NoVNC for web-based VNC access
- JupyterLab for interactive coding

## Quick Start

### Option 1: Using build.sh (Docker commands)
```bash
# Make scripts executable first
chmod +x build.sh start-vnc.sh

# Build and run
./build.sh
```

### Option 2: Using Docker Compose
```bash
# Make scripts executable first
chmod +x docker-compose-run.sh start-vnc.sh

# Build and run with Docker Compose
./docker-compose-run.sh
```

## Access the Services

- JupyterLab: http://localhost:8888
- noVNC (web-based VNC viewer): http://localhost:6080
- Direct VNC: localhost:5900 (use any VNC viewer with password "password")

## Project Structure

- `Dockerfile` - Container definition
- `docker-compose.yml` - Service configuration
- `supervisord.conf` - Process management config
- `start-vnc.sh` - Script to initialize VNC services
- `build.sh` - Script to build and run using Docker
- `docker-compose-run.sh` - Script to build and run using Docker Compose
- `data/` - Persistent storage directory
  - `test_notebook.ipynb` - Sample Jupyter notebook for testing
  - `test_playwright_vnc.py` - Python script to test Playwright with VNC

## Testing the Setup

Once the container is running, you can test that everything is working by:

1. Open JupyterLab at http://localhost:8888
2. Navigate to the `/app/data/test_notebook.ipynb` file
3. Run the cells in the notebook to test both Jupyter and VNC functionality
4. Alternatively, run the test script directly with:
   ```bash
   docker exec playwright-vnc python /app/data/test_playwright_vnc.py
   ```

## Usage

Place your Playwright scripts in the container and run them through Jupyter.
The browser will be visible through the VNC interface for debugging.

## Example Playwright Script

You can create a simple test script in Jupyter:

```python
from playwright.sync_api import sync_playwright

def run(playwright):
    browser = playwright.chromium.launch(headless=False)
    context = browser.new_context()
    page = context.new_page()
    page.goto('https://example.com')
    page.screenshot(path='/app/data/screenshot.png')
    browser.close()

with sync_playwright() as playwright:
    run(playwright)
```