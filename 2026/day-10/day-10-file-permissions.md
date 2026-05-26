# Day 10 – File Permissions & File Operations Challenge

## Objective

Today's goal was to practice Linux file operations and understand file permissions in Linux using commands like `touch`, `cat`, `vim`, and `chmod`.

---

# Task 1 – Create Files

## Create Empty File

```bash
touch devops.txt
```

### Verify File Creation

```bash
ls -l devops.txt
```

### Example Output

```bash
-rw-rw-r-- 1 sahil sahil 0 May 26 10:00 devops.txt
```

---

## Create notes.txt with Content

Using `echo`:

```bash
echo "Linux permissions are important in DevOps." > notes.txt
```

OR using `cat`:

```bash
cat > notes.txt
Linux permissions are important in DevOps.
```

Press:

```bash
CTRL + D
```

to save the file.

### Verify File Content

```bash
cat notes.txt
```

### Output

```bash
Linux permissions are important in DevOps.
```

---

## Create script.sh using vim

```bash
vim script.sh
```

Press:

```bash
i
```

to enter insert mode and add:

```bash
echo "Hello DevOps"
```

Save and exit:

```bash
ESC :wq
```

---

## Verify All Files

```bash
ls -l
```

### Example Output

```bash
-rw-rw-r-- 1 sahil sahil  0 May 26 10:00 devops.txt
-rw-rw-r-- 1 sahil sahil 40 May 26 10:05 notes.txt
-rw-rw-r-- 1 sahil sahil 21 May 26 10:07 script.sh
```

---

# Task 2 – Read Files

## Read notes.txt

```bash
cat notes.txt
```

### Output

```bash
Linux permissions are important in DevOps.
```

---

## Open script.sh in Read-Only Mode

```bash
vim -R script.sh
```

Explanation:

- `-R` opens the file in read-only mode
- Prevents accidental modifications

---

## Display First 5 Lines of /etc/passwd

```bash
head -n 5 /etc/passwd
```

### Example Output

```bash
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
```

---

## Display Last 5 Lines of /etc/passwd

```bash
tail -n 5 /etc/passwd
```

### Example Output

```bash
systemd-timesync:x:997:997:systemd Time Synchronization:/:/usr/sbin/nologin
messagebus:x:100:102::/nonexistent:/usr/sbin/nologin
pollinate:x:998:998::/var/cache/pollinate:/bin/false
sshd:x:101:65534::/run/sshd:/usr/sbin/nologin
sahil:x:1000:1000:sahil:/home/sahil:/bin/bash
```

---

# Task 3 – Understand Permissions

## Linux Permission Format

```text
rwxrwxrwx
```

Split into:

```text
owner | group | others
```

---

## Permission Meaning

| Symbol | Meaning | Value |
|---|---|---|
| r | Read | 4 |
| w | Write | 2 |
| x | Execute | 1 |

---

## Numeric Permission Examples

| Number | Permission |
|---|---|
| 7 | rwx |
| 6 | rw- |
| 5 | r-x |
| 4 | r-- |

---

## Check Current Permissions

```bash
ls -l devops.txt notes.txt script.sh
```

### Example Output

```bash
-rw-rw-r-- 1 sahil sahil  0 May 26 10:00 devops.txt
-rw-rw-r-- 1 sahil sahil 40 May 26 10:05 notes.txt
-rw-rw-r-- 1 sahil sahil 21 May 26 10:07 script.sh
```

---

## Understanding Current Permissions

### devops.txt

| User Type | Permission |
|---|---|
| Owner | Read + Write |
| Group | Read + Write |
| Others | Read Only |

---

### notes.txt

| User Type | Permission |
|---|---|
| Owner | Read + Write |
| Group | Read + Write |
| Others | Read Only |

---

### script.sh

| User Type | Permission |
|---|---|
| Owner | Read + Write |
| Group | Read + Write |
| Others | Read Only |

Currently no one can execute the script because execute permission (`x`) is missing.

---

# Task 4 – Modify Permissions

## Make script.sh Executable

```bash
chmod +x script.sh
```

### Verify

```bash
ls -l script.sh
```

### Output

```bash
-rwxrwxr-x 1 sahil sahil 21 May 26 10:07 script.sh
```

---

## Run the Script

```bash
./script.sh
```

### Output

```bash
Hello DevOps
```

---

## Set devops.txt to Read-Only

Remove write permission for everyone:

```bash
chmod a-w devops.txt
```

### Verify

```bash
ls -l devops.txt
```

### Output

```bash
-r--r--r-- 1 sahil sahil 0 May 26 10:00 devops.txt
```

---

## Set notes.txt Permission to 640

```bash
chmod 640 notes.txt
```

### Verify

```bash
ls -l notes.txt
```

### Output

```bash
-rw-r----- 1 sahil sahil 40 May 26 10:05 notes.txt
```

---

## Meaning of 640

| User Type | Permission |
|---|---|
| Owner | Read + Write |
| Group | Read Only |
| Others | No Access |

---

## Create project Directory with Permission 755

```bash
mkdir project
```

```bash
chmod 755 project
```

### Verify

```bash
ls -ld project
```

### Output

```bash
drwxr-xr-x 2 sahil sahil 4096 May 26 10:20 project
```

---

## Meaning of 755

| User Type | Permission |
|---|---|
| Owner | Read + Write + Execute |
| Group | Read + Execute |
| Others | Read + Execute |

---

# Task 5 – Test Permissions

## Try Writing to Read-Only File

```bash
echo "test" >> devops.txt
```

### Output

```bash
bash: devops.txt: Permission denied
```

### Reason

Write permission was removed from the file.

---

## Try Executing File Without Execute Permission

Remove execute permission:

```bash
chmod -x script.sh
```

Try running the script again:

```bash
./script.sh
```

### Output

```bash
bash: ./script.sh: Permission denied
```

### Reason

Execute permission (`x`) is missing.

---

# Commands Used

```bash
touch devops.txt

echo "Linux permissions are important in DevOps." > notes.txt

cat notes.txt

vim script.sh
Strong command-line skills are a core requirement for DevOps engineers.

vim -R script.sh

head -n 5 /etc/passwd

tail -n 5 /etc/passwd

ls -l

chmod +x script.sh

./script.sh

chmod a-w devops.txt

chmod 640 notes.txt

mkdir project

chmod 755 project

ls -ld project

chmod -x script.sh
```

---

# What I Learned

1. Linux permissions control file and directory access.
2. `chmod` is used to modify permissions.
3. Execute permission is required to run shell scripts.
4. Numeric permissions like `755` and `640` simplify permission management.
5. Directories and files handle permissions differently.

---

# Conclusion

This challenge helped me understand:

- Linux file permissions
- Read, write, execute access
- File creation and reading commands
- Secure permission management
- Basic shell script execution

Understanding Linux permissions is one of the most important skills for a DevOps Engineer.

---
