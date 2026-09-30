# Reusable prompt: responsible web scraping

Copy-paste the block below into any AI coding agent to build a scraper that
respects the site it's reading and survives its next layout change.

Keywords: web scraping, scraper, robots.txt, rate limit, polite crawling, html parsing, legal

---

Build the requested web scraper/crawler. Scraping without guardrails gets
IPs banned, breaks on the next redesign, and can create legal exposure;
build it defensively from the start.

## Steps

1. **Respect robots.txt and ToS before writing a single request** - Fetch and
   parse `robots.txt`, honor disallowed paths and crawl-delay directives, and
   check the site's terms of service for an explicit scraping policy. If the
   ToS forbids scraping, say so and stop rather than proceeding anyway.
2. **Identify honestly** - Set a descriptive User-Agent string with contact
   info (e.g. `myproject-bot/1.0 (+https://example.com/contact)`), not a
   spoofed browser UA. If the site offers an API, use it instead of scraping
   HTML.
3. **Rate-limit and back off** - Enforce a minimum delay between requests to
   the same host (respect `Crawl-delay` if present), add jitter, and
   exponentially back off on 429/503 responses instead of retrying
   immediately.
4. **Write selectors resilient to markup drift** - Prefer stable attributes
   (`data-*`, `id`, semantic tags) over deep positional CSS paths that break
   on the next redesign. Add a fallback selector chain and log when the
   primary selector misses so drift is caught early, not silently.
5. **Make crawls incremental and resumable** - Checkpoint progress (last
   page/ID processed) so a crash or interruption resumes instead of
   restarting from zero. Deduplicate against already-fetched items on
   resume.
6. **Track politeness and error budgets** - Log requests/sec against the
   configured limit, error rate by status code, and stop (don't keep
   hammering) once an error budget is exceeded - that's a signal the site
   changed or is blocking you, not a transient blip to retry through.

## Rules

- Never bypass a CAPTCHA, paywall, or authentication wall to scrape content
  behind it.
- Never scrape personal data beyond what's already public and permitted by
  the site's policy; don't aggregate PII across sources without a stated
  lawful basis.
- If `robots.txt` or ToS is ambiguous or unreachable, treat that as "ask a
  human before proceeding," not as permission by default.
