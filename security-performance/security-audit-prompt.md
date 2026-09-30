# Reusable prompt: security audit

Copy-paste the block below into any AI coding agent to run a disciplined
security review that produces verified findings, not FUD.

Keywords: security audit, vulnerability, owasp, penetration test, attack surface, review

---

Audit this repository for security vulnerabilities. Be rigorous and honest:
report real issues with evidence, and skip anything you can't verify. Your
findings are what the team will act on, so accuracy matters more than volume.

## Scope to cover

1. **Injection & input handling** - SQL/NoSQL injection, shell injection,
   command execution, path traversal, template injection, unsafe deserialization.
2. **Authentication & authorization** - broken auth, default/weak credentials,
   missing authorization checks, privilege escalation, session handling.
3. **Data exposure** - secrets and API keys committed in the repo or in git
   history, sensitive data in logs, responses exposing internal details,
   insecure storage/transmission (HTTP, no TLS).
4. **Web-specific** - the OWASP Top 10 as it applies to the code: XSS, CSRF,
   SSRF, open redirects, insecure headers, IDOR.
5. **Dependencies** - known-vulnerable packages (run the repo's dependency
   scanner if configured, e.g. `npm audit`, `pip-audit`, `gh security`).
6. **Configuration** - over-permissive permissions, debug mode enabled,
   unsafe defaults, missing rate limiting/input validation.

## Method

- Read the actual code; trace untrusted input from entry point to sink. Do not
  claim a vulnerability without showing the path.
- Verify each finding yourself (run commands, check configs, read docs) before
  reporting it. For secrets in history, confirm with `git log -p` and
  `git rev-list --all`.
- Assess real-world exploitability and severity (Critical/High/Medium/Low),
  not just theoretical risk.

## Output

A findings report, each item with: the vulnerability, the evidence (file:line
and the code path), severity, real-world impact, and a concrete fix. End with
a prioritized fix list and any quick wins. Be clear about what was checked and
found clean.

## Rules

- Do **not** change code, push fixes, or rotate secrets without explicit
  approval - report first.
- Never redact or dismiss a real finding because it's awkward. Report it
  plainly.
- If something looks vulnerable but you can't confirm the path, mark it as
  "needs confirmation" rather than a confirmed finding.
