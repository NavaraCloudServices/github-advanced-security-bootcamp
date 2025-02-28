# Install required GitHub CLI extension
#gh extension install mislav/gh-repo-collab

# Repository and organization settings
$SRC_ORG = "juice-shop"
$SRC_REPO = "juice-shop"
$TGT_ORG = "NavaraLabs"
$TGT_REPO = "joostvoskuil,jorismolenaar"  # comma separated list of users

# Remove existing directory if it exists
if (Test-Path -Path $SRC_REPO) {
    Remove-Item -Path $SRC_REPO -Recurse -Force
}

Write-Host "Cloning repository ${SRC_ORG}/${SRC_REPO}..."
gh repo clone "${SRC_ORG}/${SRC_REPO}" -- --depth=1
if (-not $?) {
    Write-Error "Failed to clone ${SRC_ORG}/${SRC_REPO}"
    exit 1
}

Set-Location -Path $SRC_REPO
if (-not $?) {
    Write-Error "Directory ${SRC_REPO} not found"
    exit 1
}

Write-Host "Creating new repositories..."
$repos = $TGT_REPO.Split(',') | ForEach-Object { $_.Trim() }
foreach ($repo in $repos) {
    Write-Host "Creating new repository ${TGT_ORG}/${repo}..."
    gh repo create "${TGT_ORG}/${repo}" -y --private
    if (-not $?) {
        Write-Error "Failed to create repository ${TGT_ORG}/${repo}"
        exit 1
    }
}

Write-Host "Remove all stuff that we don't need"
if (Test-Path -Path ".git") { Remove-Item -Path ".git" -Recurse -Force }
if (Test-Path -Path ".github\workflows") { Remove-Item -Path ".github\workflows" -Recurse -Force }
if (Test-Path -Path ".dependabot") { Remove-Item -Path ".dependabot" -Recurse -Force }
if (Test-Path -Path ".gitlab") { Remove-Item -Path ".gitlab" -Recurse -Force }
if (Test-Path -Path "data\static\codefixes") { Remove-Item -Path "data\static\codefixes" -Recurse -Force }

Write-Host "Reinitializing the repository..."
git init
git branch -m master main
git checkout -b main

# Create a new file with some content
"This is the content of the new file." | Out-File -FilePath "TEMP.md" -Encoding utf8
git add TEMP.md
git commit -m "Add TEMP.md"

Write-Host "Pushing the content"
git add -A
git commit -m "Initial commit"

Write-Host "Pushing the content to each repository"
foreach ($repo in $repos) {
    Write-Host "Adding remote 'origin-${repo}' for ${TGT_ORG}/${repo}..."
    git remote add "origin-${repo}" "https://github.com/${TGT_ORG}/${repo}.git"
    git push -u "origin-${repo}" main
    git remote remove "origin-${repo}"
    
    # Grant admin permissions to the user
    Write-Host "Granting admin permissions to ${repo} on ${TGT_ORG}/${repo}..."
    gh repo-collab add "${TGT_ORG}/${repo}" "${repo}" --permission admin
}

Write-Host "Removing the local cloned repository"
Set-Location -Path ..
Remove-Item -Path $SRC_REPO -Recurse -Force

Write-Host "Done. The repository has been cloned and reconfigured."
