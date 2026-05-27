# Day 12 – Breather & Revision (Days 01–11)

## Objective

Today was focused on revising and reinforcing everything learned from Days 01–11 of the #90DaysOfDevOps challenge.

The goal was not to learn new concepts, but to strengthen fundamentals through quick practice and self-checks.

---

# Section 1 – Revisiting My Learning Plan (Day 01)

## Initial Goal

My original goal was to:

- Build strong Linux fundamentals
- Become comfortable with command line usage
- Learn troubleshooting and system administration basics
- Prepare for DevOps tools and cloud concepts

---

## What I Observed After 11 Days

### Improvements

- I am now more comfortable navigating Linux systems
- I can troubleshoot basic issues independently
- File permissions and ownership make much more sense now
- I understand users, groups, and Linux processes better
- I use terminal commands much faster than before

### Areas I Still Need to Improve

- Faster troubleshooting under pressure
- More practice with journalctl and system logs
- Better understanding of networking commands

---

# Section 2 – Process & Service Revision

## Command 1 – Check Running Processes

```bash
ps aux --sort=-%cpu | head
```

### Observation

- Displays top CPU-consuming processes
- Helpful during troubleshooting high CPU usage
- Learned how sorting works with process monitoring

---

## Command 2 – Check Service Status

```bash
systemctl status ssh
```

### Observation

- Verified whether SSH service is active
- Observed service logs and uptime details
- Useful for checking service failures quickly

---

## Command 3 – Check Logs Using journalctl

```bash
journalctl -u ssh --since "1 hour ago"
```

### Observation

- Displays recent SSH logs
- Useful for identifying login attempts and service errors
- Helps during debugging and monitoring

---

# Section 3 – File Skills Practice

## Task 1 – Append Text to File

```bash
echo "DevOps Revision Practice" >> revision.txt
```

### Result

- Successfully appended text without overwriting existing content

---

## Task 2 – Change File Permissions

```bash
chmod 644 revision.txt
```

### Result

- Owner received read/write permissions
- Group and others received read-only access

---

## Task 3 – Create Directories

```bash
mkdir -p practice/day12/test
```

### Result

- Created nested directories in a single command
- Understood why `-p` is useful

---

## Task 4 – Copy Files

```bash
cp revision.txt backup_revision.txt
```

### Result

- Successfully created backup copy of file

---

## Task 5 – View Detailed File Permissions

```bash
ls -l
```

### Result

- Verified ownership and permission changes

---

# Section 4 – Cheat Sheet Refresh (Top 5 Commands)

## 1. ls -l

Used to check file permissions, ownership, and file details quickly.

```bash
ls -l
```

---

## 2. ps aux

Used for checking running processes and resource usage.

```bash
ps aux
```

---

## 3. journalctl

Used for viewing system and service logs.

```bash
journalctl -xe
```

---

## 4. chmod

Used to change file permissions securely.

```bash
chmod 755 script.sh
```

---

## 5. grep

Used to search specific text inside files or command outputs.

```bash
grep "error" logfile.txt
```

---

# Section 5 – User & Group Sanity Check

## Create a Test User

```bash
sudo useradd testuser
```

---

## Verify User

```bash
id testuser
```

### Observation

- Verified UID, GID, and assigned groups successfully

---

## Change Ownership of File

```bash
sudo chown testuser:testuser revision.txt
```

---

## Verify Ownership

```bash
ls -l revision.txt
```

### Observation

- Ownership changed successfully to testuser

---

# Mini Self-Check

## 1. Which 3 Commands Save Me the Most Time Right Now?

### ps aux

Helps quickly identify problematic processes and resource usage.

### ls -l

Useful for checking permissions and ownership immediately.

### journalctl

Very powerful for checking logs and troubleshooting services.

---

## 2. How Do I Check If a Service Is Healthy?

### Commands I Would Run First

```bash
systemctl status <service-name>
```

```bash
journalctl -u <service-name> --since "30 minutes ago"
```

```bash
ps aux | grep <service-name>
```

### Why?

- Checks service state
- Reviews recent logs
- Verifies process existence

---

## 3. How Do I Safely Change Ownership & Permissions?

### Example Command

```bash
sudo chown sahil:sahil revision.txt
chmod 644 revision.txt
```

### Why This Is Safe

- Ownership changes only for intended file
- Permissions allow editing only for owner
- Prevents unauthorized modifications

---

## 4. What Will I Focus On Improving In The Next 3 Days?

- Faster Linux troubleshooting
- Better understanding of networking basics
- More practice with permissions and logs
- Becoming faster with terminal navigation

---

# Key Takeaways From Days 01–11

- Linux fundamentals are the backbone of DevOps
- Understanding permissions prevents many mistakes
- Logs are critical during troubleshooting
- Small daily practice creates confidence
- Consistency matters more than speed

---

# Commands Revised Today

```bash
ps aux --sort=-%cpu
systemctl status ssh
journalctl -u ssh
chmod 644 file.txt
chown user:user file.txt
mkdir -p test/demo
cp source.txt backup.txt
ls -l
id username
grep "error" logfile.txt
```

---

# Final Thoughts

This revision day helped reinforce the Linux basics learned over the last 11 days.

Instead of learning new topics, today focused on strengthening confidence with commands, permissions, troubleshooting, users, and logs.

The fundamentals now feel much more practical and less intimidating compared to Day 01.

---

