# DAY 12: GIT & PULL REQUEST WORKFLOW

# Git helps you track changes in your code.
# Git: Tracks changes to your code on your computer.
# GitHub: Stores your code online and helps you collaborate.
# Branch: Allows you to work separately without directly changing the main branch.
# Pull Request (PR): Requests to merge changes from one branch into another.
# Merge: Combines changes into the target branch.

# STEP 1: Check Git and repository status
# git --version
# git status
# git branch

# STEP 2: Switch to the feature branch
# git switch feature/hello-message

# STEP 3: Create and test hello.py
# File: hello.py

print("Hello Git")
print("Learning version control")
print("I am learning Git step by step")
print("Practicing branches and pull requests")

# STEP 4: Run the Python file
# py hello.py

# STEP 5: Review and commit changes
# git status
# git diff
# git add hello.py
# git commit -m "Add feature branch message"

# NOTE:
# If there are no new changes, Git may report that there is nothing to commit.

# STEP 6: Push the feature branch to GitHub
# git push -u origin feature/hello-message

# STEP 7: Create a Pull Request on GitHub
# Repository: git-pull-request-practice
# Base branch: main
# Compare branch: feature/hello-message
# Title: Add feature branch message
# Add a description and click Create pull request.

# STEP 8: Merge the Pull Request
# Review the changed file hello.py.
# Click Merge pull request.
# Confirm the merge.
# Verify that the Pull Request status is Merged.

# STEP 9: Update the local main branch
# git switch main
# git pull origin main

# STEP 10: Verify the final result
# py hello.py
# git log -1 --oneline
# git status

# EXPECTED OUTPUT:
# Hello Git
# Learning version control
# I am learning Git step by step
# Practicing branches and pull requests

# FINAL RESULT:
# Created a feature branch, added and tested a Python file,
# committed and pushed changes to GitHub, created Pull Request #2,
# merged the changes into main, and verified the updated code locally.

# IMPORTANT:
# Pull Request #2 has already been merged.
# Do not repeat the commit or merge steps unless you have new changes.
# If the working tree is clean, continue with verification commands.
# Do not force-push or overwrite existing work.