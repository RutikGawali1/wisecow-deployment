#!/bin/bash
echo "======================================"
echo "🚀 Starting System Health Monitoring..."
echo "======================================"
python3 system_health/system_health.py

echo ""
echo "======================================"
echo "🌍 Starting Application Health Check..."
echo "======================================"
python3 app_health_checker/app_health_checker.py

echo ""
echo "✅ All monitoring tasks completed."
