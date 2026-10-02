# Reusable prompt: CI/CD pipeline builder [spec]

Copy-paste the block below into any AI coding agent to build a GitHub Actions
pipeline that is correct, secure, and actually verified.

Keywords: ci, cd, pipeline, github actions, workflow, automation, build pipeline

---

Create a CI/CD pipeline for **this** repository using GitHub Actions. Do not
ask which repo - use the current one. The pipeline must be fully automatic and
enforce the constraints below.

## Define the scope first

State these before writing a workflow file. A pipeline built on guessed tooling
fails on the first run.

1. **The stack** - Languages, package managers, and build tools actually present
   in the repo, read from its manifest and lock files. Do not assume a stack.
2. **The existing gates** - Every workflow, task runner, Makefile, or script
   the repo already uses for lint, format, typecheck, and tests. Your pipeline
   calls these rather than reinventing them.
3. **Events** - Which triggers are needed (`push`, `pull_request`, tags,
   schedule, manual dispatch) and why each one exists.
4. **Secret handling** - Which steps need repository secrets or variables, and
   the least-privileged scope that supplies them.
5. **Out of scope** - Deploys, release publishing, and new third-party tooling
   you are not asked to add. Note them as recommendations instead.

## What to produce

One or more workflow files under `.github/workflows/`. Prefer official
`actions/*` steps over third-party actions. If you write custom logic, use
bash with the GitHub CLI (`gh`) - no unchecked third-party actions.

- **CI**: on `push` and `pull_request` - install dependencies, run lint,
  format, type checks, and the test suite using the repo's own tooling.
  Cache dependencies where supported. Fail fast on the first broken job.
- **Coverage**: if the repo has a coverage tool, run it and upload the report.
- **Security**: run a dependency/secret scan if one is already configured;
  otherwise note it as a recommendation, don't add a heavy new tool without
  being asked.

## Method

1. **Read the repo before writing YAML** - Inspect the manifests, lock files,
   existing workflows, and CI config. Every command you put in a `run:` block
   must already exist in the repo or be the documented way to invoke its tool.
2. **Reconcile, do not replace** - If the repo already has CI, extend it and
   remove genuine duplication rather than adding a parallel pipeline that
   competes with it.
3. **Least privilege by default** - Set top-level `permissions:` to read-only
   and grant write scopes only to the job that needs them.
4. **Pin every third-party action** - Use a full-length commit SHA, not a
   branch or tag, and say why an official `actions/*` tag is acceptable.
5. **Keep fork PRs unprivileged** - `pull_request_target` only where a
   write-scoped token is genuinely required, and in that case never
   `checkout` or run code from the PR - read metadata and post statuses only.
   Explain the choice in a header comment.
6. **Pass values through the environment** - Never string-interpolate
   user-derived values into `bash -c` or command strings. Use env vars.

## Verification

- [ ] Every YAML file parses (`python -c "import yaml; yaml.safe_load(...)"` or
      a YAML lint) and no file was written by hand without parsing it.
- [ ] Every `run:` block was extracted and syntax-checked with `bash -n`.
- [ ] Every command in a `run:` block was found in the repo's own tooling or
      confirmed to be the documented invocation for the tool.
- [ ] Read-only logic was dry-run against the real repo; no write operation was
      performed during verification.
- [ ] Existing CI was reconciled, not duplicated or replaced.
- [ ] Every third-party action is pinned to a full-length SHA, or the reason an
      official tag is acceptable is written down.
- [ ] `permissions:` is least-privilege, and `concurrency:` groups cancel or
      queue duplicate runs.
- [ ] No secret is committed; sensitive values come from secrets or variables.

## Rules

- Never execute untrusted code in a privileged context. Fork PRs run
  unprivileged; `pull_request_target` is the exception that needs a stated
  justification.
- Never string-interpolate user-derived values into shell command strings.
  Pass them via environment variables.
- Never commit secrets to the repository. Use repository secrets/variables for
  anything sensitive, and read them via `${{ secrets.X }}` or env vars.
- Never pin a third-party action to a branch or tag when a full-length SHA is
  available.
- Never add a heavy new tool to the pipeline unasked; recommend it instead.
- Never duplicate a gate the repo already runs. Reconcile with it.
