# Day 22 - Introduction to Git: Your First Repository

## Objective

Today I started learning Git, the most widely used version control system and a core tool in DevOps. The goal was to understand the Git workflow, create my first repository, and begin building a personal Git commands reference.

---

# Task 1: Install and Configure Git

## Verify Git Installation

```bash
git --version
```

Output:

```text
git version 2.x.x
```

## Configure Git Username

```bash
git config --global user.name "Sahil Sanadi"
```

## Configure Git Email

```bash
git config --global user.email "your-email@example.com"
```

## Verify Configuration

```bash
git config --list
```

---

# Task 2: Create Your Git Project

## Create Project Directory

```bash
mkdir devops-git-practice
cd devops-git-practice
```

## Initialize Git Repository

```bash
git init
```

Output:

```text
Initialized empty Git repository
```

## Check Repository Status

```bash
git status
```

## View Hidden Files

```bash
ls -la
```

## Explore .git Directory

```bash
ls -la .git
```

Important files and directories:

```text
.git/
├── HEAD
├── config
├── description
├── hooks/
├── info/
├── objects/
└── refs/
```

---

# Task 3: Create Git Commands Reference

Created a file named:

```text
git-commands.md
```

This file will be continuously updated throughout the Git learning journey.

## Commands Added

### Setup & Configuration

| Command                        | Description                        |
| ------------------------------ | ---------------------------------- |
| git --version                  | Displays installed Git version     |
| git config --global user.name  | Sets Git username                  |
| git config --global user.email | Sets Git email                     |
| git config --list              | Displays current Git configuration |

### Basic Workflow

| Command    | Description                  |
| ---------- | ---------------------------- |
| git init   | Creates a new Git repository |
| git add    | Stages files for commit      |
| git commit | Saves staged changes         |
| git branch | Lists available branches     |

### Viewing Changes

| Command           | Description                     |
| ----------------- | ------------------------------- |
| git status        | Shows repository status         |
| git diff          | Displays unstaged changes       |
| git show          | Shows details of a commit       |
| git log           | Displays commit history         |
| git log --oneline | Displays compact commit history |

### Remote Operations

| Command       | Description                 |
| ------------- | --------------------------- |
| git pull      | Downloads remote changes    |
| git push      | Uploads local changes       |
| git remote -v | Displays configured remotes |

---

# Task 4: Stage and Commit

## Stage Files

```bash
git add git-commands.md
```

## Verify Staged Changes

```bash
git status
```

## Create First Commit

```bash
git commit -m "Add initial Git commands reference"
```

## View Commit History

```bash
git log
```

---

# Task 5: Build Commit History

As I learned new commands, I continuously updated the repository and created multiple commits.

Example commits:

```bash
git commit -m "Add initial Git commands reference"

git commit -m "Document Git diff command"

git commit -m "Expand Git command reference"

git commit -m "Add Git workflow notes"
```

## View Compact History

```bash
git log --oneline
```

Example:

```text
738fe96 Document Git commands
a123456 Add Git workflow notes
b234567 Expand Git command reference
c345678 Add initial Git commands reference
```

---

# Task 6: Understanding the Git Workflow

## What is the difference between git add and git commit?

`git add` moves changes to the staging area, while `git commit` permanently saves staged changes into the repository history.

---

## What does the staging area do? Why doesn't Git commit directly?

The staging area acts as a preparation zone where changes can be reviewed and selected before committing. This allows developers to organize commits logically and maintain a clean history.

---

## What information does git log show?

`git log` displays:

* Commit hash
* Author name
* Author email
* Commit date
* Commit message

---

## What is the .git folder?

The `.git` folder stores:

* Commit history
* Branch information
* Repository configuration
* References
* Objects database

If deleted, the directory is no longer a Git repository and all Git history is lost.

---

## Difference Between Working Directory, Staging Area and Repository

### Working Directory

Files currently being modified.

### Staging Area

Temporary area where selected changes are prepared for commit.

### Repository

Permanent Git history containing committed snapshots.

### Git Workflow Diagram

```text
Working Directory
        ↓
      git add
        ↓
   Staging Area
        ↓
    git commit
        ↓
     Repository
```

