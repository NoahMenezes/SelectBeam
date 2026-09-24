#!/usr/bin/env bash
#
# Create / update the full GitHub label set for SelectBeam.
#
# Usage:
#   gh auth login            # once
#   bun run labels           # or: bash scripts/setup-labels.sh
#   REPO=owner/repo bash scripts/setup-labels.sh   # target a different repo
#
# Idempotent: existing labels are updated in place (color + description).

set -euo pipefail

REPO_FLAG=()
if [ -n "${REPO:-}" ]; then
  REPO_FLAG=(-R "$REPO")
fi

upsert() {
  local name="$1" color="$2" desc="$3"
  if gh label create "$name" --color "$color" --description "$desc" "${REPO_FLAG[@]}" 2>/dev/null; then
    echo "created: $name"
  else
    gh label edit "$name" --color "$color" --description "$desc" "${REPO_FLAG[@]}"
    echo "updated: $name"
  fi
}

# Type (GitHub defaults, kept + refreshed)
upsert "bug" "d73a4a" "Something is not working"
upsert "documentation" "0075ca" "Docs need adding or fixing"
upsert "duplicate" "cfd3d7" "Already reported elsewhere"
upsert "enhancement" "a2eeef" "New feature or improvement"
upsert "good first issue" "7057ff" "Good for newcomers"
upsert "help wanted" "008672" "Help welcome from contributors"
upsert "invalid" "e4e669" "Not valid or cannot act on this"
upsert "question" "d876e3" "Needs an answer, not a code change"
upsert "wontfix" "ffffff" "Decided not to do this"

# Triage / status
upsert "needs triage" "fbca04" "New issue awaiting maintainer review"
upsert "confirmed" "0e8a16" "Reproduced by a maintainer"
upsert "needs repro" "f9d0c4" "Needs reproduction steps"
upsert "blocked" "6e7681" "Cannot proceed yet"

# Priority
upsert "priority: high" "b60205" "Should be fixed soon"
upsert "priority: medium" "d93f0b" "Should be fixed when possible"
upsert "priority: low" "c2e0c6" "Nice to have, no rush"

# Area (matches the Area field in the issue forms)
upsert "area: terminal" "1d76db" "Terminal-AI send path"
upsert "area: browser" "5319e7" "Browser-AI send path and app launcher"
upsert "area: companion" "7057ff" "Browser companion extension"
upsert "area: settings" "8760d4" "Configuration and settings"
upsert "area: docs" "0075ca" "README, guides, code notes"
upsert "area: infra" "57606a" "Build, CI, packaging, releases"

# OS
upsert "os: windows" "0078d4" "Windows-specific"
upsert "os: macos" "6e7681" "macOS-specific"
upsert "os: linux" "f66a0a" "Linux-specific"

# Browser (companion / tab-reuse issues)
upsert "browser: firefox" "ff7139" "Firefox family"
upsert "browser: chrome" "1a73e8" "Chrome, Opera, Vivaldi, Arc"
upsert "browser: edge" "00b7c3" "Microsoft Edge"
upsert "browser: brave" "fb542b" "Brave"

echo "Done."
