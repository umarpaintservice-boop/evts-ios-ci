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

# Unity pins a development signing identity, which makes an App Store archive ask
# for a development profile. Clear it so automatic signing picks distribution.
PBX=IOSBuild/Unity-iPhone.xcodeproj/project.pbxproj
sed -i '' 's/CODE_SIGN_IDENTITY = "iPhone Developer"/CODE_SIGN_IDENTITY = ""/g; s/"CODE_SIGN_IDENTITY\[sdk=iphoneos\*\]" = "iPhone Developer"/"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = ""/g' "$PBX"
grep -c 'CODE_SIGN_IDENTITY' "$PBX"
