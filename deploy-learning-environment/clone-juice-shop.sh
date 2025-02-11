#!/bin/bash
SRC_ORG="juice-shop"
SRC_REPO="juice-shop"
TGT_ORG="NavaraLabs"
TGT_REPO="joost-juice-shop10"

echo "Cloning repository ${SRC_ORG}/${SRC_REPO}..."
gh repo clone "${SRC_ORG}/${SRC_REPO}" -- --depth=1 || { echo "Failed to clone ${SRC_ORG}/${SRC_REPO}"; exit 1; }

cd "${SRC_REPO}" || { echo "Directory ${SRC_REPO} not found"; exit 1; }

echo "Creating new repository ${TGT_ORG}/${TGT_REPO}..."
gh repo create "${TGT_ORG}/${TGT_REPO}" -y --private || { echo "Failed to create repository ${TGT_ORG}/${TGT_REPO}"; exit 1; }

echo "Remove all stuff that we don't need"
rm -rf .git
rm -rf .github/workflows
rm -rf .dependabot
rm -rf .gitlab

echo "Reinitializing the repository..."
git init
git branch -m master main
git checkout -b main

# Create a new file with some content
echo "This is the content of the new file." > TEMP.md
git add TEMP.md
git commit -m "Add TEMP.md"

echo "Pushing the content"
git add -A
git commit -m "Initial commit"

echo "Adding new remote 'origin' for ${TGT_ORG}/${TGT_REPO}..."
git remote add origin "https://github.com/${TGT_ORG}/${TGT_REPO}.git"

git push -u origin main

echo "Removing the local cloned."
cd ..
rm -rf juice-shop

echo "Done. The repository has been cloned and reconfigured."
