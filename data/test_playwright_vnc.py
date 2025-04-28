from playwright.sync_api import sync_playwright
import time

def test_basic_browser():
    """
    Basic test to verify Playwright is working with VNC visualization.
    This script will:
    1. Launch a visible browser
    2. Navigate to a test page
    3. Take a screenshot
    4. Perform some visible actions
    """
    with sync_playwright() as playwright:
        print("Launching browser...")
        browser = playwright.chromium.launch(headless=False)
        context = browser.new_context()
        page = context.new_page()
        
        # Navigate to test page
        print("Navigating to example.com...")
        page.goto('https://example.com')
        
        # Wait to make it visible in VNC
        time.sleep(2)
        
        # Take a screenshot
        print("Taking screenshot...")
        page.screenshot(path='/app/data/example_screenshot.png')
        
        # Type something to make it visible in VNC
        page.goto('https://www.google.com')
        time.sleep(2)
        
        # Type slowly to make it visible
        search_box = page.locator('[name="q"]')
        search_box.click()
        
        search_text = "Playwright with VNC is working!"
        print(f"Typing: {search_text}")
        for char in search_text:
            search_box.type(char, delay=100)
            time.sleep(0.1)
        
        # Press Enter to search
        search_box.press('Enter')
        time.sleep(3)
        
        # Take another screenshot
        print("Taking final screenshot...")
        page.screenshot(path='/app/data/google_screenshot.png')
        
        print("Test complete! Check the data directory for screenshots.")
        browser.close()

if __name__ == "__main__":
    test_basic_browser()
