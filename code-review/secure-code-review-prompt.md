# Reusable prompt: security-focused code review

Copy-paste the block below into any AI coding agent to review a PR or diff
through a security lens - find real vulnerabilities, with evidence.

A short report: confirmed findings (path + severity + fix), then
lower-confidence items to double-check. Separate blocking security issues from
nice-to-harden. No fluff, no duplicates.

Keywords: secure code, security review, injection, owasp, vulnerability, input validation

---

Review this code with a security focus. The author has already had a
functional review - your job is to find the ways an attacker or a bad input
could abuse it. Verify everything; don't flag theoretical risks without a
real path.

## Steps

1. **Injection & shell** - User input reaching SQL/NoSQL queries, shell
   commands, URLs, templates, or deserializers. Trace input from source to
   sink before flagging.
2. **Authn/authz** - Missing or bypassable checks, IDOR (using another user's
   ID without ownership checks), privilege escalation, hardcoded/weak
   credentials, secrets in code.
3. **Web & network** - XSS (esp. where user content is rendered), CSRF, SSRF,
   open redirects, insecure headers/CSP, missing TLS, trusting attacker-controlled
   URLs or hosts.
4. **Data handling** - Sensitive data logged or returned in responses,
   over-permissive CORS, secrets in error messages, caching of private data,
   insecure deserialization.
5. **Dependencies & config** - New dependencies with known vulnerabilities,
   unsafe defaults, debug mode, permissive permissions.

- Read the actual diff and the surrounding code. For each concern, show the
  input-to-sink path with `file:line`. If you can't show the path, mark it as
  "worth checking" rather than a finding.
- Confirm your claims: run the code or tests if that helps, read configs, and
  check docs.
- Rank findings by real exploitability and severity. A high-severity issue
  with no reachable path is less important than a medium one an attacker can
  actually hit.

## Verification

- [ ] Every confirmed finding shows the input-to-sink path with file:line.
- [ ] Items with no demonstrable path are listed as worth checking, not as findings.
- [ ] Each finding is ranked by real exploitability, not theoretical severity.
- [ ] Blocking security issues are separated from hardening suggestions.
- [ ] No destructive or write operation was run against a real system during the review.

## Rules

- Never run destructive or write operations against real systems during review.
- Don't fix the code unless asked - report the findings and proposed fixes.
- Never dismiss a real issue because it's "just" a demo/assignment; say so
  but still report it.
