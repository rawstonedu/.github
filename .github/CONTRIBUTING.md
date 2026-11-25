# Contributing

Organisation-wide defaults. A repository can override any file here with its own copy.

## Flow: trunk-based

- `main` is the only long-lived branch. It is always releasable. There are **no** `develop`, `test` or per-environment branches; environments are selected by configuration or by a deploy workflow, not by branch.
- Work on a short-lived branch (`feat/<topic>`, `fix/<topic>`, `chore/<topic>`), open a pull request against `main`, merge when checks are green and a reviewer has approved. Squash-merge, then delete the branch.
- Keep branches small and short (days, not weeks). Rebase or merge `main` often.
- Never push to a branch whose pull request was already merged or closed. Cut a fresh branch from the current `main`.
- Use one worktree per parallel task instead of sharing a checkout.

## Commits and pull requests

- Imperative, specific titles ("Add retry to ETL loader", not "fixes").
- Fill in the pull request template: what, why, verification.
- Do not commit secrets. Secrets live in a secret store or are SOPS-encrypted; see the repository's own docs.
- Changes to infrastructure are made through the repository's Terraform pipeline, not by hand.

## Reviews

- Each repository has a `CODEOWNERS` file (it is not inherited from this repository).
- Reviewers check behaviour, tests, security and operability. Style is the linters' job.

## Labels

Standard labels are defined in [`labels.yml`](../labels.yml) and applied with `scripts/sync-labels.sh`.
