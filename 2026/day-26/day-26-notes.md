 Day 26 - GitHub CLI (gh)

## Overview

GitHub CLI (`gh`) allows developers and DevOps engineers to interact with GitHub directly from the terminal. It helps manage repositories, issues, pull requests, workflows, and releases without leaving the command line.

---

# Task 1: Install and Authenticate

## Install GitHub CLI

```bash
sudo apt update
sudo apt install gh -y
```

Verify installation:

```bash
gh --version
```

## Authenticate with GitHub

```bash
gh auth login
```

Verify authentication status:

```bash
gh auth status
```

### Authentication Methods Supported by gh

* Browser-based OAuth Login
* Personal Access Token (PAT)
* SSH Authentication
* GitHub Enterprise Authentication

### Observation

Successfully authenticated GitHub account and verified active user using `gh auth status`.

---

# Task 2: Working with Repositories

## Create a Repository

```bash
gh repo create day26-gh-test --public --clone --add-readme
```

## Clone a Repository

```bash
gh repo clone octocat/Hello-World
```

## View Repository Details

```bash
gh repo view
```

## List Repositories

```bash
gh repo list
```

## Open Repository in Browser

```bash
gh repo view --web
```

## Delete Repository

```bash
gh repo delete day26-gh-test --yes
```

### Observation

GitHub CLI enables repository creation, cloning, viewing, listing, and deletion directly from the terminal.

### Additional Learning

Deleting repositories requires the `delete_repo` OAuth scope. Without it, GitHub returns an HTTP 403 error.

---

# Task 3: Working with Issues

## Create an Issue

```bash
gh issue create \
--title "Day 26 GitHub CLI Practice" \
--body "Testing GitHub CLI issue management." \
--label bug
```

## List Open Issues

```bash
gh issue list
```

## View an Issue

```bash
gh issue view 1 --json title,body,state
```

## Close an Issue

```bash
gh issue close 1
```

### Observation

Issues can be created, viewed, listed, and closed directly from the terminal.

### GitHub Projects Classic Warning

Running:

```bash
gh issue view 1
```

returned a warning related to the deprecation of GitHub Projects (Classic).

Workaround:

```bash
gh issue view 1 --json title,body,state
```

This successfully displayed issue details without querying deprecated project metadata.

### How can gh issue be used in automation?

* Automatically create issues when monitoring scripts detect failures.
* Open incidents from CI/CD pipelines.
* Generate issues from log analysis tools.
* Automatically close resolved issues.

---

# Task 4: Pull Requests

## Create a Branch

```bash
git checkout -b day26-gh-cli
```

## Make Changes and Commit

```bash
echo "Day 26 GitHub CLI Practice" > day26.txt

git add day26.txt
git commit -m "Add Day 26 GitHub CLI practice file"
```

## Push Branch

```bash
git push -u origin day26-gh-cli
```

## Create Pull Request

```bash
gh pr create --fill
```

## List Pull Requests

```bash
gh pr list
```

## View Pull Request

```bash
gh pr view
```

## Merge Pull Request

```bash
gh pr merge --squash
```

### Merge Methods Supported by gh pr merge

#### Merge Commit

```bash
gh pr merge --merge
```

#### Squash Merge

```bash
gh pr merge --squash
```

#### Rebase Merge

```bash
gh pr merge --rebase
```

### Reviewing Someone Else's Pull Request

View PR:

```bash
gh pr view <PR_NUMBER>
```

Checkout PR Locally:

```bash
gh pr checkout <PR_NUMBER>
```

Approve PR:

```bash
gh pr review <PR_NUMBER> --approve
```

Request Changes:

```bash
gh pr review <PR_NUMBER> --request-changes
```

Add Review Comments:

```bash
gh pr review <PR_NUMBER> --comment
```

---

# Task 5: GitHub Actions & Workflows

## List Workflow Runs

```bash
gh run list
```

## View Workflow Run

```bash
gh run view <RUN_ID>
```

## Watch Workflow Execution

```bash
gh run watch
```

### How can gh run and gh workflow help in CI/CD?

* Monitor workflow execution from the terminal.
* Debug failed deployments quickly.
* Trigger and validate CI/CD pipelines.
* Automate workflow monitoring.
* Integrate GitHub Actions checks into scripts and automation.

---

# Task 6: Useful GitHub CLI Commands

## GitHub API

```bash
gh api user
```

## Create a Gist

```bash
gh gist create notes.txt
```

## Create a Release

```bash
gh release create v1.0.0
```

## Create an Alias

```bash
gh alias set prs "pr list"
```

Use Alias:

```bash
gh prs
```

## Search Repositories

```bash
gh search repos devops
```

---

# Key Learnings

* GitHub CLI allows complete GitHub management from the terminal.
* Issues and Pull Requests can be managed without opening the browser.
* GitHub workflows can be monitored directly from CLI.
* OAuth scopes control access to GitHub resources and operations.
* `gh` is a powerful tool for DevOps automation and CI/CD workflows.

---

# Conclusion

Day 26 introduced GitHub CLI and demonstrated how repositories, issues, pull requests, and workflows can be managed entirely from the terminal. This improves productivity, reduces context switching, and enables automation of GitHub-related tasks in DevOps environments.

