# Day 19 - Shell Scripting Project: Log Rotation, Backup & Crontab

## Objective

Apply shell scripting concepts learned in previous days by creating practical automation scripts for log rotation, backups, and scheduled maintenance.

---

# Task 1: Log Rotation Script

## Requirements

* Accept a log directory as an argument.
* Compress `.log` files older than 7 days.
* Delete `.gz` files older than 30 days.
* Display the number of files compressed and deleted.
* Exit with an error if the directory does not exist.

## Script: `log_rotate.sh`

```bash
#!/bin/bash

LOG_DIR=$1

if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

COMPRESSED=0
DELETED=0

while read -r file
do
    gzip "$file"
    ((COMPRESSED++))
done < <(find "$LOG_DIR" -type f -name "*.log" -mtime +7)

while read -r file
do
    rm -f "$file"
    ((DELETED++))
done < <(find "$LOG_DIR" -type f -name "*.gz" -mtime +30)

echo "Files compressed: $COMPRESSED"
echo "Files deleted: $DELETED"
```

### Sample Output

```text
Files compressed: 5
Files deleted: 2
```

---

# Task 2: Server Backup Script

## Requirements

* Accept source and destination directories as arguments.
* Create a timestamped `.tar.gz` archive.
* Verify backup creation.
* Display archive name and size.
* Delete backups older than 14 days.
* Exit with an error if the source directory does not exist.

## Script: `backup.sh`

```bash
#!/bin/bash

SOURCE=$1
DEST=$2

if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "Error: Source directory does not exist"
    exit 1
fi

mkdir -p "$DEST"

DATE=$(date +%Y-%m-%d)

ARCHIVE="$DEST/backup-$DATE.tar.gz"

tar -czf "$ARCHIVE" "$SOURCE"

if [ $? -ne 0 ]; then
    echo "Backup failed"
    exit 1
fi

SIZE=$(du -h "$ARCHIVE" | cut -f1)

echo "Backup created successfully"
echo "Archive: $ARCHIVE"
echo "Size: $SIZE"

find "$DEST" -type f -name "*.tar.gz" -mtime +14 -delete
```

### Sample Output

```text
Backup created successfully
Archive: /backup/backup-2026-06-10.tar.gz
Size: 25M
```

---

# Task 3: Cron Jobs

## Check Existing Cron Jobs

```bash
crontab -l
```

## Edit Cron Jobs

```bash
crontab -e
```

## Cron Syntax

```text
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

## Daily Log Rotation at 2 AM

```cron
0 2 * * * /home/user/log_rotate.sh /var/log/myapp
```

## Weekly Backup Every Sunday at 3 AM

```cron
0 3 * * 0 /home/user/backup.sh /var/www /backup
```

## Health Check Every 5 Minutes

```cron
*/5 * * * * /home/user/health_check.sh
```

---

# Task 4: Scheduled Maintenance Script

## Requirements

* Execute log rotation.
* Execute backup.
* Store output in `/var/log/maintenance.log`.
* Include timestamps.

## Script: `maintenance.sh`

```bash
#!/bin/bash

LOGFILE="/var/log/maintenance.log"

echo "[$(date)] Starting maintenance" >> "$LOGFILE"

./log_rotate.sh /var/log/myapp >> "$LOGFILE" 2>&1

./backup.sh /var/www /backup >> "$LOGFILE" 2>&1

echo "[$(date)] Maintenance completed" >> "$LOGFILE"
```

### Sample Log Output

```text
[Wed Jun 10 01:00:01 IST 2026] Starting maintenance

Files compressed: 5
Files deleted: 2

Backup created successfully
Archive: /backup/backup-2026-06-10.tar.gz
Size: 25M

[Wed Jun 10 01:00:05 IST 2026] Maintenance completed
```

## Cron Entry

```cron
0 1 * * * /home/user/maintenance.sh
```

---

# Key Concepts Learned

### 1. Log Rotation

Used `find`, `gzip`, and file age checks (`-mtime`) to automate log management and reduce disk usage.

### 2. Automated Backups

Created compressed archives using `tar`, verified successful creation, and removed outdated backups automatically.

### 3. Task Scheduling with Cron

Learned how to automate script execution using cron jobs for daily, weekly, and recurring maintenance tasks.

---

# Commands Used

```bash
find
gzip
rm
tar
du
date
cron
crontab
``


