# Reusable prompt: release automation

Copy-paste the block below into any AI coding agent to automate versioning,
tagging, changelog generation, and publishing - a reliable release pipeline,
not a manual checklist.

Keywords: release automation, versioning, tag, publish, semver, cut a release, npm publish

---

Automate the release process for this repository. The goal: a CI-driven
pipeline that versions, tags, changelogs, and publishes releases consistently,
with no manual steps that can be forgotten.

## Steps

1. **Understand the current process** - Read CHANGELOG.md, package.json version
   fields, existing workflows, Makefile targets, and publish scripts, and note
   how releases happen today.
2. **Choose a versioning strategy** - SemVer for libraries with a public API,
   CalVer for date-based application releases, Keep a Changelog for the
   CHANGELOG format. Document the choice in the README or CONTRIBUTING.
3. **Set up version bumping** - Configure `semantic-release`, `release-please`,
   `changesets`, `bump2version`, or a custom script to read conventional
   commits, determine the bump type, update every version field, and update the
   CHANGELOG.
4. **Automate tagging and releases** - On a version bump, create and push a tag
   plus a GitHub release whose notes are generated from commits since the last
   tag, using the repo's CI platform.
5. **Automate publishing** - If the project publishes to npm, PyPI, or
   crates.io, add a publish step after tagging, with credentials from secrets
   rather than hardcoded.
6. **Verify** - Run a test release on a fork or pre-release tag and confirm
   version bump, changelog, tag, release, and publish all work end to end.

## Verification

- [ ] The existing release process was read and reconciled, not replaced.
- [ ] The versioning strategy is stated with its rationale, and matches the
      project's type.
- [ ] No version number is hardcoded in the workflow; the tool derives it.
- [ ] A tag creates the GitHub release and the changelog entry in one step.
- [ ] Every publish target runs, or a failure in one does not silently skip the
      others.
- [ ] A test release was actually run on a fork or pre-release tag, with its
      output shown.

## Rules

- Never hardcode version numbers in the release workflow - the tool must
  calculate them from commits or config.
- Never skip the changelog step - users and contributors rely on it.
- Never publish to a public registry without a tag and release notes.
- If the project has multiple publish targets (e.g. npm + Docker), all must be
  part of the same release workflow.
