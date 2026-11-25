#!/usr/bin/env bash
# Create or update the standard labels (labels.yml) in the given repositories.
# Needs: gh (authenticated with write access to the repos), yq or python3.
set -euo pipefail

here=$(cd "$(dirname "$0")/.." && pwd)
[ $# -ge 1 ] || { echo "usage: $0 <owner/repo> [<owner/repo> ...]" >&2; exit 2; }

labels=$(python3 - "$here/labels.yml" <<'PY'
import json, re, sys
for line in open(sys.argv[1]):
    m = re.match(r"- \{name: (.+?),\s+color: (\w+), description: (.*)\}\s*$", line)
    if m:
        print(json.dumps({"name": m[1].strip(), "color": m[2], "description": m[3]}))
PY
)

for repo in "$@"; do
  echo "== $repo"
  while IFS= read -r l; do
    name=$(jq -r .name <<<"$l"); color=$(jq -r .color <<<"$l"); desc=$(jq -r .description <<<"$l")
    gh label create "$name" -R "$repo" --color "$color" --description "$desc" --force >/dev/null
    echo "  ok $name"
  done <<<"$labels"
done
