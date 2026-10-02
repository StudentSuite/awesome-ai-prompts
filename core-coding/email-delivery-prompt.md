# Reusable prompt: email delivery

Copy-paste the block below into any AI coding agent to send transactional email
that reaches the inbox: authenticated domain, testable templates, async sending,
and bounce handling that keeps a bad address from costing you reputation.

Keywords: email, spf, dkim, dmarc, templates, bounce handling, deliverability

---

Add email sending for `[what: welcome / password reset / receipt]` to this
repository. The rule: **deliverability is won or lost on domain
authentication, and sending must never be on the request path**. Prove it with
real rendered output before a real send.

## Steps

1. **Authenticate the domain first** - Publish SPF, DKIM, and DMARC for the sending domain and confirm they resolve. Record each record and how you verified it; a correct SPF listing ten senders still fails at the 10-lookup limit.
2. **Pick a transactional provider** - A dedicated provider, not a personal account, and a sending subdomain, so one stream's reputation damage cannot reach the corporate domain.
3. **Keep templates in versioned files** - Typed placeholders, not string concatenation. A missing variable must fail a test rather than send `Hi, {{name}},` to a real person. Require both text and HTML parts.
4. **Prove rendering in real clients** - Inspect each template in Gmail web, Gmail mobile, Outlook, and Apple Mail; Outlook punishes tables, inline styles, and images-on-load. Paste what you checked.
5. **Send asynchronously and idempotently** - Enqueue and return; the handler must not block on the provider. Retry transient failures with capped exponential backoff, fail permanent ones immediately, and make enqueueing idempotent so a duplicate request sends one copy.
6. **Handle bounces, complaints, and opt-outs** - Verify webhook signatures. Hard-bounce after the provider threshold, always suppress complaints, and honor unsubscribes even for mail you consider transactional. Prove it all against seed addresses on Gmail and Outlook first.

## Verification

- [ ] The SPF, DKIM, and DMARC records are pasted with the command or lookup that confirmed each resolves.
- [ ] Sending is from a dedicated provider on a subdomain, never a personal or primary corporate account.
- [ ] Templates are versioned files, and a missing variable fails a test rather than sending.
- [ ] Rendered output was checked in Gmail web, Gmail mobile, Outlook, and Apple Mail, and what was checked is shown rather than asserted.
- [ ] Enqueue is idempotent, transient failures retry with capped backoff, and permanent failures fail immediately.
- [ ] Bounce and complaint webhooks are signature-verified, and a duplicate request was shown to send exactly one message.

## Rules

- Never send from a personal account or the primary corporate domain.
- Never send synchronously from a request handler.
- Never concatenate templates in code. Use versioned template files.
- Never retry a hard bounce or resend to a complained address.
- Never claim deliverability works without showing rendered output from real
  clients and the verified DNS records.
