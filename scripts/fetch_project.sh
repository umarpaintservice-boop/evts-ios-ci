#!/bin/bash
set -euo pipefail

# The Unity-exported Xcode project is published as a release asset on this repo
# (RAR5 archives cannot be extracted with the tools available on the runner).
ASSET_URL=${ASSET_URL:-https://github.com/umarpaintservice-boop/evts-ios-ci/releases/download/project-v1/IOSBuild.tar.gz}

curl -fL --retry 5 -o IOSBuild.tar.gz "$ASSET_URL"
ls -l IOSBuild.tar.gz
tar -xzf IOSBuild.tar.gz

test -d IOSBuild/Unity-iPhone.xcodeproj
du -sh IOSBuild
