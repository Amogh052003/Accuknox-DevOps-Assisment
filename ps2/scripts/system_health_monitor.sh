#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

LOG_FILE="system_health.log"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "==========================================" | tee -a "$LOG_FILE"
echo "System Health Report - $TIMESTAMP" | tee -a "$LOG_FILE"
echo "==========================================" | tee -a "$LOG_FILE"

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2 + $4)}')

echo "CPU Usage: ${CPU_USAGE}%" | tee -a "$LOG_FILE"

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: CPU usage exceeded ${CPU_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# Memory Usage
MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')

echo "Memory Usage: ${MEMORY_USAGE}%" | tee -a "$LOG_FILE"

if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "ALERT: Memory usage exceeded ${MEMORY_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# Disk Usage
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Disk Usage: ${DISK_USAGE}%" | tee -a "$LOG_FILE"

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: Disk usage exceeded ${DISK_THRESHOLD}%" | tee -a "$LOG_FILE"
fi

# Running Processes
PROCESS_COUNT=$(ps -e --no-headers | wc -l)

echo "Running Processes: $PROCESS_COUNT" | tee -a "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"