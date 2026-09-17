#!/bin/bash
set -euo pipefail

mkdir -p build

xcodebuild -project IOSBuild/Unity-iPhone.xcodeproj \
  -scheme Unity-iPhone \
  -configuration Release \
  -sdk iphoneos \
  -destination 'generic/platform=iOS' \
  -archivePath build/EVTS.xcarchive \
  -allowProvisioningUpdates \
  -authenticationKeyPath "$HOME/private_keys/AuthKey_$ASC_KEY_ID.p8" \
  -authenticationKeyID "$ASC_KEY_ID" \
  -authenticationKeyIssuerID "$ASC_ISSUER_ID" \
  DEVELOPMENT_TEAM="$TEAM_ID" \
  CODE_SIGN_STYLE=Automatic \
  PRODUCT_BUNDLE_IDENTIFIER=com.evts.tradegame \
  archive | tee build/archive.log | tail -40

test -d build/EVTS.xcarchive/Products/Applications
