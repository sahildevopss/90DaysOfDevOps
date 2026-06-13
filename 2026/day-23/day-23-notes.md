# Day 23 – Git Branching & Working with GitHub

## Task 1: Understanding Branches

### What is a branch in Git?

A branch is an independent line of development in Git. It allows developers to work on new features, bug fixes, or experiments without affecting the main codebase.

### Why do we use branches instead of committing everything to main?

Branches help keep the main branch stable. Developers can work on features separately, test them, and merge them into the main branch only when they are ready.

### What is HEAD in Git?

HEAD is a pointer that refers to the current branch and the latest commit on that branch. It tells Git where you are currently working.

### What happens to your files when you switch branches?

Git updates the working directory to match the selected branch. Files that exist only in another branch may disappear, while files unique to the selected branch may appear.

---

# Task 2: Branching Commands – Hands-On

## Commands Practiced

### List all branches

```bash
git branch
```

### Create a new branch

```bash
git branch feature-1
```

### Switch to a branch

```bash
git checkout feature-1
```

### Create and switch to a branch in one command

```bash
git checkout -b feature-2
```

### Using git switch

```bash
git switch feature-1
git switch main
```

### Difference Between git switch and git checkout

`git switch` is a newer command designed specifically for switching branches.

`git checkout` is an older command that can switch branches, restore files, and perform multiple operations.

### Create a Commit on feature-1

```bash
git switch feature-1
echo "Feature 1 changes" > feature1.txt
git add .
git commit -m "Add feature1 changes"
```

### Verify Branch Isolation

After switching back to main:

```bash
git switch main
```

The changes made on `feature-1` were not visible because they belong only to that branch.

### Delete an Unused Branch

```bash
git branch -d feature-2
```

---

# Task 3: Push to GitHub

## Connected Local Repository to GitHub

```bash
git remote add origin https://github.com/<username>/devops-git-practice.git
```

## Push Main Branch

```bash
git push -u origin main
```

## Push Feature Branch

```bash
git push -u origin feature-1
```

## Verification

Verified that both `main` and `feature-1` branches were visible on GitHub.

### Difference Between Origin and Upstream

**Origin**

Origin is the default remote repository associated with my local repository. In most cases, it points to my own GitHub repository.

**Upstream**

Upstream refers to the original repository from which a fork was created. It is used to fetch updates from the original project and keep my fork synchronized.

---

# Task 4: Pull from GitHub

## Steps Performed

1. Made a change directly on GitHub.
2. Pulled the change into the local repository.

```bash
git pull origin main
```

### Difference Between git fetch and git pull

#### git fetch

Downloads changes from a remote repository without merging them into the current branch.

```bash
git fetch
```

#### git pull

Downloads changes and automatically merges them into the current branch.

```bash
git pull
```

**Simple Explanation**

* git fetch = Download updates only.
* git pull = Download updates and merge them.

---

# Task 5: Clone vs Fork

## Clone vs Fork

### Clone

Clone creates a local copy of a repository on your machine.

```bash
git clone <repository-url>
```

### Fork

Fork creates a copy of a repository under your own GitHub account.

A fork is a GitHub feature, while clone is a Git command.

### When Would You Use Clone?

* When you already have access to a repository.
* When you want a local copy for development.

### When Would You Use Fork?

* When contributing to an open-source project.
* When you do not have direct write access to the original repository.

## Practical Exercise

I forked the freeCodeCamp repository to my GitHub account and cloned my fork locally.

### Check Existing Remote

```bash
git remote -v
```

### Add Upstream Remote

```bash
git remote add upstream https://github.com/freeCodeCamp/freeCodeCamp.git
```

### Verify Remotes

```bash
git remote -v
```

Output showed:

```text
origin   -> My fork (GitHub repository)
upstream -> Original freeCodeCamp repository
```

### Keep Fork Updated

Fetch latest changes from upstream:

```bash
git fetch upstream
```

Merge updates into local main branch:

```bash
git switch main
git merge upstream/main
```

Push updates to fork:

```bash
git push origin main
```

### How Do You Keep a Fork in Sync?

To keep a fork synchronized with the original repository, I fetch updates from the upstream repository, merge those changes into my local branch, and then push the updates to my fork on GitHub.

---

# Key Learnings

* Branches provide isolated environments for development.
* HEAD points to the current branch and commit.
* git switch is a cleaner alternative to git checkout for branch switching.
* origin refers to my GitHub repository.
* upstream refers to the original repository from which a fork was created.
* git fetch downloads updates without merging them.
* git pull downloads and merges updates.
* Forking is commonly used when contributing to open-source projects.
* A fork can be kept updated using upstream remotes and synchronization commands.

