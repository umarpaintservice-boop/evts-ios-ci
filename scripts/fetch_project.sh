#!/bin/bash
set -euo pipefail

# DRIVE_PART_IDS: space separated Google Drive file IDs of BBTM_EVTS_iOS_Xcode_Build.rar.part-00 .. part-04
mkdir -p parts
i=0
for id in $DRIVE_PART_IDS; do
  n=$(printf '%02d' "$i")
  curl -fL --retry 5 -o "parts/part-$n" \
    "https://drive.usercontent.google.com/download?id=$id&export=download&confirm=t"
  i=$((i + 1))
done

cat parts/part-* > ios.rar
ls -l ios.rar

extract() {
  if command -v unrar >/dev/null 2>&1; then
    unrar x -o+ -idq ios.rar && return 0
  fi
  if command -v 7zz >/dev/null 2>&1; then
    7zz x -y ios.rar >/dev/null && return 0
  fi
  return 1
}

extract || {
  brew install --cask rar || brew install sevenzip
  hash -r
  extract
}

test -d IOSBuild/Unity-iPhone.xcodeproj
du -sh IOSBuild
