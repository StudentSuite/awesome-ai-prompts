# Reusable prompt: security audit [spec]

Copy-paste the block below into any AI coding agent to run a disciplined
security review that produces verified findings, not FUD.

Keywords: security audit, vulnerability, owasp, penetration test, attack surface, review

---

Audit `[the repository, service, or directory under review]` for security
vulnerabilities. Be rigorous and honest:
report real issues with evidence, and skip anything you can't verify. Your
findings are what the team will act on, so accuracy matters more than volume.

## Define the scope first

State the target and its boundaries before reading code. An audit of everything
finds nothing in particular, so name what is in scope, and name what is not.

1. **The target** - The `[repository, service, or directory]` under review, the
   entry points where untrusted input arrives, and the trust boundary between
   them.
2. **Injection & input handling** - SQL/NoSQL injection, shell injection,
   command execution, path traversal, template injection, unsafe deserialization.
3. **Authentication & authorization** - broken auth, default/weak credentials,
   missing authorization checks, privilege escalation, session handling.
4. **Data exposure** - secrets and API keys committed in the repo or in git
   history, sensitive data in logs, responses exposing internal details,
   insecure storage/transmission (HTTP, no TLS).
5. **Web-specific** - the OWASP Top 10 as it applies to the code: XSS, CSRF,
   SSRF, open redirects, insecure headers, IDOR.
6. **Dependencies** - known-vulnerable packages (run the repo's dependency
   scanner if configured, e.g. `npm audit`, `pip-audit`, `gh security`).
7. **Configuration** - over-permissive permissions, debug mode enabled,
   unsafe defaults, missing rate limiting/input validation.
8. **Out of scope** - Name what this audit deliberately excludes (for example
   third-party SaaS internals, physical security, or uncommitted local config)
   and say who owns it instead.

## What to produce

A findings report, each item with: the vulnerability, the evidence (file:line
and the code path), severity, real-world impact, and a concrete fix. End with
a prioritized fix list and any quick wins. Be clear about what was checked and
found clean.

## Method

- Read the actual code; trace untrusted input from entry point to sink. Do not
  claim a vulnerability without showing the path.
- Verify each finding yourself (run commands, check configs, read docs) before
  reporting it. For secrets in history, confirm with `git log -p` and
  `git rev-list --all`.
- Assess real-world exploitability and severity (Critical/High/Medium/Low),
  not just theoretical risk.

## Verification

- [ ] The target, entry points, and out-of-scope items were stated before the
      review began.
- [ ] Every reported finding shows an entry-point-to-sink path through real
      code, not an inferred one.
- [ ] Each finding was confirmed by running a command, reading a config, or
      reading a doc; unconfirmed items are labeled "needs confirmation".
- [ ] Secrets claims were checked against git history, not just the working
      tree.
- [ ] Every finding carries a severity, a real-world impact, and a fix.
- [ ] The areas checked and found clean are listed, so coverage is visible.

## Rules

- Do **not** change code, push fixes, or rotate secrets without explicit
  approval - report first.
- Never redact or dismiss a real finding because it's awkward. Report it
  plainly.
- If something looks vulnerable but you can't confirm the path, mark it as
  "needs confirmation" rather than a confirmed finding.
