# System Monitoring & Application Health Checker

## Overview

This project contains two Python scripts to monitor system health and check application uptime:

1. **System Health Monitoring Script**

   * Monitors CPU usage, memory usage, disk usage, and running processes.
   * Alerts are logged if any metric exceeds predefined thresholds.

2. **Application Health Checker Script**

   * Checks whether specified web applications are UP or DOWN using HTTP status codes.
   * Logs results and provides a timestamped report.

---

## Folder Structure

```
SystemMonitoringProject/
│
├── system_health/
│   ├── system_health.py
│   └── system_health.log
│
├── app_health_checker/
│   ├── app_health_checker.py
│   ├── app_list.txt
│   └── app_health.log
│
├── run_all.sh
├── requirements.txt
└── README.md
```

---

## Prerequisites

* Python 3.x installed on your system.
* Linux/Mac or Windows OS (Python works cross-platform).

---

## Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository_url>
cd SystemMonitoringProject
```

**Explanation:**

* `git clone` copies the repository to your local machine.
* `cd` moves you into the project directory.

---

### 2. Create a Virtual Environment (Optional but Recommended)

```bash
python3 -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

**Explanation:**

* `python3 -m venv venv` creates an isolated environment for dependencies.
* `source venv/bin/activate` activates the environment on Linux/Mac.
* `venv\Scripts\activate` activates the environment on Windows.
* This prevents conflicts with other Python projects.

---

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

**Explanation:**

* `pip install` installs all required Python libraries listed in `requirements.txt`.
* Libraries used:

  * `psutil` → System metrics (CPU, memory, disk, processes)
  * `requests` → HTTP requests for application uptime checking

---

## Usage

### 1. Run System Health Monitoring Script

```bash
python3 system_health/system_health.py
```

**Explanation:**

* Checks CPU, memory, disk usage, and running processes.
* Alerts if thresholds are exceeded.
* Logs results in `system_health/system_health.log`.

---

### 2. Run Application Health Checker Script

1. Add URLs to monitor in `app_health_checker/app_list.txt` (one per line):

```
https://www.google.com
https://www.github.com
```

2. Run the script:

```bash
python3 app_health_checker/app_health_checker.py
```

**Explanation:**

* Reads URLs from `app_list.txt`.
* Sends HTTP requests to each URL.
* Reports whether each application is **UP** or **DOWN**.
* Logs results in `app_health_checker/app_health.log`.

---

### 3. Run Both Scripts Together

```bash
./run_all.sh
```

**Explanation:**

* Executes both monitoring scripts sequentially.
* Provides a consolidated console output.
* Automatically logs both system and application health checks.

---

## Logs

* `system_health/system_health.log` – CPU, memory, disk, and process monitoring.
* `app_health_checker/app_health.log` – Application uptime and errors.

---

## Notes

* Modify thresholds in `system_health/system_health.py` as needed:

```python
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 80
DISK_THRESHOLD = 80
```

* Application checker handles network exceptions gracefully.

---

## License

This project is licensed under the MIT License.
