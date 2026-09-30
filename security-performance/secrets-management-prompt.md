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

1. **Scan for secrets in code** - Search the entire codebase for hardcoded
   API keys, tokens, passwords, connection strings, private keys, and any
   other sensitive values. Check: source files, config files, env files
   committed to the repo, Dockerfiles, CI configs, and test fixtures. Use
   pattern matching for common secret formats (AWS keys, JWT tokens,
   database URLs with passwords).
2. **Scan git history** - Check past commits for secrets that have been
   removed from the current code but remain in git history. Use `git log -p`
   with grep patterns, or a dedicated tool like `trufflehog` or `gitleaks`
   if available.
3. **Classify findings** - Categorize each finding by severity:
   - **Critical** - Active credentials that could grant access (API keys,
     database passwords, private keys)
   - **High** - Secrets in git history that need rotation
   - **Medium** - Placeholder or example secrets that should still be
     removed for hygiene
   - **Low** - Non-sensitive values that look like secrets but aren't
4. **Remediate** - For each finding:
   - Move the secret to an environment variable or secrets manager
   - Replace the hardcoded value with a reference to the env var
   - Update the code to read from the new source
   - Add the secret name to `.env.example` (without the value) so new
     contributors know what's needed
5. **Set up the pattern** - Create or update `.env.example` with all
   required secrets (names only, no values). Update `.gitignore` to exclude
   `.env` files. Document the secret setup process in the README.
6. **Verify** - Confirm no secrets remain in source code. If git history
   contains secrets, document the rotation plan (the actual rotation must
   happen out-of-band).

## Rules

- Never commit actual secret values as examples - use placeholder strings
  like `your-api-key-here`.
- Never log secrets or include them in error messages.
- If secrets are found in git history, do not just remove them from HEAD -
  they need rotation and history rewriting or acknowledgment.
- If the project uses a secrets manager (Vault, AWS Secrets Manager, etc.),
  integrate with it rather than introducing a new solution.
