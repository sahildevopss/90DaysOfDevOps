````markdown
# Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic | Key Syntax | Example |
|---------|------------|----------|
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For Loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

# 1. Basics

## Shebang

Defines which interpreter should execute the script.

```bash
#!/bin/bash
````

### Why it matters

* Ensures the script runs with Bash.
* Makes scripts portable across systems.

---

## Running a Script

Make executable:

```bash
chmod +x script.sh
```

Run directly:

```bash
./script.sh
```

Run with Bash:

```bash
bash script.sh
```

---

## Comments

Single-line comment:

```bash
# This is a comment
```

Inline comment:

```bash
echo "Hello" # Print greeting
```

---

## Variables

Declare:

```bash
NAME="Sahil"
```

Use:

```bash
echo $NAME
```

Double quotes (variable expands):

```bash
echo "$NAME"
```

Single quotes (literal text):

```bash
echo '$NAME'
```

---

## Reading User Input

```bash
read -p "Enter your name: " NAME
echo "Hello $NAME"
```

---

## Command-Line Arguments

```bash
echo $0
echo $1
echo $2
echo $#
echo $@
echo $?
```

Example:

```bash
./script.sh DevOps Linux
```

| Variable | Description                 |
| -------- | --------------------------- |
| `$0`     | Script name                 |
| `$1`     | First argument              |
| `$2`     | Second argument             |
| `$#`     | Number of arguments         |
| `$@`     | All arguments               |
| `$?`     | Exit status of last command |

---

# 2. Operators and Conditionals

## String Comparisons

```bash
[ "$A" = "$B" ]
[ "$A" != "$B" ]
[ -z "$A" ]
[ -n "$A" ]
```

| Operator | Meaning          |
| -------- | ---------------- |
| `=`      | Equal            |
| `!=`     | Not equal        |
| `-z`     | Empty string     |
| `-n`     | Non-empty string |

---

## Integer Comparisons

```bash
[ "$A" -eq "$B" ]
[ "$A" -ne "$B" ]
[ "$A" -lt "$B" ]
[ "$A" -gt "$B" ]
[ "$A" -le "$B" ]
[ "$A" -ge "$B" ]
```

---

## File Test Operators

```bash
-f file
-d directory
-e file
-r file
-w file
-x file
-s file
```

| Operator | Meaning             |
| -------- | ------------------- |
| `-f`     | Regular file exists |
| `-d`     | Directory exists    |
| `-e`     | Exists              |
| `-r`     | Readable            |
| `-w`     | Writable            |
| `-x`     | Executable          |
| `-s`     | Not empty           |

---

## if / elif / else

```bash
if [ "$AGE" -ge 18 ]
then
    echo "Adult"
elif [ "$AGE" -ge 13 ]
then
    echo "Teen"
else
    echo "Child"
fi
```

---

## Logical Operators

```bash
[ "$A" -gt 5 ] && echo "True"

[ "$A" -lt 5 ] || echo "False"

! [ -f file ]
```

---

## Case Statement

```bash
case $ACTION in
    start)
        echo "Starting service"
        ;;
    stop)
        echo "Stopping service"
        ;;
    restart)
        echo "Restarting service"
        ;;
    *)
        echo "Invalid option"
        ;;
esac
```

---

# 3. Loops

## For Loop (List-Based)

```bash
for i in 1 2 3 4 5
do
    echo $i
done
```

---

## For Loop (C-Style)

```bash
for ((i=1; i<=5; i++))
do
    echo $i
done
```

---

## While Loop

```bash
COUNT=1

while [ $COUNT -le 5 ]
do
    echo $COUNT
    ((COUNT++))
done
```

---

## Until Loop

Runs until condition becomes true.

```bash
COUNT=1

until [ $COUNT -gt 5 ]
do
    echo $COUNT
    ((COUNT++))
done
```

---

## break and continue

```bash
for i in {1..5}
do
    [ $i -eq 3 ] && continue
    echo $i
done
```

---

## Loop Over Files

```bash
for file in *.log
do
    echo "$file"
done
```

---

## Loop Over Command Output

```bash
cat file.txt | while read line
do
    echo "$line"
done
```

---

# 4. Functions

## Define a Function

```bash
greet() {
    echo "Hello"
}
```

---

## Call a Function

