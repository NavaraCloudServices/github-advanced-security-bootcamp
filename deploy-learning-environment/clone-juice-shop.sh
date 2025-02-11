#!/bin/bash
SRC_ORG="juice-shop"
SRC_REPO="juice-shop"
TGT_ORG="NavaraLabs"
TGT_REPO="joost-juice-shop"

# Step 1: Clone the source repository using the gh CLI.
echo "Cloning repository ${SRC_ORG}/${SRC_REPO}..."
gh repo clone "${SRC_ORG}/${SRC_REPO}" || { echo "Failed to clone ${SRC_ORG}/${SRC_REPO}"; exit 1; }

cd "${SRC_REPO}" || { echo "Directory ${SRC_REPO} not found"; exit 1; }

# Step 2: Rename the original remote to 'upstream'
echo "Renaming remote 'origin' to 'upstream'..."
git remote rename origin upstream

# Step 3: Create a new repository in the target organization.
echo "Creating new repository ${TGT_ORG}/${TGT_REPO}..."
gh repo create "${TGT_ORG}/${TGT_REPO}" -y --private || { echo "Failed to create repository ${TGT_ORG}/${TGT_REPO}"; exit 1; }

# Remove all remotes.
for remote in $(git remote); do
    git remote remove "$remote"
done

# Step 4: Add the new repository as the 'origin' remote.
echo "Adding new remote 'origin' for ${TGT_ORG}/${TGT_REPO}..."
git remote add origin "https://github.com/${TGT_ORG}/${TGT_REPO}.git"

# Step 5: Squash all commits.
git checkout --orphan main
git add -A
git commit -am "Squashed all commits."
git branch -D master

# Step 6: Push all branches and tags to the new repository.
echo "Pushing only the main branch to ${TGT_ORG}/${TGT_REPO}..."
git push -u origin main

# Step 7: Remove the local clone.
echo "Removing the local cloned."
cd ..
rm -rf juice-shop

echo "Done. The repository has been cloned and reconfigured."
