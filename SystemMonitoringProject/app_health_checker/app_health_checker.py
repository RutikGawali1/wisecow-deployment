#!/usr/bin/env python3
import requests
from datetime import datetime
import logging

# Log setup
logging.basicConfig(filename="app_health_checker/app_health.log",
                    level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

def check_app(url):
    try:
        response = requests.get(url, timeout=5)
        if response.status_code == 200:
            logging.info(f"✅ {url} is UP (Status Code: {response.status_code})")
            return "UP"
        else:
            logging.warning(f"⚠️ {url} returned Status Code {response.status_code}")
            return "DOWN"
    except requests.exceptions.RequestException as e:
        logging.error(f"❌ {url} is DOWN - Error: {e}")
        return "DOWN"

def main():
    print("=== Application Health Checker ===")
    with open("app_health_checker/app_list.txt", "r") as file:
        urls = [line.strip() for line in file.readlines() if line.strip()]
        
    for url in urls:
        status = check_app(url)
        print(f"{url:<40} Status: {status:<10} Checked At: {datetime.now()}")

if __name__ == "__main__":
    main()
