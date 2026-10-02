# Reusable prompt: authentication & authorization implementation

Copy-paste the block below into any AI coding agent to implement auth the safe
way - sessions and tokens done right, authorization checked server-side, and
the common pitfalls closed.

Keywords: authentication, authorization, login, oauth, sessions, rbac, permissions

---

Implement the requested authentication/authorization for this application. Auth
bugs are catastrophic and subtle; follow established patterns exactly and
verify each property with tests.

## Steps

1. **Choose the right pattern** - Server-side sessions (httpOnly cookie) for
   server-rendered apps; short-lived access tokens plus refresh rotation for
   APIs/SPAs; OAuth/OIDC through a maintained library for third-party login.
   Justify the choice; never roll your own crypto or protocol.
2. **Store credentials properly** - Passwords hashed with argon2id/bcrypt
   (never MD5/SHA alone), constant-time comparisons, no plaintext anywhere
   including logs. When migrating hash formats, rehash on next successful
   login.
3. **Harden token/session handling** - Secure, httpOnly, SameSite cookies; CSRF
   protection for cookie-authenticated mutations; rotation on privilege change;
   a revocation story for stolen sessions; sane expiry.
4. **Authorize on the server, everywhere** - Every endpoint checks identity and
   permission server-side (deny by default); object-level checks on every
   resource access to stop IDOR; admin routes behind explicit role checks.
   Hiding UI elements client-side is cosmetic, never the control.
5. **Cover the account lifecycle** - Registration with email verification,
   login rate limiting with lockout/backoff, password reset via single-use
   expiring tokens that invalidate existing sessions, logout everywhere.
6. **Test the properties** - Automated tests: unauthenticated access denied,
   cross-user access denied (IDOR probes), expired/revoked tokens rejected,
   reset tokens single-use, rate limits trip. Run the full suite.

## Verification

- [ ] The chosen pattern suits the stack, and a maintained library or service
      was used where one covers the need.
- [ ] Passwords use argon2id or bcrypt with a sane cost factor; no reversible
      encoding anywhere.
- [ ] Cookies are `Secure`, `httpOnly`, and `SameSite`, and session or token
      invalidation works.
- [ ] Every endpoint checks identity and authorization server-side; no check is
      client-side only.
- [ ] The account lifecycle is covered: registration, verification, reset, and
      logout.
- [ ] Error messages never reveal whether an email or account exists.
- [ ] Tests assert unauthenticated access is denied and authorization
      boundaries hold.

## Rules

- Secrets and keys come from environment config, never committed.
- Error messages must not reveal whether an email or account exists.
- If a maintained auth library or service in the stack covers a need, use it
  instead of hand-building; note any deviation and why.
