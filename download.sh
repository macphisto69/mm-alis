#!/usr/bin/env bash
#shellcheck disable=SC2034
#SC2034: foo appears unused. Verify it or export it.
set -eu

# Arch Linux Install Script (alis) installs unattended, automated
# and customized Arch Linux system.
# Copyright (C) 2022 picodotdev

GITHUB_USER="macphisto69"
BRANCH="main"
HASH=""
ARTIFACT="mm-alis-${BRANCH}"

while getopts "b:h:u:" arg; do
  case ${arg} in
    b)
      BRANCH="${OPTARG}"
      ARTIFACT="mm-alis-${BRANCH}"
      ;;
    h)
      HASH="${OPTARG}"
      ARTIFACT="mm-alis-${HASH}"
      ;;
    u)
      GITHUB_USER=${OPTARG}
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

set -o xtrace
if [ -n "$HASH" ]; then
  curl -sL -o "${ARTIFACT}.zip" "https://github.com/${GITHUB_USER}/mm-alis/archive/${HASH}.zip"
  bsdtar -x -f "${ARTIFACT}.zip"
  cp -R "${ARTIFACT}"/*.sh "${ARTIFACT}"/*.conf "${ARTIFACT}"/files/ "${ARTIFACT}"/configs/ ./
else
  curl -sL -o "${ARTIFACT}.zip" "https://github.com/${GITHUB_USER}/mm-alis/archive/refs/heads/${BRANCH}.zip"
  bsdtar -x -f "${ARTIFACT}.zip"
  cp -R "${ARTIFACT}"/*.sh "${ARTIFACT}"/*.conf "${ARTIFACT}"/files/ "${ARTIFACT}"/configs/ ./
fi
chmod +x configs/*.sh
chmod +x ./*.sh
