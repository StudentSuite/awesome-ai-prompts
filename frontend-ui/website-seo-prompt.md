# Reusable prompt: Website SEO audit and optimization

Copy-paste the block below into any AI coding agent to perform a technical
SEO audit - crawlability, metadata, structured data, redirects, and speed -
with verification at every step.

Keywords: seo, search ranking, metadata, sitemap, serp, search console, crawl

---

Audit and improve this website's technical SEO. Work from verified
evidence, not guesses: a bot hasn't rendered or indexed a page just because
you typed a URL. Rank fixes by impact on indexing and ranking, implement
them, and re-verify.

## Steps

1. **Establish the baseline** - Determine the exact site (confirmed
   `robots.txt`, `sitemap.xml`, and canonical URLs, not assumptions). Crawl
   the live site - the production domain users reach, including trailing
   slash and `www` vs apex handling. Record key pages, their
   indexability, and current title/meta state.
2. **Crawlability & indexability** - Check `robots.txt` for blocked
   resources (CSS/JS/images shouldn't be blocked; stray `Disallow`s and
   `noindex` on pages that must rank are common bugs). Verify
   `sitemap.xml` lists the canonical page URLs, uses `lastmod` correctly,
   and is referenced from robots.txt. Flag duplication: near-identical
   URLs, parameter variants, and printer/mobile subdomains.
3. **Canonicalization** - Ensure every page has a self-referencing
   `rel="canonical"` and that `http`/`https`, `www`/apex, and trailing
   slash all resolve to one canonical form with a proper 301 redirect.
   Chase any redirect chains to their end and collapse them to a single
   hop. Confirm pages you don't want indexed are truly `noindex` and
   either disallowed or removable.
4. **Metadata & structured data** - Audit title and meta description per
   template: unique, correct length, keyword-relevant, matching the
   rendered page, not duplicated via the same CMS field feed. Add JSON-LD
   structured data for Organization, BreadcrumbList, and, where the page
   type warrants it, Article/Product/Faq. Validate every schema block
   against a schema validator and check with a rich-results test.
5. **On-page content & headings** - Confirm a single `h1` per page
   describing the page topic, a sane `h2`/`h3` hierarchy, and that
   target keywords appear in the title, headings, and body without
   stuffing. Flag empty pages, thin content, and missing/misleading
   alt text on meaningful images.
6. **Internal links & external signals** - Verify key pages are reachable
   via crawlable text links (not JS-only navigation), add descriptive
   anchor text, and fix broken internal links. Optionally review backlinks
   via a trustworthy source, but never suggest buying links.
7. **Speed, mobile, and Core Web Vitals** - Measure the same pages in the
   lab (Lighthouse) and field (CrUX if available) and flag LCP/INP/CLS,
   oversized images, render-blocking resources, and mobile rendering
   issues. Fix the biggest contributor first; re-measure under the same
   conditions.
8. **Guard the wins** - Add checks that stop regressions: a CI lint that
   fails on duplicate titles/meta, missing canonical, oversized images, or
   empty `h1`; and a recurring crawl (sitemap diff, robots.txt review,
   index-change alerts) so indexing problems surface early.

## Output

A baseline table per key page: indexable? canonical target, title/meta
status, headings, structured-data validation, speed metrics. Then the
changes made ranked by expected impact, with before/after evidence and the
remaining blocked-by-non-technical-work items.

## Rules

- Never claim a page is indexed, canonical, or blocked without verifying
  via the live server, the search engine's own tools, and a validator.
- Judge only against the production site users actually reach, not staging.
- Optimize pages people search for - not an arbitrary audit list.
- If content quality or rankings are the goal, say so and scope in the
  content work; this prompt is the technical foundation.
