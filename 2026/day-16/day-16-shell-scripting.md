# Day 16 – Shell Scripting Basics

## Objective

Today I started learning Bash scripting fundamentals. I practiced creating simple scripts using variables, user input, conditional statements, file checks, and service status checks.

---

# Task 1: Your First Script

## hello.sh

```bash
#!/bin/bash

echo "Hello, DevOps!"
```

### Make the Script Executable

```bash
chmod +x hello.sh
```

### Run the Script

```bash
./hello.sh
```

### Output

```text
Hello, DevOps!
```

### What Happens Without Shebang?

* The script may still work when executed from a Bash shell.
* The system may not know which interpreter should run the script.
* Different shells may behave differently.
* Using a shebang makes scripts portable and predictable.

---

# Task 2: Variables

## variables.sh

```bash
#!/bin/bash

NAME="Sahil"
ROLE="DevOps Engineer"

echo "Hello, I am $NAME and I am a $ROLE"
```

### Output

```text
Hello, I am Sahil and I am a DevOps Engineer
```

## Single Quotes vs Double Quotes

```bash
NAME="Sahil"

echo '$NAME'
echo "$NAME"
```

### Output

```text
$NAME
Sahil
```

### What I Learned

* Single quotes (`' '`) treat text literally.
* Double quotes (`" "`) allow variable expansion.

---

# Task 3: User Input with read

## greet.sh

```bash
#!/bin/bash

read -p "Enter your name: " NAME
read -p "Enter your favourite tool: " TOOL

echo "Hello $NAME, your favourite tool is $TOOL"
```

### Sample Output

```text
Enter your name: Sahil
Enter your favourite tool: Docker

Hello Sahil, your favourite tool is Docker
```

### What I Learned

* `read` accepts user input.
* `-p` displays a prompt message.

---

# Task 4: If-Else Conditions

## check-number.sh

```bash
#!/bin/bash

read -p "Enter the number: " NUM

if [ "$NUM" -gt 0 ]; then
    echo "Positive Number"

elif [ "$NUM" -lt 0 ]; then
    echo "Negative Number"

else
    echo "Zero"
fi
```

### Sample Output

```text
Enter the number: 5
Positive Number
```

---

## file-check.sh

```bash
#!/bin/bash

read -p "Enter the filename to search: " FILE

if [ -f "$FILE" ]; then
    echo "File exists."
else
    echo "File does not exist."
fi
```

### Sample Output

```text
Enter the filename to search: hello.sh
File exists.
```

### What I Learned

* `-f` checks whether a file exists.
* `if-else` helps make decisions based on conditions.

---

# Task 5: Server Status Check

## server-check.sh

```bash
#!/bin/bash

SERVICE="sshd"

read -p "Do you want to check the status? (y/n): " CHOICE

if [[ "${CHOICE,,}" == "y" ]]; then
    systemctl status $SERVICE
else
    echo "Skipped."
fi
```

### Sample Output

```text
Do you want to check the status? (y/n): y

● sshd.service - OpenSSH server daemon
   Active: active (running)
```

### What I Learned

* `systemctl status` checks the status of a service.
* Variables store reusable values.
* Conditional statements help automate decisions.

---

# Key Learnings

### 1. Shebang Importance

The shebang (`#!/bin/bash`) tells Linux which interpreter should execute the script.

### 2. Variables and User Input

Variables store values, and `read` allows scripts to interact with users.

### 3. Conditional Logic

Using `if`, `elif`, and `else` allows scripts to make decisions based on input and conditions.

---

# Conclusion

Today was my first step into Bash scripting. I learned how scripts are executed, how to accept user input, work with variables, use conditional statements, check file existence, and verify service status using systemctl.

These fundamentals form the foundation for Linux automation and future DevOps workflows.
