#!/bin/bash

set -x

MAIN_BRANCH
MAIN_BRANCH="${MAIN_BRANCH:-master}"
CURRENT_BRANCH="$(git branch --show-current)"

TARGET_BRANCH=${1:-$CURRENT_BRANCH}
SOURCE_BRANCH=${2:-$MAIN_BRANCH}

if [[ "$CURRENT_BRANCH" == "$MAIN_BRANCH" ]]; then
  git pull --no-tags origin "$SOURCE_BRANCH"
else
  git fetch --no-tags origin "$SOURCE_BRANCH":"$SOURCE_BRANCH"
fi

git rebase "$SOURCE_BRANCH" "$TARGET_BRANCH"
