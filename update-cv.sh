#!/usr/bin/env bash
# Sync the CV from the Dropbox CV folder into the website and publish it.
# Run this whenever you update your CV:  bash update-cv.sh
set -euo pipefail

CV_SOURCE="$HOME/Dropbox/CV/asr-vita.pdf"
REPO="$HOME/Library/CloudStorage/Dropbox-Personal/Projects/asrosenberg-site"
CV_DEST="$REPO/assets/asr-cv.pdf"

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
echo "CV updated and pushed. The live site refreshes in about a minute."
