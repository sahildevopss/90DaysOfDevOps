# Day 11 – File Ownership Challenge (chown & chgrp)

## Objective

Learn and practice Linux file ownership management using:

- `chown`
- `chgrp`
- Recursive ownership changes
- User and group management

---

# Task 1 – Understanding Ownership

## Step 1: Check Files in Home Directory

Run:

```bash
ls -l
```

### Example Output

```bash
-rw-r--r-- 1 sahil sahil 0 May 28 notes.txt
drwxr-xr-x 2 sahil sahil 4096 May 28 projects
```

---

## Understanding the Output

Format:

```bash
-rw-r--r-- 1 owner group size date filename
```

| Section | Meaning |
|---|---|
| owner | User who owns the file |
| group | Group associated with the file |

---

## Difference Between Owner and Group

### Owner
The owner is the main user who controls the file.

### Group
The group allows multiple users to access the file based on permissions.

Example:

```bash
tokyo:vault-team
```

- `tokyo` = owner
- `vault-team` = group

This is useful in DevOps teams where multiple users need shared access.

---

# Task 2 – Basic chown Operations

## Step 1: Create File

```bash
touch devops-file.txt
```

---

## Step 2: Check Current Ownership

```bash
ls -l devops-file.txt
```

---

## Step 3: Create Users

```bash
sudo useradd tokyo
sudo useradd berlin
```

---

## Step 4: Change Owner to tokyo

```bash
sudo chown tokyo devops-file.txt
```

---

## Step 5: Verify Ownership

```bash
ls -l devops-file.txt
```

Expected:

```bash
-rw-r--r-- 1 tokyo sahil 0 May 28 devops-file.txt
```

---

## Step 6: Change Owner to berlin

```bash
sudo chown berlin devops-file.txt
```

---

## Step 7: Verify Again

```bash
ls -l devops-file.txt
```

Expected

```bash
-rw-r--r-- 1 berlin sahil 0 May 28 devops-file.txt
```

---

# Task 3 – Basic chgrp Operations

## Step 1: Create File

```bash
touch team-notes.txt
```

---

## Step 2: Check Current Group

```bash
ls -l team-notes.txt
```

---

## Step 3: Create Group

```bash
sudo groupadd heist-team
```

---

## Step 4: Change File Group

```bash
sudo chgrp heist-team team-notes.txt
```

---

## Step 5: Verify Group Change

```bash
ls -l team-notes.txt
```

Expected:

```bash
-rw-r--r-- 1 sahil heist-team 0 May 28 team-notes.txt
```

---

# Task 4 – Combined Owner & Group Change

## Step 1: Create File

```bash
touch project-config.yaml
```

---

## Step 2: Create User professor

```bash
sudo useradd professor
```

---

## Step 3: Change Owner and Group Together

```bash
sudo chown professor:heist-team project-config.yaml
```

---

## Step 4: Verify

```bash
ls -l project-config.yaml
```

Expected:

```bash
-rw-r--r-- 1 professor heist-team 0 May 28 project-config.yaml
```

---

# Change Ownership of Directory

## Step 1: Create Directory

```bash
mkdir app-logs
```

---

## Step 2: Change Ownership

```bash
sudo chown berlin:heist-team app-logs
```

---

## Step 3: Verify

```bash
ls -ld app-logs
```

Expected:

```bash
drwxr-xr-x 2 berlin heist-team 4096 May 28 app-logs
```

---

# Task 5 – Recursive Ownership

## Step 1: Create Directory Structure

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans
```

---

## Step 2: Create Files

```bash
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```

---

## Step 3: Create Group planners

```bash
sudo groupadd planners
```

---

## Step 4: Change Ownership Recursively

```bash
sudo chown -R professor:planners heist-project/
```

### Explanation

| Option | Meaning |
|---|---|
| `-R` | Recursive ownership change |
| `professor` | New owner |
| `planners` | New group |

---

## Step 5: Verify Recursive Changes

```bash
ls -lR heist-project/
```

Expected:

```bash
heist-project/plans:
-rw-r--r-- 1 professor planners 0 May 28 strategy.conf

heist-project/vault:
-rw-r--r-- 1 professor planners 0 May 28 gold.txt
```

---

# Task 6 – Practice Challenge

## Step 1: Create Users

```bash
sudo useradd tokyo
sudo useradd berlin
sudo useradd nairobi
```

---

## Step 2: Create Groups

```bash
sudo groupadd vault-team
sudo groupadd tech-team
```

---

## Step 3: Create Directory

```bash
mkdir bank-heist
```

---

## Step 4: Create Files

```bash
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

---

# Set Ownerships

## access-codes.txt

```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
```

---

## blueprints.pdf

```bash
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```

---

## escape-plan.txt

```bash
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

---

## Verify Final Output

```bash
ls -l bank-heist/
```

Expected:

```bash
-rw-r--r-- 1 tokyo   vault-team 0 May 28 access-codes.txt
-rw-r--r-- 1 berlin  tech-team  0 May 28 blueprints.pdf
-rw-r--r-- 1 nairobi vault-team 0 May 28 escape-plan.txt
```

---

# Key Commands Reference

## View Ownership

```bash
ls -l filename
```

---

## Change Owner

```bash
sudo chown username filename
```

---

## Change Group

```bash
sudo chgrp groupname filename
```

---

## Change Owner and Group Together

```bash
sudo chown owner:group filename
```

---

## Recursive Ownership Change

```bash
sudo chown -R owner:group directory/
```

---

## Change Only Group Using chown

```bash
sudo chown :groupname filename
```

---

# Files & Directories Created

## Files

- devops-file.txt
- team-notes.txt
- project-config.yaml
- heist-project/vault/gold.txt
- heist-project/plans/strategy.conf
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt

---

## Directories

- app-logs/
- heist-project/
- heist-project/vault/
- heist-project/plans/
- bank-heist/

---

# Ownership Changes Summary

| File/Directory | Final Ownership |
|---|---|
| devops-file.txt | berlin:sahil |
| team-notes.txt | sahil:heist-team |
| project-config.yaml | professor:heist-team |
| app-logs/ | berlin:heist-team |
| heist-project/ | professor:planners |
| access-codes.txt | tokyo:vault-team |
| blueprints.pdf | berlin:tech-team |
| escape-plan.txt | nairobi:vault-team |

---

# What I Learned

## 1. File Ownership Structure

Linux files have:
- Owner
- Group

---

## 2. chown Command

Used to:
- Change owner
- Change owner and group together

Example:

```bash
sudo chown owner:group file
```

---

## 3. Recursive Ownership

Using `-R` changes ownership for:
- directories
- subdirectories
- all files inside

Very useful for:
- deployments
- logs
- applications
- CI/CD artifacts

---

# Troubleshooting

## Permission Denied

Use `sudo`:

```bash
sudo chown username filename
```

---

## Group Does Not Exist

Create it first:

```bash
sudo groupadd groupname
```

---

## User Does Not Exist

Create it first:

```bash
sudo useradd username
```

---

# Why File Ownership Matters in DevOps

Proper ownership is important for:

- Application deployments
- Shared directories
- Docker containers
- Kubernetes volumes
- CI/CD pipelines
- Log management

Incorrect ownership can cause:
- Permission denied errors
- Application failures
- Security issues

---

# Conclusion

Today I learned how Linux ownership works and practiced:

- `chown`
- `chgrp`
- Recursive ownership management
- User and group handling

This is a critical Linux and DevOps skill for managing secure systems.
