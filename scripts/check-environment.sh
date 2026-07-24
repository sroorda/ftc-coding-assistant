#!/usr/bin/env bash
set -euo pipefail

if ! command -v java >/dev/null 2>&1; then
  echo "Java was not found. Install JDK 17 or newer, then try again."
  echo "On macOS, see docs/macos-setup.md."
  exit 1
fi

if ! command -v javac >/dev/null 2>&1; then
  echo "The Java compiler was not found. Install a full JDK, not only a JRE."
  echo "On macOS, see docs/macos-setup.md."
  exit 1
fi

echo "Java runtime:"
java -version
echo
echo "Java compiler:"
javac_version="$(javac -version 2>&1)"
echo "$javac_version"

version_number="${javac_version#javac }"
major_version="${version_number%%.*}"
if [[ "$major_version" == "1" ]]; then
  version_after_one="${version_number#1.}"
  major_version="${version_after_one%%.*}"
fi

if ! [[ "$major_version" =~ ^[0-9]+$ ]]; then
  echo "Could not determine the javac version from: $javac_version"
  exit 1
fi

if (( major_version < 17 )); then
  echo "JDK 17 or newer is required for the current FTC SDK; found javac $major_version."
  echo "See docs/macos-setup.md or docs/windows-setup.md."
  exit 1
fi
echo
echo "Environment looks ready. Run: ./scripts/run-lesson.sh 01"
