#!/bin/bash
set -euo pipefail

PLIST=IOSBuild/Info.plist
PB=/usr/libexec/PlistBuddy

"$PB" -c "Set :CFBundleShortVersionString 1.0" "$PLIST"
"$PB" -c "Set :CFBundleVersion ${GITHUB_RUN_NUMBER:-1}" "$PLIST"
"$PB" -c "Add :ITSAppUsesNonExemptEncryption bool false" "$PLIST" 2>/dev/null || \
  "$PB" -c "Set :ITSAppUsesNonExemptEncryption false" "$PLIST"

"$PB" -c "Print :CFBundleShortVersionString" "$PLIST"
"$PB" -c "Print :CFBundleVersion" "$PLIST"
"$PB" -c "Print :ITSAppUsesNonExemptEncryption" "$PLIST"
