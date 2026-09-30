# Reusable prompt: CI/CD pipeline builder

Copy-paste the block below into any AI coding agent to build a GitHub Actions
pipeline that is correct, secure, and actually verified.

Keywords: ci, cd, pipeline, github actions, workflow, automation, build pipeline

---

Create a CI/CD pipeline for **this** repository using GitHub Actions. Do not
ask which repo - use the current one. The pipeline must be fully automatic and
enforce the constraints below.

## Output

One or more workflow files under `.github/workflows/`. Prefer official
`actions/*` steps over third-party actions. If you write custom logic, use
bash with the GitHub CLI (`gh`) - no unchecked third-party actions.

## Default pipeline (adjust to the repo's actual stack)

- **CI**: on `push` and `pull_request` - install dependencies, run lint,
  format, type checks, and the test suite using the repo's own tooling.
  Cache dependencies where supported. Fail fast on the first broken job.
- **Coverage**: if the repo has a coverage tool, run it and upload the report.
- **Security**: run a dependency/secret scan if one is already configured;
  otherwise note it as a recommendation, don't add a heavy new tool without
  being asked.

## Hard constraints (non-negotiable)

- Never execute untrusted code in a privileged context. For pull requests from
  forks, use `pull_request_target` **only** if the workflow needs a
  write-scoped token, and in that case never `checkout` or run code from the
  PR - only read metadata and post statuses/comments. Say so in a header
  comment.
- Never string-interpolate user-derived values into `bash -c` or command
  strings that could be injected. Pass them via environment variables.
- Never commit secrets to the repository. Use repository secrets/variables for
  anything sensitive, and read them via `${{ secrets.X }}` or env vars.
- Pin third-party actions to a full-length commit SHA (not a branch/tag) or
  explain why an official `actions/*` tag is acceptable.
- Add `concurrency:` groups so rapid repeated events cancel or queue instead
  of running duplicate jobs.

## Verification (required before finishing)

1. Confirm each YAML file parses (e.g. `python -c "import yaml,sys; yaml.safe_load(open(...))"` or a YAML lint).
2. Extract each `run:` block and syntax-check with `bash -n`.
3. Dry-run any read-only logic against the real repo to confirm queries and
   commands return sensible results. Do NOT perform write operations during
   verification.
4. If the repo already has CI, ensure your pipeline does not duplicate or
   conflict with it - reconcile rather than replace.
5. Confirm commit-message style follows the repo's conventions (Conventional
   Commits) if committing.
