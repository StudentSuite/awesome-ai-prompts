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

1. **Authenticate the domain before anything else** - Publish SPF, DKIM, and a
   DMARC record for the sending domain and confirm they resolve. Generate DKIM
   keys with the provider and install the public half as DNS. Record the exact
   records you installed and how you verified them; a correct SPF record that
   lists ten senders still fails SPF at 10 lookups.
2. **Choose a transactional provider** - Use a dedicated transactional
   provider rather than a personal account, and send from a subdomain of the
   sending domain so reputation damage from one stream cannot affect the
   corporate domain. Note which provider and which subdomain.
3. **Build templates as code** - Keep templates in versioned files with typed
   placeholders, not string concatenation. A missing variable must fail loudly
   in test rather than send `Hi, {{name}},` to a real person. Require both text
   and HTML parts.
4. **Prove the rendering across real clients** - Render each template and
   inspect it in the clients that matter, at minimum Gmail web, Gmail mobile,
   Outlook, and Apple Mail. Outlook in particular punishes tables, inline
   styles, and images-on-load. Paste what you checked; do not assert it.
5. **Send asynchronously with retry** - Enqueue the message and return. The
   request handler must not block on the provider. Retry transient failures with
   exponential backoff and a cap, fail permanent failures immediately (an
   invalid address will never succeed), and make enqueueing itself idempotent so
   a duplicate request does not send two copies.
6. **Handle bounces and complaints** - Process the provider's bounce and
   complaint webhooks with signature verification. Hard-bounce an address after
   the provider's threshold; suppress complaints always. An address that
   complained must never receive another message.
7. **Suppress the send when it is not wanted** - Honor unsubscribes and
   preference settings even for mail you consider transactional. Note which
   messages are legally required versus which ones are only convenient.
8. **Test on seed lists first** - Verify authentication and rendering against
   seed addresses you control across providers, including a Gmail and an Outlook
   account, before sending to real users. Start the rollout at a small volume
   and increase only after the bounce and complaint rate looks normal.

## Rules

- Never send from a personal account or the primary corporate domain.
- Never send synchronously from a request handler.
- Never concatenate templates in code. Use versioned template files.
- Never retry a hard bounce or resend to a complained address.
- Never claim deliverability works without showing rendered output from real
  clients and the verified DNS records.

## Verification

Paste the SPF, DKIM, and DMARC records with how each was verified, the
rendered output checked per client, the enqueue-and-retry path with its backoff
settings, and the bounce webhook handling. Confirm an unsubscribed address is
skipped and that a duplicate request sends one message.
