# Reusable prompt: responsible web scraping

Copy-paste the block below into any AI coding agent to build a scraper that
respects the site it's reading and survives its next layout change.

Keywords: web scraping, scraper, robots.txt, rate limit, polite crawling, html parsing, legal

---

Build the requested web scraper/crawler. Scraping without guardrails gets IPs
banned, breaks on the next redesign, and can create legal exposure; build it
defensively from the start.

## Steps

1. **Respect robots.txt and ToS before the first request** - Fetch and parse
   `robots.txt`, honor disallowed paths and crawl-delay directives, and check
   the site's terms of service for a scraping policy. If the ToS forbids
   scraping, say so and stop.
2. **Identify honestly** - A descriptive User-Agent with contact info
   (`myproject-bot/1.0 (+https://example.com/contact)`), not a spoofed browser
   UA. If the site offers an API, use it instead of scraping HTML.
3. **Rate-limit and back off** - Enforce a minimum delay per host (respecting
   `Crawl-delay`), add jitter, and back off exponentially on 429 or 503 instead
   of retrying immediately.
4. **Write selectors resilient to markup drift** - Prefer stable attributes
   (`data-*`, `id`, semantic tags) over positional CSS paths that break on the
   next redesign. Add a fallback selector chain and log when the primary
   misses, so drift is caught rather than silently empty.
5. **Make crawls resumable** - Checkpoint the last page or ID processed so a
   crash resumes instead of restarting, and deduplicate against items already
   fetched.
6. **Track politeness and error budgets** - Log requests per second against the
   limit and error rate by status code, then stop once the error budget is
   exceeded. That is a signal the site changed or is blocking you, not a blip
   to retry through.

## Verification

- [ ] robots.txt was fetched and parsed, disallowed paths and Crawl-delay
      honored, and the site's terms of service checked; if the ToS forbids
      scraping, the work stopped.
- [ ] The User-Agent is descriptive with contact details, not a spoofed browser
      string.
- [ ] The minimum inter-request delay with jitter is enforced, and 429 or 503
      responses trigger exponential backoff rather than an immediate retry.
- [ ] Selectors use stable attributes with a fallback chain, and a
      primary-selector miss is logged.
- [ ] Crawls checkpoint and resume, and stop once the error budget is exceeded
      rather than retrying through.

## Rules

- Never bypass a CAPTCHA, paywall, or authentication wall to scrape content
  behind it.
- Never scrape personal data beyond what's already public and permitted by the
  site's policy; don't aggregate PII across sources without a stated lawful
  basis.
- If `robots.txt` or ToS is ambiguous or unreachable, treat that as "ask a
  human before proceeding," not as permission by default.
