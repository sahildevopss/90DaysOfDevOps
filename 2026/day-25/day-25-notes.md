# Day 25 – Git Reset vs Revert & Branching Strategies

## Objective

Learn how to safely undo changes in Git using `reset` and `revert`, understand the differences between them, and explore common branching strategies used by software teams.

---

# Task 1: Git Reset – Hands-On

## Commits Created

```bash
Commit A
Commit B
Commit C
```

---

## git reset --soft

### Command

```bash
git reset --soft HEAD~1
```

### Observation

* Commit C was removed from history.
* Changes from Commit C remained in the staging area.
* Files were ready to be committed again.

### Result

```text
A → B (HEAD)

Changes from C = Staged
```

---

## git reset --mixed

### Command

```bash
git reset --mixed HEAD~1
```

### Observation

* Commit was removed from history.
* Changes remained in the working directory.
* Changes were no longer staged.

### Result

```text
A → B (HEAD)

Changes from C = Unstaged
```

---

## git reset --hard

### Command

```bash
git reset --hard HEAD~1
```

### Observation

* Commit was removed from history.
* Changes were removed from both staging area and working directory.
* Files returned to the previous commit state.

### Result

```text
A → B (HEAD)

Changes from C = Deleted
```

---

## Difference Between Soft, Mixed and Hard Reset

| Reset Type | Commit Removed | Changes Kept | Staged |
| ---------- | -------------- | ------------ | ------ |
| --soft     | Yes            | Yes          | Yes    |
| --mixed    | Yes            | Yes          | No     |
| --hard     | Yes            | No           | No     |

---

## Which One Is Destructive?

`git reset --hard`

Reason:

* Removes commits from history.
* Deletes local changes from the working directory.
* Lost work may be difficult to recover without `git reflog`.

---

## When Would You Use Each?

### Soft

* Reword a commit.
* Combine commits.
* Modify commit history before pushing.

### Mixed

* Undo a commit but continue editing files.

### Hard

* Discard unwanted local changes completely.

---

## Should You Use Reset On Pushed Commits?

No.

Reason:

* Rewrites Git history.
* Can cause issues for other team members.
* Not recommended on shared branches.

For shared branches, use:

```bash
git revert
```

instead.

---

# Task 2: Git Revert – Hands-On

## Commits Created

```text
X → Y → Z
```

### Command

```bash
git revert <commit-hash-of-Y>
```

### Observation

While reverting Commit Y, Git reported a conflict because Commit Z modified the same file after Y.

Conflict example:

```text
<<<<<<< HEAD
Git revert test Y
Git revert test Z
=======
>>>>>>> parent of commit Y
```

The conflict was resolved manually by removing the changes introduced by Commit Y while keeping Commit Z.

Final file:

```text
Git revert commit X
Git revert test Z
```

Git then created a new revert commit.

---

## Is Commit Y Still In History?

Yes.

Git Revert does not remove history.

Instead, it creates a new commit that reverses the selected commit.

Example:

```text
X → Y → Z → Revert Y
```

---

## How Is Git Revert Different From Git Reset?

### Git Reset

* Moves branch pointer backward.
* Removes commits from branch history.

### Git Revert

* Creates a new commit.
* Preserves commit history.

---

## Why Is Revert Safer?

Because it does not rewrite history.

This makes it safe for:

* Team environments
* Shared branches
* Production branches

---

## When To Use Revert vs Reset?

### Use Reset

* Local commits
* Unpushed work
* Cleanup before sharing code

### Use Revert

* Shared repositories
* Production code
* Already pushed commits

---

# Task 3: Reset vs Revert Comparison

| Feature                     | git reset           | git revert              |
| --------------------------- | ------------------- | ----------------------- |
| What it does                | Moves HEAD backward | Creates opposite commit |
| Removes commit from history | Yes                 | No                      |
| Rewrites history            | Yes                 | No                      |
| Safe for shared branches    | No                  | Yes                     |
| Safe for pushed commits     | No                  | Yes                     |
| Best use case               | Local cleanup       | Undo published commits  |
=
---

# Task 4: Branching Strategies

## 1. GitFlow

### How It Works

```text
main
 │
 └── develop
      │
      ├── feature/*
      ├── release/*
      └── hotfix/*
```

### Used In

* Enterprise software
* Large teams
* Scheduled releases

### Pros

* Structured workflow
* Strong release management
* Supports multiple versions

### Cons

* More complex
* Many branches to maintain
* Slower development cycle

---

## 2. GitHub Flow

### How It Works

```text
main
 │
 ├── feature-login
 ├── feature-api
 └── feature-ui
```

Workflow:

```text
Create Branch
    ↓
Commit Changes
    ↓
Create Pull Request
    ↓
Code Review
    ↓
Merge To Main
```

### Used In

* Startups
* SaaS products
* Continuous deployment environments

### Pros

* Simple
* Fast
* Easy collaboration

### Cons

* Less release control
* Not ideal for maintaining multiple versions

---

## 3. Trunk-Based Development

### How It Works

```text
main
 │
 ├── short-lived branch
 ├── short-lived branch
 └── merge quickly
```

### Used In

* High CI/CD environments
* Large technology companies

### Pros

* Faster integration
* Fewer merge conflicts
* Continuous delivery friendly

### Cons

* Requires strong testing
* Requires disciplined developers

---

## Answers

### Which Strategy Would You Use For A Startup Shipping Fast?

GitHub Flow

Reason:

* Simple workflow
* Fast releases
* Easy collaboration

---

### Which Strategy Would You Use For A Large Team With Scheduled Releases?

GitFlow

Reason:

* Better release planning
* Dedicated release and hotfix branches
* More control over production deployments

---

### Which Strategy Do Popular Open Source Projects Use?

#### Kubernetes

Uses GitHub Flow style development with dedicated release branches.

#### React

Uses a workflow very similar to GitHub Flow.

#### Linux Kernel

Uses a maintainer-based workflow that resembles Trunk-Based Development.

---

# Important Learning: git reflog

`git reflog` acts as Git's safety net.

Even after a hard reset, previous commit references can often be recovered.

### Command

```bash
git reflog
```

### Example

```text
abc123 HEAD@{0}: reset: moving to HEAD~1
def456 HEAD@{1}: commit: Lost Commit
```

### Recovery

```bash
git reset --hard def456
```

---

# Conclusion

Today I learned how to safely undo changes using Git Reset and Git Revert, understood when each command should be used, explored recovery using Git Reflog, and studied common branching strategies used by startups, enterprises, and open-source projects.


# Handwritten Notes

![Git-Reset/Revert](Day-25- Git-reset)
