#!/bin/bash
# Install https://cli.github.com first
gh extension install mislav/gh-repo-collab

SRC_ORG="juice-shop"
SRC_REPO="juice-shop"
TGT_ORG="NavaraLabs"
TGT_REPO="joostvoskuil,jorismolenaar"  # comma separated list
rm -rf juice-shop

echo "Cloning repository ${SRC_ORG}/${SRC_REPO}..."
gh repo clone "${SRC_ORG}/${SRC_REPO}" -- --depth=1 || { echo "Failed to clone ${SRC_ORG}/${SRC_REPO}"; exit 1; }

cd "${SRC_REPO}" || { echo "Directory ${SRC_REPO} not found"; exit 1; }

echo "Creating new repositories..."
IFS=',' read -ra repos <<< "$TGT_REPO"
for repo in "${repos[@]}"; do
    repo=$(echo "$repo" | xargs)  # trim whitespace
    echo "Creating new repository ${TGT_ORG}/${repo}..."
    gh repo create "${TGT_ORG}/${repo}" -y --private || { echo "Failed to create repository ${TGT_ORG}/${repo}"; exit 1; }
done

echo "Remove all stuff that we don't need"
rm -rf .git
rm -rf .github/workflows
rm -rf .dependabot
rm -rf .gitlab
rm -rf data/static/codefixes

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

echo "Pushing the content to each repository"
for repo in "${repos[@]}"; do
    repo=$(echo "$repo" | xargs)  # trim whitespace
    echo "Adding remote 'origin-${repo}' for ${TGT_ORG}/${repo}..."
    git remote add "origin-${repo}" "https://github.com/${TGT_ORG}/${repo}.git"
    git push -u "origin-${repo}" main
    git remote remove "origin-${repo}"
    
    # Grant admin permissions to the user
    echo "Granting admin permissions to ${repo} on ${TGT_ORG}/${repo}..."
    gh repo-collab add "${TGT_ORG}/${repo}" "${repo}" --permission admin
done

echo "Removing the local cloned."
cd ..
rm -rf juice-shop

echo "Done. The repository has been cloned and reconfigured."
