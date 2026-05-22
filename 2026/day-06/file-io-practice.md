# Day 06 - Linux File Read/Write Practice

## Commands Used

### Create file
touch notes.txt

### Write to file
echo "Linux file handling practice" > notes.txt

### Append to file
echo "Learning read and write operations" >> notes.txt

### Use tee command
echo "tee command writes and displays output" | tee -a notes.txt

### Read full file
cat notes.txt

### Read first lines
head -n 2 notes.txt

### Read last lines
tail -n 2 notes.txt

## What I Learned

- Difference between > and >>
- How to append content into files
- How cat, head, and tail work
- How tee writes and displays output together
