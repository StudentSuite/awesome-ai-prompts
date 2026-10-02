# Git & GitHub

Prompts for the git and GitHub workflow: history, branches, CI, releases, reviews, and keeping an open source project running.

Prompts carrying the light-blue badge are the heavyweight
[spec](../README.md#git--github) prompts: multi-section, with
hard constraints and required verification.

Back to the [main index](../README.md#git--github) or browse
[every prompt on one page](../ALL_PROMPTS.html).

## Prompts

- [git-history-surgery-prompt.md](git-history-surgery-prompt.md) - safe history editing, bisect, blame, and recovery via reflog.
- [open-source-contribution-prompt.md](open-source-contribution-prompt.md) - contribute to an OSS repo the maintainer-friendly way.
- [ci-cd-workflow-prompt.md](ci-cd-workflow-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - build a verified, secure GitHub Actions pipeline.
- [dependency-upgrade-prompt.md](dependency-upgrade-prompt.md) - upgrade a dependency safely: changelog, migration, full verification.
- [good-first-issue-workflow-prompt.md](good-first-issue-workflow-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - GitHub Actions workflow reserving starter issues for first-time contributors.
- [git-bisect-debug-prompt.md](git-bisect-debug-prompt.md) - use git bisect to find the exact commit that introduced a bug.
- [release-automation-prompt.md](release-automation-prompt.md) - automate versioning, tagging, changelogs, and publishing with CI.
- [commit-checklist-prompt.md](commit-checklist-prompt.md) - build deterministic PR gates that keep indexes, changelogs, and counts in sync.
- [pr-review-prompt.md](pr-review-prompt.md) <img src="../docs/media/spec-badge.svg" alt="spec" style="vertical-align:-3px"> - thorough PR review: verify claims, run checks, clear verdict, merge-ready.
- [issue-triage-for-maintainers-prompt.md](issue-triage-for-maintainers-prompt.md) - turn an untriaged backlog into labeled, prioritized, answerable queues.
- [issue-resolving-prompt.md](issue-resolving-prompt.md) - resolve a GitHub issue end-to-end: reproduce the failure, prove the root cause, land a minimal fix with a regression test, and verify against the project's checks.
- [open-source-maintainer-survival-prompt.md](open-source-maintainer-survival-prompt.md) - harden maintenance practices: guidelines, automation, kind declines, bus factor, handoff.

## Adding a prompt here

Read [CONTRIBUTING.md](../CONTRIBUTING.md) for the file format and the gates,
model the new file on a neighbor in this folder, and add a one-line entry
above plus a [CHANGELOG.md](../CHANGELOG.md) entry under `[Unreleased]`.
