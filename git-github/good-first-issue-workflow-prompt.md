# Reusable prompt: good-first-issue guard workflow [spec]

Copy-paste the block below into any AI coding agent to build the same
good-first-issue enforcement workflow for a different repository.

Keywords: good first issue, beginner contributor, newcomer, label guard, scoping, first pr

---

Create a GitHub Actions workflow for **this** repository that reserves
starter-labeled issues (`good first issue` and `help wanted`) for first-time
contributors. The workflow must run fully automatically with no manual
approval, and enforce the rules below. Do not ask the user which repo - use
the current one.

## Define the scope first

The policy this workflow implements: two labels are reserved for contributors
submitting their **first PR** to the repo - `good first issue` and
`help wanted`. Together they cover the explicit kinds of issues a newcomer can
realistically ship: documentation, tests, small bug fixes, and scoped UI/UX,
performance, and devops chores. Any experienced contributor (>=1 merged PR
here) who grabs one is unassigned and their PR is closed, with a note to pick an
**unreserved** issue instead. First-time assignees get a welcome comment and
keep the issue unless their assignment goes stale, at which point it is released
back to the pool.

State the following configuration explicitly before writing the workflow, using
these defaults unless told otherwise.

1. **Labels to protect** (reserved for first-timers): `good first issue` and
   `help wanted`.
2. **Where experienced contributors go** - any **unreserved** issue (the old
   "pick a help wanted issue instead" advice no longer applies: `help wanted`
   is itself reserved).
3. **Definition of "first-time contributor"** - has **0 merged PRs** authored by
   them in this repo (query via `gh pr list --state merged --author "<login>"
--limit 1`; beware the `commits?author=` API 422ing for users with no
   GitHub activity - don't use it).
4. **Who is exempt** - the repo owner and anyone with collaborator access (use
   `author_association` if available on the event, else the collaborators API
   `repos/{owner}/{repo}/collaborators/{login}` returning 204 means exempt).
5. **Staleness window** `GFI_STALE_DAYS`, default **14 days**: a first-time
   assignee with no open PR referencing the issue after that long is unassigned
   and the issue returns to the pool.
6. **Out of scope** - no issue triage or auto-labeling, no assignment of
   unreserved issues, and no changes to the repo's label set beyond reading it.

## What to produce

A single workflow file at `.github/workflows/good-first-issue.yml`, written
in bash using the GitHub CLI (`gh`), with **no third-party actions and no
`checkout` step** anywhere. Three jobs:

1. **Per-assignment guard** - runs on `issues: types: [assigned]`, and only
   acts when the issue carries a protected label.
2. **Per-PR guard** - runs on `pull_request_target: types: [opened,
reopened]` and inspects claim references in the PR body.
3. **Periodic on-demand sweep** - runs on `schedule: cron: "0 */6 * * *"` and
   `workflow_dispatch`, and enforces the policy retroactively.

## Method

All comments (welcome, policy, close, stale) must spell out the **explicit
kinds of issues** the reserved labels cover - documentation, tests, small bug
fixes, and scoped UI/UX, performance, and devops chores - and, for experienced
contributors, point them at unreserved work (e.g. larger features,
architecture, security hardening, cross-platform/CI overhauls) instead.

1. **When someone gets assigned to a protected issue**:
   - Assignee is first-time -> post a friendly welcome comment once (dedupe
     with a hidden HTML-comment marker in the comment body).
   - Assignee is experienced -> remove them (`DELETE
.../issues/{n}/assignees`), post a polite comment explaining the policy,
     and **close without merging** any PRs authored by that person that
     reference the issue (find them via the issue's timeline
     `cross-referenced` events filtered to PRs and matching author).
2. **When a PR is opened that claims a protected issue**: parse the PR body for
   claim refs ONLY - regex
   `(close|closes|closed|fix|fixes|fixed|resolve|resolves|resolved)\s+#\d+`
   (case-insensitive) so a `#N` in prose or code fences is ignored. If any
   referenced issue has either protected label and the author is experienced ->
   close the PR without merging + comment. Skip owners/members/collaborators.
3. **Periodic sweep** - the backstop that catches everything the event triggers
   miss, so it must do three things:
   - **Assignment enforcement**: search all open protected issues (union of
     both labels - note `gh search issues` ANDs multiple `--label` flags, so
     run one search per label and `sort -u`), and for any assigned to a
     non-exempt experienced contributor, apply the same unassign + comment +
     close-linked-PRs logic. This catches issues labeled after assignment and
     unassign/reassign dodging.
   - **Retroactive PR-claim sweep**: enumerate every open PR, extract claim
     refs from the body (same regex as rule 2), and close any PR by an
     experienced non-exempt author that claims a protected issue. This closes
     PRs opened **before** the workflow existed and authors who became
     "experienced" after opening their PR - the event trigger alone never
     sees either case.
   - **Staleness release**: for a protected issue held by a **first-time**
     assignee, find their last `assigned` timeline event (dedupe by
     assignee), and if it is older than `GFI_STALE_DAYS` **and** they have no
     **open** PR referencing the issue, unassign them (comment with a
     `good-first-issue-stale` marker) so the issue is freed up. Never release
     an assignee who has an open PR on the issue.

## Verification

- [ ] The YAML parses.
- [ ] Every `run:` block was extracted and syntax-checked with `bash -n`.
- [ ] The merged-PR count query returns `0`/`1` for known users.
- [ ] The claim-ref regex extracts the right issue numbers from real PR
      bodies, ignoring a `#N` in prose or a code fence.
- [ ] The timeline cross-reference query works.
- [ ] The sweep searches return results for both labels (run one search per
      label) and for the open-PR enumeration.
- [ ] No write operation was performed during verification: every `gh` write
      call is guarded with `|| true` and was dry-run read-only only.
- [ ] There is no `checkout` step and no third-party action in the file.
- [ ] Commit-message style follows the repo's conventions (Conventional
      Commits) if committing.

## Rules

- `pull_request_target` runs with a write-scoped token on fork PRs, so the
  workflow **must never checkout or execute code from the PR**. It may only
  read issue/PR metadata and write comments, unassignments, and closes. Keep
  it that way and say so in a header comment. This is also why shared logic is
  duplicated inline across jobs instead of being factored into a script file
  that would require a checkout.
- Never string-interpolate user-derived values into commands that could be
  injected. Pass them to `gh` via environment or shell variables.
- Never release a first-time assignee who has an open PR on the issue.
- Never close an issue or PR owned by the repo owner or a collaborator.
- Set `permissions: { issues: write, pull-requests: write }` and run with
  `GH_TOKEN: ${{ github.token }}`, `GH_REPO: ${{ github.repository }}`.
- Add `concurrency:` groups (per issue / per PR / one shared sweep group) so
  repeated events can't double-comment.
