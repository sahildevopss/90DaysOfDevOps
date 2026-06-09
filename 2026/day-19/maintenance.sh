#!/bin/bash

LOGFILE="/var/log/maintenance.log"

echo "[$(date)] Starting maintenance" >> "$LOGFILE"

./log_rotate.sh /var/log/myapp >> "$LOGFILE" 2>&1

./backup.sh /var/www /backup >> "$LOGFILE" 2>&1

echo "[$(date)] Maintenance completed" >> "$LOGFILE"
