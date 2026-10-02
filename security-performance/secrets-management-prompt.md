# Reusable prompt: secrets management

Copy-paste the block below into any AI coding agent to audit and remediate
hardcoded secrets - find them, remove them, and set up proper secret
management.

Keywords: secrets, api keys, credentials, key rotation, environment variables, vault

---

Audit this repository for hardcoded secrets and set up proper secret
management. The goal: no secrets in code, no secrets in git history, and a
clear pattern for handling secrets going forward.

## Steps

1. **Scan code and history** - Search the whole codebase for hardcoded API
   keys, tokens, passwords, connection strings, and private keys: source,
   config, committed env files, Dockerfiles, CI configs, test fixtures. Then
   scan git history for secrets already removed from HEAD, with `git log -p`
   plus grep patterns or a scanner such as `trufflehog` or `gitleaks`.
2. **Classify every finding** - Rank by severity: **Critical** - active
   credentials that could grant access (API keys, database passwords, private
   keys); **High** - secrets in git history needing rotation; **Medium** -
   placeholder or example secrets still worth removing for hygiene; **Low** -
   values that only look like secrets.
3. **Remediate and set the pattern** - Move each secret to an environment
   variable or secrets manager, replace the hardcoded value with a reference,
   update the code to read from the new source, list every required name in
   `.env.example` with no values, ignore `.env` in `.gitignore`, and document
   the setup process in the README.
4. **Verify** - Re-scan source and confirm nothing remains. If git history
   holds secrets, document the rotation plan; the actual rotation happens
   out-of-band.

## Verification

- [ ] The whole codebase and the git history were both scanned, with the
      scanner named.
- [ ] Every finding is classified by severity and live-versus-example.
- [ ] Any real secret found in history was revoked or rotated, not merely
      deleted from HEAD.
- [ ] `.env.example` lists every variable the app needs, with placeholder
      values only.
- [ ] No secret value appears in source, logs, or error messages.
- [ ] A re-scan confirms nothing remains, with output shown.

## Rules

- Never commit actual secret values as examples - use placeholder strings like
  `your-api-key-here`.
- Never log secrets or include them in error messages.
- If secrets are found in git history, do not just remove them from HEAD - they
  need rotation and history rewriting or acknowledgment.
- If the project uses a secrets manager (Vault, AWS Secrets Manager, etc.),
  integrate with it rather than introducing a new solution.
