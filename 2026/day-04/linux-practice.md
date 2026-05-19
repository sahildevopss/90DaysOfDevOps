# Day 04 - Linux Practice: Processes and Services

## 📌 Objective
Today’s goal was to practice Linux fundamentals using real commands related to:
- Running processes
- System services
- Logs and troubleshooting

---

# 🔹 Process Checks

## 1. Check running processes

```bash
ps aux | head
Output
USER       PID %CPU %MEM COMMAND
root         1  0.0  0.1 /sbin/init
root       512  0.0  0.2 systemd-journald
sahil     1450  0.1  0.5 code
Observation
Displays currently running processes
Shows CPU and memory usage
---

##2. Monitor live processes
top
Observation
Monitored CPU and memory usage in real time
Observed active and sleeping processes
🔹 Service Checks
---

##3. Check SSH service status
systemctl status ssh
Output
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded
     Active: active (running)
Observation
Verified SSH service is active and running properly
4. List running services
systemctl list-units --type=service --state=running
Observation
Listed active services currently running on the system
🔹 Log Checks
5. View SSH service logs
journalctl -u ssh
Output
May 19 10:10:07 Sahil systemd[1]: Starting ssh.service - OpenBSD Secure Shell server...
May 19 10:10:07 Sahil sshd[2922]: Server listening on 0.0.0.0 port 22.
May 19 10:10:07 Sahil sshd[2922]: Server listening on :: port 22.
May 19 10:10:07 Sahil systemd[1]: Started ssh.service - OpenBSD Secure Shell server.
Observation
Checked SSH startup logs
Confirmed service started successfully
6. View recent system logs
tail -n 10 /var/log/syslog
Observation
Checked latest system events and warnings
Observed system background activities
🔹 Mini Troubleshooting Workflow
Scenario

SSH service troubleshooting.

Step 1: Check service status
systemctl status ssh
Step 2: Restart SSH service
sudo systemctl restart ssh
Step 3: Check recent logs
journalctl -u ssh -n 10
Step 4: Verify service status
systemctl is-active ssh
Result

/bin/bash: line 1: :wq: command not found

📚 Key Learnings
Practiced Linux process monitoring
Learned service management using systemctl
Explored logs using journalctl and tail
Understood a basic troubleshooting workflow
