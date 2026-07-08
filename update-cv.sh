#!/usr/bin/env bash
# Sync the CV from the Dropbox CV folder into the website and publish it.
#
# Run manually:   bash update-cv.sh
# Runs automatically via the launchd agent com.asrosenberg.cv-sync
# whenever ~/Dropbox/CV/asr-vita.pdf changes.
set -euo pipefail

# Ensure git and gh are found even under launchd's minimal environment.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

CV_SOURCE="$HOME/Library/CloudStorage/Dropbox-Personal/CV/asr-vita.pdf"
REPO="$HOME/Library/CloudStorage/Dropbox-Personal/Projects/asrosenberg-site"
CV_DEST="$REPO/assets/asr-cv.pdf"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] update-cv.sh starting"

if [ ! -f "$CV_SOURCE" ]; then
  echo "Could not find the CV at $CV_SOURCE"
  exit 1
fi

cp "$CV_SOURCE" "$CV_DEST"
cd "$REPO"

if git diff --quiet -- assets/asr-cv.pdf; then
  echo "The website CV already matches $CV_SOURCE — nothing to do."
  exit 0
fi

git add assets/asr-cv.pdf
git commit -m "Update CV"
git push
echo "[$(date '+%Y-%m-%d %H:%M:%S')] CV updated and pushed."