```bash
greet
```

---

## Function Arguments

```bash
greet() {
    echo "Hello $1"
}

greet Sahil
```

---

## Return vs Echo

Return exit status:

```bash
check() {
    return 0
}
```

Return actual value:

```bash
add() {
    echo $(($1 + $2))
}
```

---

## Local Variables

```bash
greet() {
    local NAME="DevOps"
    echo $NAME
}
```

---

# 5. Text Processing Commands

## grep

```bash
grep "error" app.log
grep -i "error" app.log
grep -r "error" .
grep -c "error" app.log
grep -n "error" app.log
grep -v "info" app.log
grep -E "error|warning" app.log
```

---

## awk

Print first column:

```bash
awk '{print $1}' file.txt
```

Use custom delimiter:

```bash
awk -F: '{print $1}' /etc/passwd
```

Pattern matching:

```bash
awk '/ERROR/ {print $0}' app.log
```

BEGIN and END:

```bash
awk 'BEGIN{print "Start"} {print $1} END{print "End"}' file.txt
```

---

## sed

Replace first occurrence:

```bash
sed 's/foo/bar/' file.txt
```

Replace all occurrences:

```bash
sed 's/foo/bar/g' file.txt
```

Delete line 5:

```bash
sed '5d' file.txt
```

In-place edit:

```bash
sed -i 's/foo/bar/g' config.txt
```

---

## cut

```bash
cut -d: -f1 /etc/passwd
```

---

## sort

```bash
sort file.txt
sort -n numbers.txt
sort -r file.txt
sort -u file.txt
```

---

## uniq

```bash
uniq file.txt
uniq -c file.txt
```

---

## tr

Convert to uppercase:

```bash
echo "linux" | tr a-z A-Z
```

Delete digits:

```bash
echo "abc123" | tr -d 0-9
```

---

## wc

```bash
wc file.txt
wc -l file.txt
wc -w file.txt
wc -c file.txt
```

---

## head and tail

```bash
head -n 10 file.txt
tail -n 10 file.txt
tail -f app.log
```

---

# 6. Useful Patterns and One-Liners

## Delete Files Older Than 30 Days

```bash
find /backup -type f -mtime +30 -delete
```

---

## Count Lines in All Log Files

```bash
wc -l *.log
```

---

## Replace String Across Multiple Files

```bash
sed -i 's/old/new/g' *.txt
```

---

## Check if a Service is Running

```bash
systemctl is-active nginx
```

---

## Monitor Disk Usage Above 80%

```bash
df -h | awk '$5+0 > 80 {print $0}'
```

---

## Parse CSV

```bash
awk -F, '{print $1}' users.csv
```

---

## Parse JSON

```bash
jq '.name' data.json
```

---

## Tail Logs and Show Errors

```bash
tail -f app.log | grep --line-buffered ERROR
```

---

# 7. Error Handling and Debugging

## Exit Codes

Success:

```bash
exit 0
```

Failure:

```bash
exit 1
```

Check status:

```bash
echo $?
```

---

## set -e

Exit immediately if a command fails.

```bash
set -e
```

---

## set -u

Treat unset variables as errors.

```bash
set -u
```

---

## set -o pipefail

Catch failures in pipelines.

```bash
set -o pipefail
```

---

## set -x

Enable debug mode.

```bash
set -x
```

Disable:

```bash
set +x
```

---

## Trap

Run cleanup code before exiting.

```bash
cleanup() {
    rm -f temp.txt
}

trap cleanup EXIT
```

---

# Common Bash Special Variables

| Variable | Meaning                     |
| -------- | --------------------------- |
| `$$`     | Current process ID          |
| `$!`     | Last background process ID  |
| `$?`     | Exit status                 |
| `$#`     | Number of arguments         |
| `$@`     | All arguments               |
| `$*`     | All arguments as one string |

---

# Bash Script Template

```bash
#!/bin/bash

set -euo pipefail

cleanup() {
    echo "Cleaning up..."
}

trap cleanup EXIT

main() {
    echo "Script Started"
}

main
```

---

# Quick Debug Checklist

```text
✓ Check file permissions
✓ Verify variable values
✓ Run with bash -x script.sh
✓ Check exit codes
✓ Validate file paths
✓ Use shellcheck
✓ Test commands manually
```

```
```

