# Day 07 – Linux File System Hierarchy & Scenario-Based Practice

---

# 📁 Part 1 – Linux File System Hierarchy

---

# `/` (Root Directory)

## Purpose
The root directory is the starting point of the entire Linux file system.  
All files, directories, and mounted devices begin from `/`.

## Command Used

```bash
ls -l /
```

## Example Observations

```text
bin
etc
home
usr
var
```

## I would use this when...
I need to navigate the Linux system from the top-level directory or understand the overall filesystem structure.

---

# `/home`

## Purpose
Contains personal directories for normal users.

Each user gets a separate folder to store files, downloads, scripts, and documents.

## Command Used

```bash
ls -l /home
```

## Example Observations

```text
user1
developer
ubuntu
```

## I would use this when...
I need to access a user's files, scripts, or project directories.

---

# `/root`

## Purpose
This is the home directory of the root (administrator) user.

It is separate from normal user directories for security purposes.

## Command Used

```bash
ls -l /root
```

## Example Observations

```text
scripts
backup.sh
```

## I would use this when...
I am logged in as root and need administrator-level scripts or configuration files.

---

# `/etc`

## Purpose
Stores system-wide configuration files.

Most Linux services and applications keep their configuration here.

## Command Used

```bash
ls -l /etc
```

## Example Observations

```text
hostname
hosts
passwd
ssh
```

## I would use this when...
I need to modify application settings, system configurations, or network settings.

---

# `/var/log`

## Purpose
Contains system and application log files.

This is one of the most important directories for DevOps troubleshooting.

## Command Used

```bash
ls -l /var/log
```

## Example Observations

```text
syslog
auth.log
journal
```

## I would use this when...
I need to troubleshoot application failures, authentication problems, or system issues.

---

# `/tmp`

## Purpose
Stores temporary files created by applications and users.

Files here may be deleted automatically after reboot.

## Command Used

```bash
ls -l /tmp
```

## Example Observations

```text
temp-file.txt
systemd-private
```

## I would use this when...
I need temporary storage during testing, scripting, or troubleshooting.

---

# `/bin`

## Purpose
Contains essential Linux command binaries required for basic system operation.

## Command Used

```bash
ls -l /bin
```

## Example Observations

```text
cat
ls
cp
mv
```

## I would use this when...
I need access to basic Linux commands used for daily administration.

---

# `/usr/bin`

## Purpose
Contains user-level command binaries and additional applications.

Most commonly used commands are stored here.

## Command Used

```bash
ls -l /usr/bin
```

## Example Observations

```text
python3
git
vim
nano
```

## I would use this when...
I need developer tools, editors, or installed applications.

---

# `/opt`

## Purpose
Used for optional or third-party software installations.

Applications installed manually are often stored here.

## Command Used

```bash
ls -l /opt
```

## Example Observations

```text
google
custom-app
```

## I would use this when...
I install custom software or enterprise applications outside default package management.

---

# 🛠 Hands-On Practice

---

## Find Largest Log Files

### Command

```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
```

### Why This Command?
- `du -sh` checks directory/file size
- `sort -h` sorts sizes properly
- `tail -5` shows largest files
- `2>/dev/null` hides permission errors

### What I Observed
I could identify which logs consume the most disk space.

This is useful when troubleshooting disk usage issues.

---

## View System Hostname

### Command

```bash
cat /etc/hostname
```

### Why This Command?
Reads the hostname configuration file.

### What I Observed
The file stores the system hostname used for network identification.

---

## Check Home Directory

### Command

```bash
ls -la ~
```

### Why This Command?
Lists all files including hidden files in the current user’s home directory.

### What I Observed
I saw configuration files like:
- `.bashrc`
- `.profile`
- `.ssh`

---

# 🔥 Part 2 – Scenario-Based Practice

---

# Scenario 1 – Service Not Starting

## Problem
A service called `myapp` failed after reboot.

---

## Step 1: Check Service Status

```bash
systemctl status myapp
```

### Why?
This shows whether the service is:
- active
- failed
- stopped

---

## Step 2: Check Service Logs

```bash
journalctl -u myapp -n 50
```

### Why?
This displays the latest 50 log lines for the service.

Useful for identifying:
- startup errors
- missing files
- permission issues

---

## Step 3: Check if Service Starts on Boot

```bash
systemctl is-enabled myapp
```

### Why?
Checks whether the service automatically starts after reboot.

---

## Step 4: List Available Services

```bash
systemctl list-units --type=service
```

### Why?
Helps verify whether the service exists on the system.

---

## What I Learned
Always start troubleshooting by checking service status first, then move to logs and boot configuration.

---

# Scenario 2 – High CPU Usage

## Problem
The application server is slow.

---

## Step 1: Monitor Live CPU Usage

```bash
top
```

### Why?
Shows real-time CPU and memory usage.

---

## Step 2: Use Enhanced Monitoring Tool

```bash
htop
```

### Why?
Provides an easier and more interactive process view.

---

## Step 3: List Top CPU Processes

```bash
ps aux --sort=-%cpu | head -10
```

### Why?
Displays processes sorted by highest CPU usage.

Useful for identifying problematic PIDs.

---

## What I Learned
Always identify which process consumes resources before restarting services or killing processes.

---

# Scenario 3 – Finding Service Logs

## Problem
A developer asks for Docker service logs.

---

## Step 1: Check Service Status

```bash
systemctl status docker
```

### Why?
Confirms whether the service is running properly.

---

## Step 2: View Recent Logs

```bash
journalctl -u docker -n 50
```

### Why?
Shows the latest 50 log entries for Docker.

---

## Step 3: Follow Logs Live

```bash
journalctl -u docker -f
```

### Why?
Streams logs in real-time similar to `tail -f`.

Useful during deployments or debugging.

---

## What I Learned
systemd services store logs in journald, and `journalctl` is essential for troubleshooting.

---

# Scenario 4 – File Permission Issue

## Problem
A script called `backup.sh` gives:

```text
Permission denied
```

---

## Step 1: Check Current Permissions

```bash
ls -l /home/user/backup.sh
```

### Example Output

```text
-rw-r--r--
```

### Why?
The file lacks execute (`x`) permission.

---

## Step 2: Add Execute Permission

```bash
chmod +x /home/user/backup.sh
```

### Why?
Adds executable permission to the script.

---

## Step 3: Verify Permissions

```bash
ls -l /home/user/backup.sh
```

### Example Output

```text
-rwxr-xr-x
```

### Why?
Confirms execute permission was added successfully.

---

## Step 4: Run the Script

```bash
./backup.sh
```

### Why?
Tests whether the issue is resolved.

---

## What I Learned
Linux scripts require execute permissions (`x`) before they can run.

---

# 🚀 Why This Matters for DevOps

Understanding the Linux file system helps with:
- Finding logs quickly
- Managing configurations
- Troubleshooting deployments
- Writing automation scripts

Scenario-based troubleshooting prepares engineers for:
- Production incidents
- DevOps interviews
- On-call debugging

---

