# Day 24 - Advanced Git: Merge, Rebase, Stash & Cherry Pick

## Task 1 - Git Merge

### What is a fast-forward merge?

A fast-forward merge occurs when the target branch has not moved forward since the feature branch was created. Git simply moves the branch pointer forward without creating a merge commit.

### When does Git create a merge commit instead?

Git creates a merge commit when both branches contain unique commits and their histories need to be combined.

### What is a merge conflict?

A merge conflict occurs when Git cannot automatically determine which changes should be kept because the same file or line was modified differently in multiple branches.

### Commands Practiced

```bash
# Create feature-login branch
git checkout -b feature-login

# Create commits
echo "Login Page" > login.txt
git add .
git commit -m "Add login page"

echo "Login Validation" >> login.txt
git add .
git commit -m "Add login validation"

# Merge into master/main
git checkout master
git merge feature-login
```

### Example of Merge Conflict

```bash
git checkout -b conflict-test

echo "Version A" > app.txt
git add .
git commit -m "Version A"

git checkout master

echo "Version B" > app.txt
git add .
git commit -m "Version B"

git checkout conflict-test

echo "Version C" > app.txt
git add .
git commit -m "Version C"

git checkout master
git merge conflict-test
```

Resolve conflict:

```bash
git add app.txt
git commit
```

---

## Task 2 - Git Rebase

### What does rebase actually do to your commits?

Rebase takes commits from a branch and reapplies them on top of another branch. Git creates new commit hashes because the commits are rewritten.

### How is the history different from a merge?

A merge preserves branch history and creates a merge commit. A rebase creates a clean and linear history.

### Why should you never rebase commits that have been pushed and shared with others?

Rebasing changes commit hashes and rewrites history. This can create confusion and conflicts for other team members.

### When would you use rebase vs merge?

Use rebase for a clean history on local branches.

Use merge when working with shared branches and preserving branch history.

### Commands Practiced

```bash
# Create feature branch
git checkout -b feature-dashboard

# Create commits
echo "Dashboard UI" > dashboard.txt
git add .
git commit -m "Dashboard UI"

echo "Dashboard Backend" >> dashboard.txt
git add .
git commit -m "Dashboard Backend"

# Update master
git checkout master

echo "Main Update" > update.txt
git add .
git commit -m "Main updated"

# Rebase
git checkout feature-dashboard
git rebase master
```

Visualize history:

```bash
git log --oneline --graph --all --decorate
```

---

## Task 3 - Squash Merge

### What does squash merging do?

Squash merge combines all commits from a feature branch into a single commit before merging.

### When would you use squash merge vs regular merge?

Use squash merge when there are many small commits.

Use regular merge when detailed history is important.

### What is the trade-off of squashing?

The detailed commit history is lost.

### Commands Practiced

```bash
git checkout -b feature-profile

echo "Profile Page" > profile.txt
git add .
git commit -m "Profile page"

echo "Typo Fix" >> profile.txt
git add .
git commit -m "Fix typo"

echo "Formatting" >> profile.txt
git add .
git commit -m "Formatting"

git checkout master

git merge --squash feature-profile

git commit -m "Add complete profile feature"
```

---

## Task 4 - Git Stash

### What is the difference between git stash pop and git stash apply?

git stash pop restores changes and removes the stash entry.

git stash apply restores changes but keeps the stash entry.

### When would you use stash in a real-world workflow?

When switching tasks quickly without committing unfinished work.

### Commands Practiced

```bash
# Create temporary changes
echo "Work in progress" > temp.txt

# Stash tracked files
git stash

# Stash including untracked files
git stash -u

# View stashes
git stash list

# Restore and remove stash
git stash pop

# Restore but keep stash
git stash apply stash@{0}
```

---

## Task 5 - Cherry Picking

### What does cherry-pick do?

Cherry-pick copies a specific commit from one branch and applies it to another branch.

### When would you use cherry-pick in a real project?

To apply a specific bug fix or hotfix without merging the entire branch.

### What can go wrong with cherry-picking?

It can create conflicts, duplicate commits, and make history harder to understand.

### Commands Practiced

```bash
git checkout -b feature-hotfix

echo "Fix1" > hotfix.txt
git add .
git commit -m "1st commit"

echo "Fix2" >> hotfix.txt
git add .
git commit -m "2nd commit"

echo "Fix3" >> hotfix.txt
git add .
git commit -m "3rd commit"

git log --oneline

git checkout master

git cherry-pick <commit-hash>
```

If conflict occurs:

```bash
git status

git add hotfix.txt

git cherry-pick --continue
```

Abort cherry-pick:

```bash
git cherry-pick --abort
```

---

## Most Useful Command Learned Today

```bash
git log --oneline --graph --all --decorate
```

This command helps visualize merge commits, rebases, squash merges, and cherry-picks in the repository history.

## Key Learnings

* Merge combines branch histories.
* Rebase rewrites history into a linear timeline.
* Squash merge combines multiple commits into one.
* Stash temporarily saves unfinished work.
* Cherry-pick copies individual commits between branches.
* Merge preserves history while rebase creates a cleaner history.

