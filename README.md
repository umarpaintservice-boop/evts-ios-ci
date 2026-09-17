# EVTS iOS build and TestFlight upload

Builds the Unity-exported Xcode project (bundle id `com.evts.tradegame`) on a GitHub-hosted
macOS runner and uploads it to TestFlight. The 1.4 GB Unity project is not stored in this repo;
it is downloaded at build time from the five-part RAR archive in Google Drive.

## Required repository secrets

| Secret | Value |
| --- | --- |
| `ASC_KEY_ID` | App Store Connect API key ID |
| `ASC_ISSUER_ID` | App Store Connect API issuer ID |
| `ASC_KEY_P8` | Full contents of the `AuthKey_*.p8` file |
| `TEAM_ID` | Apple Developer team ID |
| `DRIVE_PART_IDS` | Space-separated Google Drive file IDs for `part-00` … `part-04`, in order |

## Run

Actions → "EVTS iOS build and TestFlight upload" → Run workflow.

The archive step uses automatic signing with `-allowProvisioningUpdates`, so the distribution
certificate and provisioning profile are created by Xcode through the API key. The app record
must already exist in App Store Connect for the same bundle id.
