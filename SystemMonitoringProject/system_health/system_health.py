#!/usr/bin/env python3
import psutil
import logging
from datetime import datetime

# Log file setup
logging.basicConfig(filename="system_health/system_health.log",
                    level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s')

# Thresholds
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 80
DISK_THRESHOLD = 80

def check_cpu():
    cpu_usage = psutil.cpu_percent(interval=1)
    if cpu_usage > CPU_THRESHOLD:
        logging.warning(f"⚠️ High CPU usage detected: {cpu_usage}%")
    else:
        logging.info(f"CPU usage: {cpu_usage}%")
    return cpu_usage

def check_memory():
    memory = psutil.virtual_memory()
    if memory.percent > MEMORY_THRESHOLD:
        logging.warning(f"⚠️ High Memory usage detected: {memory.percent}%")
    else:
        logging.info(f"Memory usage: {memory.percent}%")
    return memory.percent

def check_disk():
    disk = psutil.disk_usage('/')
    if disk.percent > DISK_THRESHOLD:
        logging.warning(f"⚠️ High Disk usage detected: {disk.percent}%")
    else:
        logging.info(f"Disk usage: {disk.percent}%")
    return disk.percent

def check_processes():
    total_processes = len(psutil.pids())
    logging.info(f"Total running processes: {total_processes}")
    return total_processes

def main():
    print("=== System Health Monitoring ===")
    print(f"CPU Usage: {check_cpu()}%")
    print(f"Memory Usage: {check_memory()}%")
    print(f"Disk Usage: {check_disk()}%")
    print(f"Running Processes: {check_processes()}")

if __name__ == "__main__":
    main()
