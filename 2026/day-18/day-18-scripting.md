# Day 18 – Shell Scripting: Functions & Intermediate Concepts

## Objective

Today I learned how to write cleaner and more reusable shell scripts using functions, strict mode, local variables, and modular script design.

---

# Task 1: Basic Functions

## File: functions.sh

```bash
#!/bin/bash

greet() {
    echo "Hello, $1!"
}

add() {
    echo $(($1 + $2))
}

greet "Sahil"

echo "Sum: $(add 10 20)"
```

## Output

```text
Hello, Sahil!
Sum: 30
```

## Explanation

* `greet()` accepts a name as an argument and prints a greeting.
* `add()` accepts two numbers and prints their sum.
* Functions help avoid repeating code and improve readability.

---

# Task 2: Functions with Return Values

## File: disk_check.sh

```bash
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo
    echo "Memory Usage:"
    free -h
}

echo "===== System Resource Check ====="

check_disk
check_memory
```

## Output

```text
===== System Resource Check =====

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   20G   28G  42% /

Memory Usage:
               total        used        free
Mem:           7.6Gi       2.1Gi       4.8Gi
```

## Explanation

* `df -h /` displays disk usage for the root filesystem.
* `free -h` displays memory usage in human-readable format.
* Functions make it easier to organize scripts.

---

# Task 3: Strict Mode – set -euo pipefail

## File: strict_demo.sh

```bash
#!/bin/bash

set -euo pipefail

echo "Starting Script"

echo "$MY_VAR"

false

echo "This line will never execute"
```

## Output

```text
Starting Script
./strict_demo.sh: line 7: MY_VAR: unbound variable
```

---

## Demonstrating pipefail

```bash
#!/bin/bash

set -euo pipefail

grep "hello" missingfile.txt | wc -l

echo "Script Completed"
```

## Output

```text
grep: missingfile.txt: No such file or directory
Script exits immediately
```

## What does each flag do?

### set -e

Exit immediately when a command returns a non-zero exit code.

Example:

```bash
false
echo "Will not execute"
```

---

### set -u

Treat undefined variables as errors.

Example:

```bash
echo "$USERNAME"
```

If USERNAME is not defined, the script exits.

---

### set -o pipefail

Makes a pipeline fail if any command within the pipeline fails.

Example:

```bash
grep hello file.txt | wc -l
```

Without pipefail:

* `wc` succeeds.
* Pipeline appears successful.

With pipefail:

* `grep` fails.
* Entire pipeline fails.

---

# Task 4: Local Variables

## File: local_demo.sh

```bash
#!/bin/bash

demo_local() {
    local NAME="Sahil"
    echo "Inside function: $NAME"
}

demo_global() {
    CITY="Pune"
    echo "Inside function: $CITY"
}

demo_local

echo "Outside function local variable: ${NAME:-Not Available}"

demo_global

echo "Outside function global variable: $CITY"
```

## Output

```text
Inside function: Sahil
Outside function local variable: Not Available

Inside function: Pune
Outside function global variable: Pune
```

## Explanation

* Variables declared using `local` only exist inside the function.
* Regular variables remain available after the function finishes.
* Using local variables prevents accidental overwriting of global variables.

---

# Task 5: System Information Reporter

## File: system_info.sh

```bash
#!/bin/bash

set -euo pipefail

print_header() {
    echo
    echo "======================================="
    echo "$1"
    echo "======================================="
}

system_info() {
    hostnamectl | head -10
}

uptime_info() {
    command uptime
}

disk_usage() {
    df -h | sort -hrk5 | head -5
}

mem_usage() {
    free -h
}

cpu_processes() {
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
    print_header "HOSTNAME & OS INFO"
    system_info

    print_header "UPTIME"
    uptime_info

    print_header "TOP 5 DISK USAGE"
    disk_usage

    print_header "MEMORY USAGE"
    mem_usage

    print_header "TOP CPU PROCESSES"
    cpu_processes
}

main
```

## Sample Output

```text
=======================================
HOSTNAME & OS INFO
=======================================

Operating System: Ubuntu 24.04 LTS
Kernel: Linux 6.x

=======================================
UPTIME
=======================================

16:15:40 up 3 days, 5 hours

=======================================
TOP 5 DISK USAGE
=======================================

Filesystem      Size  Used Avail Use%
/dev/sda1        50G   20G   28G  42%

=======================================
MEMORY USAGE
=======================================

total used free shared buff/cache available

=======================================
TOP CPU PROCESSES
=======================================

PID CMD %MEM %CPU
```

## Explanation

The script uses separate functions for:

* System information
* Uptime
* Disk usage
* Memory usage
* CPU usage

A `main()` function controls the flow of execution, making the script easier to maintain and extend.

---

# Key Learnings

## 1. Functions Improve Reusability

Functions allow code to be reused multiple times without duplication.

## 2. Strict Mode Prevents Hidden Errors

Using:

```bash
set -euo pipefail
```

helps catch failures early and makes scripts more reliable.

## 3. Local Variables Keep Functions Isolated

Using `local` prevents variables from leaking outside a function and causing unexpected behavior.

---

# Conclusion

Day 18 introduced important shell scripting practices used in real-world automation and DevOps environments. Functions, strict mode, and local variables make scripts cleaner, safer, and easier to maintain.

