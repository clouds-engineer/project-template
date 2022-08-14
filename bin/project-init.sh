#!/usr/bin/env bash
###############################################################################
git clone --depth=1 "$PROJECT_TEMPLATE_REPO" "${PROJECT_DIR}"

cd "${PROJECT_DIR}" || exit 1

###############################################################################
# Remove ".git" folder recursively
rm -rf .git
# Copy examples to original files, ready to edit.
cp .envrc.example .envrc
cp .env.example .env
# Only owner should be able to modify.
find .envrc -type f -exec chmod 600 {} \;
find .env -type f -exec chmod 600 {} \;
find .kubeconfig -type f -exec chmod 600 {} \;
find .ssh -type d -exec chmod 700 {} \;
find .ssh -type f -exec chmod 600 {} \;
find .vault -type d -exec chmod 700 {} \;
find .vault -type f -exec chmod 600 {} \;

###############################################################################
# initialize the new project repository
git init

###############################################################################

