# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Objective

In this exercise, I practiced:

* Writing `for` and `while` loops
* Using command-line arguments (`$1`, `$#`, `$@`, `$0`)
* Automating package installation with Bash scripts
* Implementing basic error handling
* Checking for root privileges before executing administrative tasks

---

# Task 1: For Loop

## Script: `for_loop.sh`

```bash
#!/bin/bash

for fruit in Apple Banana Mango Orange Grapes
do
    echo "$fruit"
done
```

### Output

```text
Apple
Banana
Mango
Orange
Grapes
```

---

## Script: `count.sh`

```bash
#!/bin/bash

for num in {1..10}
do
    echo "$num"
done
```

### Output

```text
1
2
3
4
5
6
7
8
9
10
```

---

# Task 2: While Loop

## Script: `countdown.sh`

```bash
#!/bin/bash

read -p "Enter a number: " num

while [ "$num" -ge 0 ]
do
    echo "$num"
    num=$((num - 1))
done

echo "Done!"
```

### Output

```text
Enter a number: 5
5
4
3
2
1
0
Done!
```

---

# Task 3: Command-Line Arguments

## Script: `greet.sh`

```bash
#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage: ./greet.sh <name>"
else
    echo "Hello, $1!"
fi
```

### Output

#### With Argument

```bash
./greet.sh Sahil
```

```text
Hello, Sahil!
```

#### Without Argument

```bash
./greet.sh
```

```text
Usage: ./greet.sh <name>
```

---

## Script: `args_demo.sh`

```bash
#!/bin/bash

echo "Total arguments: $#"
echo "All arguments: $@"
echo "Script name: $0"
```

### Output

```bash
./args_demo.sh Linux AWS Docker
```

```text
Total arguments: 3
All arguments: Linux AWS Docker
Script name: ./args_demo.sh
```

---

# Task 4: Install Packages via Script

## Script: `install_packages.sh`

```bash
#!/bin/bash

if [ "$EUID" -ne 0 ]
then
    echo "Run this script as root."
    exit 1
fi

packages="nginx curl wget"

for package in $packages
do
    if dpkg -s "$package" >/dev/null 2>&1
    then
        echo "$package is already installed."
    else
        echo "Installing $package..."
        apt update -y
        apt install -y "$package"
        echo "$package installed successfully."
    fi
done
```

### Run the Script

```bash
sudo ./install_packages.sh
```

### Example Output

```text
nginx is already installed.
curl is already installed.
Installing wget...
wget installed successfully.
```

---

# Task 5: Error Handling

## Script: `safe_script.sh`

```bash
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || {
    echo "Failed to enter directory"
    exit 1
}

touch sample.txt || {
    echo "Failed to create file"
    exit 1
}

echo "Script completed successfully"
```

### Output

```text
Script completed successfully
```

Or if the directory already exists:

```text
Directory already exists
Script completed successfully
```

---

# Commands Used

Make scripts executable:

```bash
chmod +x *.sh
```

Run scripts:

```bash
./for_loop.sh
./count.sh
./countdown.sh
./greet.sh Sahil
./args_demo.sh Linux AWS Docker
sudo ./install_packages.sh
./safe_script.sh
```

---

# Key Learnings

## 1. For and While Loops

* `for` loops are useful when iterating through a known list of items.
* `while` loops continue executing until a specified condition becomes false.
* Loops help automate repetitive tasks efficiently.

## 2. Command-Line Arguments

* `$1` represents the first argument passed to a script.
* `$#` returns the total number of arguments.
* `$@` returns all arguments passed to the script.
* `$0` displays the script name.

## 3. Error Handling and Script Safety

* `set -e` stops script execution immediately when a command fails.
* The `||` operator allows custom error handling.
* Checking for root privileges prevents permission-related issues.
* Proper error handling makes scripts more reliable and production-ready.

---

# Conclusion

Day 17 focused on building more practical Bash scripting skills. By combining loops, command-line arguments, package management automation, and error handling, I gained a better understanding of how shell scripts can simplify repetitive system administration tasks and improve operational efficiency.

