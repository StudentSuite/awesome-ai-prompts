# Reusable prompt: Website SEO audit and optimization

Copy-paste the block below into any AI coding agent to perform a technical SEO
audit - crawlability, metadata, structured data, redirects, and speed - with
verification at every step.

A baseline table per key page: indexable? canonical target, title/meta status,
headings, structured-data validation, speed metrics. Then the changes made
ranked by expected impact, with before/after evidence and the remaining
blocked-by-non-technical-work items.

Keywords: seo, search ranking, metadata, sitemap, serp, search console, crawl

---

Audit and improve this website's technical SEO. Work from verified evidence,
not guesses: a bot hasn't rendered or indexed a page just because you typed a
URL. Rank fixes by impact on indexing and ranking, implement them, and
re-verify.

## Steps

1. **Set scope and baseline** - Confirm the production site. Crawl pages and
   record technical signals (canonical, hreflang, robots, sitemaps, structured
   data), on-page (titles, meta, headings), and Core Web Vitals.
2. **Find high-impact issues** - Prioritize pages people actually search for.
   For each issue list severity, frequency, and concrete fix; verify each claim
   with a real check.
3. **Fix with evidence** - Address canonicalization, duplicates, indexation
   blocks, title/meta, internal linking, image alt, schema, and crawl budget.
   For each fix, explain the verification.
4. **Verify and guard** - Re-check fixed pages using the same checks. Add a CI
   lint/check to prevent regressions and summarize fixes with before/after
   evidence.

## Verification

- [ ] The exact site audited was confirmed, and findings are judged against
      production, not staging.
- [ ] Every claim about indexation, canonicals, or blocking was verified with a
      real check, not inferred.
- [ ] Each page has one self-referencing canonical and exactly one `h1`.
- [ ] Titles and meta descriptions are audited per page, and structured data
      validates.
- [ ] Priority is given to pages people actually search for, not an arbitrary
      audit list.
- [ ] Regression guards are in place: a CI lint or check that fails on the
      classes of defect fixed.

## Rules

- Never claim a page is indexed, canonical, or blocked without verifying via
  the live server, the search engine's own tools, and a validator.
- Judge only against the production site users actually reach, not staging.
- Optimize pages people search for - not an arbitrary audit list.
- If content quality or rankings are the goal, say so and scope in the content
  work; this prompt is the technical foundation.
