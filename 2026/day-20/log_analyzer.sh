#!/bin/bash

#======================================
#Task 1 - Input Validation
#======================================

if [ $# -ne 1 ]; then
	echo "Usage: $0 <Please provide a log file>"
	exit 1
fi

LOGFILE=$1

if [ ! -f "$LOGFILE" ]; then
	echo "$LOGFILE File does not exist"
	exit 1
fi

# ==========================
# Variables
# ==========================

DATE=$(date +%y-%m-%d)
REPORT="log_report_$DATE.txt"

TOTAL_LINES=$(wc -l | "$LOGFILE")

#Count Error and Failed

ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOGFILE" | wc -l)

CRITICAL_EVENTS=$(grep -n "critical" | wc -l)

# Top Error Messages
TOP_ERRORS=$(grep "ERROR" "$LOGFILE" \
| sed 's/.*ERROR //' \
| sort \
| uniq -c \
| sort -rn \
| head -5)

# ==========================
# Task 2: Error Count
# ==========================

echo "Total Errors Found: $ERROR_COUNT"

# ==========================
# Task 3: Critical Events
# ==========================

echo
echo "--- Critical Events ---"

if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi

# ==========================
# Task 4: Top Errors
# ==========================

echo
echo "--- Top 5 Error Messages ---"
echo "$TOP_ERRORS"

# ==========================
# Task 5: Report Generation
# ==========================

{
echo "=================================="
echo "      LOG ANALYSIS REPORT"
echo "=================================="
echo
echo "Date of Analysis : $DATE"
echo "Log File         : $LOGFILE"
echo "Total Lines      : $TOTAL_LINES"
echo "Total Errors     : $ERROR_COUNT"

echo
echo "--- Top 5 Error Messages ---"
echo "$TOP_ERRORS"

echo
echo "--- Critical Events ---"

if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi

} > "$REPORT"

echo
echo "Report generated: $REPORT"

# ==========================
# Task 6: Archive Log File
# ==========================

mkdir -p archive

mv "$LOGFILE" archive/

echo "Log file moved to archive/"
