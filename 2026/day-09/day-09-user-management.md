# Day 09 Challenge – Linux User & Group Management

## Objective
Today's goal was to practice Linux user and group management by:

- Creating users and passwords
- Creating groups
- Assigning users to groups
- Managing shared directories with permissions
- Testing access between users

---

# Task 1 – Create Users

## Create Users with Home Directories

```bash
sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
```

## Set Passwords

```bash
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor
```

---

## Verification

### Check `/etc/passwd`

```bash
cat /etc/passwd | grep -E 'tokyo|berlin|professor'
```

### Check Home Directories

```bash
ls /home
```

### Expected Output

```bash
tokyo
berlin
professor
```

---

# Task 2 – Create Groups

## Create Groups

```bash
sudo groupadd developers
sudo groupadd admins
```

---

## Verification

```bash
cat /etc/group | grep -E 'developers|admins'
```

### Expected Output

```bash
developers:x:1004:
admins:x:1005:
```

---

# Task 3 – Assign Users to Groups

## Assign Users

### Add tokyo to developers

```bash
sudo usermod -aG developers tokyo
```

### Add berlin to developers and admins

```bash
sudo usermod -aG developers,admins berlin
```

### Add professor to admins

```bash
sudo usermod -aG admins professor
```

---

## Verification

```bash
groups tokyo
groups berlin
groups professor
```

### Expected Output

```bash
tokyo : tokyo developers

berlin : berlin developers admins

professor : professor admins
```

---

# Task 4 – Shared Directory

## Create Shared Directory

```bash
sudo mkdir -p /opt/dev-project
```

---

## Change Group Ownership

```bash
sudo chgrp developers /opt/dev-project
```

---

## Set Permissions

```bash
sudo chmod 775 /opt/dev-project
```

---

## Permission Explanation

```text
775 = rwxrwxr-x
```

| Owner | Group | Others |
|--------|--------|---------|
| rwx    | rwx    | r-x     |

Meaning:
- Owner has full access
- Group members have full access
- Others can only read and execute

---

## Verify Permissions

```bash
ls -ld /opt/dev-project
```

### Expected Output

```bash
drwxrwxr-x
```

---

## Test File Creation

### Create File as tokyo

```bash
sudo -u tokyo touch /opt/dev-project/tokyo-file.txt
```

### Create File as berlin

```bash
sudo -u berlin touch /opt/dev-project/berlin-file.txt
```

---

## Verify Files

```bash
ls -l /opt/dev-project
```

### Expected Output

```bash
tokyo-file.txt
berlin-file.txt
```

---

# Task 5 – Team Workspace

## Create User

```bash
sudo useradd -m nairobi
```

## Set Password

```bash
sudo passwd nairobi
```

---

## Create Group

```bash
sudo groupadd project-team
```

---

## Add Users to Group

```bash
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo
```

---

## Verify Group Membership

```bash
groups nairobi
groups tokyo
```

### Expected Output

```bash
nairobi : nairobi project-team

tokyo : tokyo developers project-team
```

---

## Create Team Workspace Directory

```bash
sudo mkdir -p /opt/team-workspace
```

---

## Change Group Ownership

```bash
sudo chgrp project-team /opt/team-workspace
```

---

## Set Permissions

```bash
sudo chmod 775 /opt/team-workspace
```

---

## Verify Permissions

```bash
ls -ld /opt/team-workspace
```

---

## Test File Creation as nairobi

```bash
sudo -u nairobi touch /opt/team-workspace/test-file.txt
```

---

## Verify File Creation

```bash
ls -l /opt/team-workspace
```

### Expected Output

```bash
test-file.txt
```

---

# Users & Groups Created

## Users
- tokyo
- berlin
- professor
- nairobi

## Groups
- developers
- admins
- project-team

---

# Group Assignments

| User | Groups |
|------|---------|
| tokyo | developers, project-team |
| berlin | developers, admins |
| professor | admins |
| nairobi | project-team |

---

# Directories Created

| Directory | Group Owner | Permissions |
|------------|-------------|-------------|
| /opt/dev-project | developers | 775 |
| /opt/team-workspace | project-team | 775 |

---

# Important Commands Used

| Command | Purpose |
|----------|---------|
| useradd -m | Create user with home directory |
| passwd | Set user password |
| groupadd | Create group |
| usermod -aG | Add user to supplementary groups |
| groups | Check user group membership |
| mkdir -p | Create directory |
| chgrp | Change group ownership |
| chmod 775 | Set directory permissions |
| ls -ld | View directory permissions |
| sudo -u | Run command as another user |

---

# What I Learned

1. How Linux users and groups are managed
2. How shared directories work using group permissions
3. How DevOps teams use Linux permissions for secure collaboration

---

# Real-World DevOps Use Case

Linux user and group management is heavily used in:

- Shared deployment environments
- CI/CD pipelines
- Production Linux servers
- Team-based access control
- Application deployment permissions

Example:
- Developers may access deployment directories
- Admins may manage services and configurations
- Shared groups help teams collaborate securely

---

# Troubleshooting

## Permission Denied

Use:

```bash
sudo
```

---

## User Cannot Access Directory

Check group membership:

```bash
groups username
```

Check permissions:

```bash
ls -ld /path
```

---

# Conclusion

This challenge helped me understand:
- Linux user administration
- Group-based access control
- Shared directory permissions
- Real-world Linux security concepts used in DevOps