---

# Key Learnings

* Git is a distributed version control system.
* Every Git repository contains a hidden `.git` directory.
* `git status` is one of the most important Git commands.
* The staging area provides fine-grained control over commits.
* Meaningful commit messages improve project history.
* Git tracks project changes efficiently and safely.
* A clean commit history makes collaboration easier.

---

# Commands Practiced

```bash
git --version

git config --global user.name
git config --global user.email
git config --list

git init

git status

git add .

git commit -m "message"

git diff

git show

git branch

git log

git log --oneline

git pull

git push

git remote -v
```

# Outcome

✅ Configured Git

✅ Created first repository

✅ Explored the .git directory

✅ Built a Git commands reference

✅ Created multiple commits

✅ Learned the Git workflow

✅ Understood Working Directory → Staging Area → Repository


# Day 23 - Git Branching & GitHub Commands

## Branching Commands

```bash
git branch
```

List all local branches.

```bash
git branch feature-1
```

Create a new branch.

```bash
git checkout feature-1
```

Switch to an existing branch.

```bash
git checkout -b feature-2
```

Create and switch to a new branch in a single command.

```bash
git switch feature-1
```

Switch branches using the modern Git command.

```bash
git switch main
```

Switch back to the main branch.

```bash
git branch -d feature-2
```

Delete a branch.

```bash
git branch -a
```

List all local and remote branches.

---

## GitHub Remote Commands

```bash
git remote -v
```

View configured remote repositories.

```bash
git remote add origin <repository-url>
```

Add a GitHub repository as a remote.

```bash
git push -u origin main
```

Push the main branch and set upstream tracking.

```bash
git push -u origin feature-1
```

Push a feature branch and set upstream tracking.

```bash
git pull origin main
```

Pull changes from GitHub.

```bash
git fetch
```

Download remote changes without merging.

---

## Fork & Upstream Commands

```bash
git clone <repository-url>
```

Clone a repository locally.

```bash
git remote add upstream <repository-url>
```

Add the original repository as upstream.

```bash
git fetch upstream
```

Fetch changes from the original repository.

```
## Day 24 - Advanced Git Commands

### Git Merge

Merge a branch into the current branch:

```bash
git merge <branch-name>
```

Example:

```bash
git merge feature-login
```

---

### Git Rebase

Reapply commits from the current branch on top of another branch:

```bash
git rebase <branch-name>
```

Example:

```bash
git rebase master
```

---

### Git Squash Merge

Combine all commits from a branch into a single commit before merging:

```bash
git merge --squash <branch-name>
```

Example:

```bash
git merge --squash feature-profile
```

Complete the squash merge:

```bash
git commit -m "Add complete profile feature"
```

---

### Git Stash

Temporarily save uncommitted changes:

```bash
git stash
```

Example:

```bash
git stash
```

---

### Stash Including Untracked Files

Save tracked and untracked files:

```bash
git stash -u
```

Example:

```bash
git stash --include-untracked
```

---

### List All Stashes

View saved stashes:

```bash
git stash list
```

Example:

```bash
git stash list
```

---

### Apply Latest Stash

Restore changes and keep stash entry:

```bash
git stash apply
```

Example:

```bash
git stash apply stash@{0}
```

---

### Pop Latest Stash

Restore changes and remove stash entry:

```bash
git stash pop
```

Example:

```bash
git stash pop
```

---

### Cherry Pick

Apply a specific commit from another branch:

```bash
git cherry-pick <commit-hash>
```

Example:

```bash
git cherry-pick 590ade8
```

---

### Continue Cherry Pick After Conflict

```bash
git cherry-pick --continue
```

Example:

```bash
git add hotfix.txt
git cherry-pick --continue
```

---

### Abort Cherry Pick

Cancel an in-progress cherry-pick:

```bash
git cherry-pick --abort
```

Example:

```bash
git cherry-pick --abort
```

---

### View Git History Graph

Display branch and merge history visually:

```bash
git log --oneline --graph --all --decorate
```

Example:

```bash
git log --oneline --graph --all --decorate
```

