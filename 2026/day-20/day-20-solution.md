# Day 20 - Log Analyzer and Report Generator

## Objective

Build a Bash script that analyzes log files, identifies errors and critical events, generates a summary report, and archives processed logs.

---

## Features Implemented

### Task 1: Input Validation

- Accepts a log file path as a command-line argument.
- Displays an error if no argument is provided.
- Displays an error if the file does not exist.

Example:

```bash
./log_analyzer.sh sample_log.log
```

---

### Task 2: Error Count

The script counts all log entries containing:

- error
- failed

Command used:

```bash
grep -aEi "error|failed" "$LOGFILE" | wc -l
```

Example Output:

```text
Total Errors Found: 137
```

---

### Task 3: Critical Events

The script searches for all entries containing:

```text
critical
```

and displays them with line numbers.

Command used:

```bash
grep -an "critical" "$LOGFILE"
```

If no critical events are found:

```text
No critical events found.
```

---

### Task 4: Top 5 Error Messages

The script extracts the most common error messages and displays them in descending order.

Command used:

```bash
grep -aEi "error|failed" "$LOGFILE" \
| awk -F': ' '{print $NF}' \
| sort \
| uniq -c \
| sort -rn \
| head -5
```

Example Output:

```text
25 Kerberos authentication failed
17 Software caused connection abort
8 open failed.
8 mdmpd failed
```

---

### Task 5: Summary Report

The script automatically generates:

```text
log_report_<date>.txt
```

Example:

```text
log_report_26-06-10.txt
```

The report contains:

- Date of analysis
- Log file name
- Total lines processed
- Total error count
- Top 5 error messages
- Critical events

---

### Task 6: Archive Processed Logs

The script automatically creates an archive directory if it does not exist:

```bash
mkdir -p archive
```

After analysis, the processed log file is moved:

```bash
mv "$LOGFILE" archive/
```

Example:

```text
Log file moved to archive/
```

---

## Commands and Tools Used

### grep

Searches for matching patterns.

```bash
grep "ERROR" logfile.log
```

### grep -i

Performs a case-insensitive search.

```bash
grep -i "failed" logfile.log
```

### grep -n

Displays line numbers.

```bash
grep -n "critical" logfile.log
```

### wc -l

Counts lines.

```bash
wc -l
```

### awk

Extracts specific fields from text.

```bash
awk -F': ' '{print $NF}'
```

### sort

Sorts output alphabetically.

```bash
sort
```

### uniq -c

Counts duplicate entries.

```bash
uniq -c
```

### head

Displays top results.

```bash
head -5
```

### mkdir -p

Creates a directory if it doesn't already exist.

```bash
mkdir -p archive
```

### mv

Moves files.

```bash
mv logfile archive/
```

---

## Sample Output

```text
Total Errors Found: 137

--- Critical Events ---
No critical events found.

--- Top 5 Error Messages ---
25 Kerberos authentication failed
20 gethostbyname error for ...
17 Software caused connection abort
8 open failed.
8 mdmpd failed

Report generated: log_report_26-06-10.txt

Log file moved to archive/
```

---

## Challenges Faced

1. Some log entries contained non-printable characters, causing grep to treat the file as binary.
2. The Linux log dataset contained lowercase error messages instead of uppercase ERROR.
3. Critical events were not present in the dataset, so additional handling was added.

---

## What I Learned

### 1. Log Analysis with grep

I learned how to search and filter log files using grep with different options such as:

```bash
grep -aEi
```

---

### 2. Data Processing Pipelines

I learned how to combine multiple Linux commands:

```bash
grep | awk | sort | uniq | head
```

to extract meaningful information from large log files.

---

### 3. Automating Administrative Tasks

I learned how to automate:

- Log analysis
- Report generation
- File archiving

using a Bash script.

---

## Conclusion

This project demonstrates how Bash scripting can be used to automate log monitoring and reporting tasks commonly performed by System Administrators and DevOps Engineers. The script validates input, analyzes logs, generates reports, and archives processed files automatically.
