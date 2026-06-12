# Git Commands Reference

## Setup & Configuration

### git --version

What it does:
Checks installed Git version.

Example:

```bash
git --version
```

### git config --global user.name

What it does:
Sets your Git username.

Example:

```bash
git config --global user.name "Sahil Sanadi"
```

### git config --global user.email

What it does:
Sets your Git email address.

Example:

```bash
git config --global user.email "example@gmail.com"
```

### git config --list

What it does:
Displays current Git configuration.

Example:

```bash
git config --list
```

---

## Basic Workflow

### git init

What it does:
Creates a new Git repository.

Example:

```bash
git init
```

### git add

What it does:
Stages files for commit.

Example:

```bash
git add git-commands.md
```

### git commit

What it does:
Saves staged changes into repository history.

Example:

```bash
git commit -m "Add Git commands reference"
```

---

## Viewing Changes

### git status

What it does:
Shows file status and staged changes.

Example:

```bash
git status
```

### git log

What it does:
Displays commit history.

Example:

```bash
git log
```

### git log --oneline

What it does:
Shows compact commit history.

Example:

```bash
git log --oneline
```
### git diff

What it does:
Shows changes not yet staged.

Example:

git diff

### git show

What it does:
Displays details of a commit.

Example:

git show
