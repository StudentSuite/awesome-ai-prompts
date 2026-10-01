# Changelog

All notable changes to Awesome AI Prompts are documented here.

Format based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added

- `core-coding/file-uploads-media-handling-prompt.md` - accept uploads safely: server-side validation, streaming for large files, generated storage names, malware scanning hooks, and resumable transfers
- `core-coding/graphql-api-design-prompt.md` - design GraphQL past the demo: schema-first types, resolver N+1 batching, field-level authorization, bounded depth and complexity, stable error shape
- `core-coding/websockets-realtime-features-prompt.md` - build realtime features that survive disconnects and horizontal scaling: connection lifecycle, versioned message contracts, an explicit delivery guarantee, and a slow-client policy
- `core-coding/payment-integration-prompt.md` - integrate payments with money-grade discipline: no raw card data, idempotency keys on every mutation, verified webhooks, an order/payment state machine, and reconciliation jobs
- `core-coding/email-delivery-prompt.md` - send transactional email that reaches the inbox: SPF/DKIM/DMARC domain auth, code templates tested across clients, async sending with retry, and bounce/complaint suppression
- `system-design/message-queues-event-driven-design-prompt.md` - design event-driven systems for at-least-once delivery: versioned event contracts, per-key ordering, idempotent consumers, replay and backfill strategy, and DLQ operations
- `system-design/legacy-code-modernization-assessment-prompt.md` - assess whether a legacy system should be modernized at all: EOL and security inventory, a value-versus-risk map per module, strangler-fig seams, a characterization-test plan, and stop conditions
- `security-performance/prompt-injection-defense-prompt.md` - threat-model the prompt-injection attack class specifically: an inventory of where untrusted text reaches the context, instruction/data separation with its limits, out-of-band tool gating, a red-team suite, and documented residual risk
- `security-performance/privacy-gdpr-compliance-review-prompt.md` - run a systematic privacy review: data inventory with storage and retention, lawful basis and consent withdrawal, user rights flows including backups, the third-party processor list, and ranked minimization work
- `security-performance/rate-limiting-abuse-prevention-prompt.md` - protect public endpoints: limits tiered by identity, IP, and route cost, a written rationale for the algorithm, correct 429 and Retry-After semantics, shared-store counters, and a load test proving the limits trip and recover
- `devops-deploy/background-jobs-scheduled-tasks-prompt.md` - add background jobs that survive retries and deploys: idempotent handlers, bounded retries with backoff, dead-letter handling, queue depth and age metrics, and graceful shutdown drains
- `devops-deploy/cloud-cost-optimization-prompt.md` - cut cloud spend from measurement: a cost inventory ranked by service, rightsizing from utilization data, idle-resource cleanup, storage lifecycle policies, and a before/after savings table
- `devops-deploy/capacity-planning-prompt.md` - turn outages into scheduled upgrades: headroom per bottleneck, a forecast tied to a product metric, dated scaling options with cost and lead time, and alerts that fire well before the wall
- per-category `README.md` in all 13 category folders: what belongs in the
  category, the prompt list, a backlink to the matching main-README section,
  and a pointer to the one-page catalog
- `scripts/check-links.sh` - checks relative links and `<img src>` paths in
  every category README (resolved relative to each file) and requires a
  `README.md` in every folder that holds prompts
- `scripts/check-consistency.sh` - requires each category README to list
  exactly that folder's prompts and to link back to the correct main-README
  anchor, so a category README cannot drift from its folder
- `assets/social-preview.svg` and `assets/social-preview.png` - 1280x640
  repository social preview (repo name, tagline, category grid with real
  counts), with the SVG committed as the editable source; uploading it in
  Settings is still a manual step
- `.github/workflows/ci.yml` - the `citation` job now explains how to fix a
  failure instead of only printing cffconvert's error line; the listed causes
  were each checked against cffconvert 2.0.0 rather than assumed
- a `Keywords:` line in the intro of all 101 prompts, holding 4 to 7 lowercase
  comma-separated search terms. It is the last line of the intro, directly
  above the `---`, so it stays out of the copy-paste block and flows into
  `ALL_PROMPTS.html` through the existing `split_prompt()` parse. Titles alone
  did not surface a prompt when someone searched for `slow query` or `speed up`
- `scripts/check-links.sh` now requires exactly one non-empty `Keywords:` line
  per prompt file, in the intro rather than the prompt body. The rule reads
  each file directly, so unlike `CATEGORIES` and `SPEC_PROMPTS` it adds no
  hand-maintained list to `check-consistency.sh`
- `i18n/` as the home for translated prompts, laid out as
  `i18n/<lang>/<category>/<slug>-prompt.md` so the mirror path reads back to
  the English file it copies. One top-level folder was chosen over parallel
  repositories so a translator needs one clone and one pull request, and so the
  English gates cover translated files too. `i18n/<lang>/README.md` carries the
  per-language status table and the conventions; `i18n/es/` is the pilot slot
  and is deliberately empty of prompts
- a `Translations` section in `CONTRIBUTING.md` (layout, how to translate, how
  to check a translation against upstream) and a short pointer to it in the
  main `README.md`. Both state why no prompt here is machine-translated: a
  prompt body is a set of instructions an agent follows literally, not prose,
  and nothing in the gate chain can tell afterwards that a translation inverted
  a rule
- `AGENTS.md` - working notes for coding agents, written from the scripts
  rather than the prose. There is no Makefile and no root `package.json`, so
  the CI command sequence would otherwise be guesswork, and
  `CONTRIBUTING.md` describes the conventions without the executable contract:
  it says to bump the spec badge on a category's Contents line, while
  `check-consistency.sh` section 4 greps that line whole-line and exact. It
  also records that the gates do not all discover files the same way.
  `build-all.py` reads the category list from `git ls-files` but globs the
  filesystem for the files inside it, `check-links.sh` section 1 reads
  `git ls-files` while its later sections use `find`, and
  `check-consistency.sh` reads the disk. So an untracked new category folder is
  invisible to the catalog and to section 1, and only `check-consistency.sh`
  catches it by iterating folders on disk: new files need `git add` before the
  gates are worth trusting

### Changed

- `scripts/check-consistency.sh` - `i18n/` is now excluded from the set of
  English prompts. A new `english_prompts()` helper is the single place that
  decides that set, used by the README-listing check, the `[spec]` badge check,
  and the reported total, so translated mirrors cannot inflate a count or be
  required to appear in the English README. `i18n` joins the top-level folder
  exclusion list, and the `[Unreleased]` CHANGELOG pathspec skips it, since a
  translation is not a new prompt
- `scripts/check-links.sh` - the per-folder README requirement now applies to
  top-level folders only. Translations nest one level deeper, and a README in
  each of `i18n/<lang>/<category>/` would mean thirteen boilerplate files per
  language
- `scripts/check-links.sh` - the `Keywords:` format check (lowercase,
  comma separated) applies to English prompts only. A translated file still
  needs exactly one non-empty `Keywords:` line above the divider, but in the
  target language, so accented and non-Latin scripts are not rejected by an
  English character class
- `scripts/build-all.py` - `category_order()` skips `i18n/`. A translated
  file's first path segment is `i18n`, which is not a category name; taking
  that segment would have invented a fourteenth category holding nothing. The
  one-page catalog stays an English-language catalog

- `assets/social-preview.*` - redrawn in the catalog page's own palette (the
  CSS in `scripts/build-all.py`): a light `#f7f7f5` background, `#1a1a1a` ink,
  white cards with `#ddd` borders, and the `#2f4f7f` / `#4a6fa5` blue accents,
  replacing a blue-on-navy treatment that matched nothing else in the repo. The
  dark monospace prompt block is gone, and the palette is now a closed set of
  seven catalog colors; `#888` and `#777` are not used because they fall under
  4.5:1 contrast on that background
- `assets/social-preview.*` - the card now carries no numbers: no per-category
  counts in the pills, no category-count label, no prompt total in the footer.
  A figure on a social card is a snapshot that goes stale on the next pull
  request, so the names are all that remain. Adding a prompt no longer requires
  re-rendering or re-uploading the card; adding or renaming a category still
  does, and the generator checks the names against the `README.md` headings and
  the tracked category folders so a drift is caught at build time
- `scripts/check-consistency.sh` - `assets/` is now excluded from the
  "every folder needs a README section" rule, since it holds design sources
  rather than prompts
- `CONTRIBUTING.md` / `README.md` - the "add a prompt" steps now say to add
  the one-line entry to the category `README.md` as well as the main README
- `scripts/build-all.py` - catalog header CTA is now "Star on GitHub" with a star icon, replacing the fork-icon "GitHub" link
- README.md - added a "Staying in sync" section framing the star as release notification, with clone and pull commands

### Removed

### Fixed

---

## [0.5.0] - 2026-09-26

### Added

- `docs/demo.gif` - README demo GIF: a one-line prompt gets a shrug, then a repo prompt drives a real opencode run that cites file:line
- `.github/workflows/auto-contributors.yml` - append every merged prompt PR author to `CONTRIBUTORS.md` automatically
- `.github/workflows/auto-label.yml` - label PRs by category folder and close referenced good-first-issue tickets on merge
- `docs/usage-stories/TEMPLATE.md` - template for real before/after usage stories per category
- `docs/usage-stories/ucip-elderly-indicator-removal.md` - reviewing the removal of an invalid data indicator that cascaded across 83 files, using `code-review/secure-code-review-prompt.md`
- `docs/usage-stories/tourneyradar-api-ipv6-ratelimit.md` - a before/after record of an IPv6 rate-limit bypass fix; no prompt from this repo was used, so it is a case study rather than prompt evidence
- `core-coding/error-handling-strategy-prompt.md` - one coherent error policy: typed errors, context-rich logs, retry vs surface, proven by failure injection
- `security-performance/memory-leak-hunting-prompt.md` - find and remove a leak from measurements: baseline, reproduced growth, diffed snapshots, and a flat after-curve
- `core-coding/regular-expressions-prompt.md` - write or repair a regex with a stated purpose, a test corpus, and a check that it cannot hang on adversarial input
- `scripts/check-external-links.py` + `.github/workflows/url-rot-check.yml` - weekly external-link rot check (manual dispatch too) that fails on dead URLs in the README or any prompt
- `mobile-dev/mobile-ui-audit-prompt.md` **[spec]** - audit a mobile UI against platform conventions: touch targets, safe areas, accessibility, states, theming, with file:line fixes
- `mobile-dev/mobile-ui-overhaul-prompt.md` **[spec]** - overhaul a mobile UI end-to-end: target design spec, token layer, reimplemented screens, with before/after proof on every platform
- `mobile-dev/website-to-mobile-app-prompt.md` **[spec]** - turn a website into a mobile app, choosing the adaptation strategy from the site's actual architecture: wrapper vs shared-logic vs native
- `a-a-p-contributing/one-pager-schema-prompt.md` - the repo's one-pager format as a schema: field contract, size budget, and checks for authoring quick-task prompts
- `a-a-p-contributing/spec-prompt-schema-prompt.md` **[spec]** - the repo's spec format as a schema: what earns the badge, the mandatory field contract, and evidence-gated verification
- `git-github/issue-resolving-prompt.md` - resolve a GitHub issue end-to-end: reproduce the failure, prove the root cause, land a minimal fix with a regression test, and verify against the project's checks
- `code-review/architecture-review-prompt.md` **[spec]** - audit architecture as a senior architect: evidence-backed 0-10 scorecard, file:line findings with severity/impact/fix, and a prioritized refactoring roadmap, read-only
- `code-review/codebase-audit-prompt.md` **[spec]** - audit a codebase as a senior architect: evidence-backed 0-10 scores, structural smell identification, and a prioritized refactoring roadmap
- `scripts/build-all.py` + `vercel.json` - deterministic builder for `ALL_PROMPTS.html`, a single printable page with a linked mini-TOC and per-prompt copy buttons; committed for static hosting (served at the root by Vercel) and verified in sync by CI with `--check`

### Changed

- CONTRIBUTING.md - community rules: no unsolicited paid pitches or paid third-party actions in issues and PRs
- CONTRIBUTING.md - review policy: 48h response SLA for external PRs, merge-first with maintainer nit-fixing
- README.md - recent contributors strip, star-to-contribute handshake, and a "PR in under 10 minutes" contribution CTA
- `.github/workflows/thanks.yml` - limit the thank-you to a contributor's first merged PR
- `.gitignore` - ignore local launch drafts (`drafts/`) that are pasted from your own accounts, not part of the repo

### Removed

- `docs/media/prompt-in-action.gif` - unembedded and deleted; `docs/demo.gif` already carries the same real opencode run behind a staged opening, so the README was showing the same footage twice (12.1MB dropped)

---

## [0.4.0] - 2026-09-17

### Added

- `a-a-p-contributing/new-prompt-contribution-prompt.md` - author a new prompt for this repo: read conventions, confirm the idea is new, draft, sync index, run gates, open a PR
- `a-a-p-contributing/prompt-pr-review-prompt.md` - review a prompt-contribution PR against the repo's gates with an explicit verdict
- `a-a-p-contributing/resolve-open-issue-prompt.md` - take an open issue end-to-end from ticket to a mergeable PR
- `a-a-p-contributing/fix-reported-bug-prompt.md` - fix a reported bug with reproduction, root cause, and proof
- `core-coding/cli-tool-build-prompt.md` - build a well-behaved CLI: documented flags, typed exit codes, safe pipe and TTY handling, testable core
- `core-coding/agent-codebase-onboarding-prompt.md` **[spec]** - onboard an agent into an unfamiliar repo with no human in the loop: a token-budgeted reading protocol, a compact in-context model, and hard verification gates
- `core-coding/human-codebase-onboarding-prompt.md` **[spec]** - renamed from `codebase-onboarding-prompt.md`; understand an unfamiliar repo at verification depth: stack, architecture, data flow, conventions, gotchas, with file:line evidence
- `data-ai/ai-agent-build-prompt.md` **[spec]** - design and build an LLM agent: tool contracts, context strategy, guardrails, eval set, cost and latency budget
- `mobile-dev/mobile-app-develop-prompt.md` **[spec]** - build a mobile feature and prove it works on both platforms: offline, permissions, deep links, lifecycle, with a platform verification matrix
- `mobile-dev/mobile-performance-prompt.md` - find and fix mobile performance from measurements: startup, frame rate, app size, memory, network
- New `mobile-dev/` category for mobile-specific prompts
- `career-learning/conference-talk-proposal-prep-prompt.md` - write a competitive CFP and rehearse the talk: hook, takeaway, timed outline, demo fallbacks
- `git-github/open-source-maintainer-survival-prompt.md` - harden maintenance practices: guidelines, automation, kind declines, bus factor, handoff
- `frontend-ui/design-handoff-prompt.md` - turn a mockup into token-aligned, responsive code with a screenshot comparison loop
- `scripts/check-prettier.sh` - Prettier gate verifying markdown, JSON/JSONC, YAML, and CSS files match repo formatting, wired into CI

## [0.3.0] - 2026-09-09

### Fixed

- `git-github/pr-review-prompt.md` renamed from `pr-review.md` and moved to `git-github/` for correct categorization

### Added

- `docs/media/prompt-in-action.gif` - above-the-fold demo GIF showing a bug-finder [spec] prompt driving an agent to verified bug findings; captured live from an openvidstudio-driven terminal with Aceternity components
- `bug-finder-prompt.md` **[spec]** - sweep a codebase across correctness factors and surface a clear, evidence-backed, priority-ordered list of bugs
- `bug-finder-with-docs-prompt.md` **[spec]** - find bugs and leave a durable bug ledger (BUGS.md + README pointer) without touching code
- `ui-audit-prompt.md` **[spec]** - audit UI for visual consistency, design system adherence, spacing, typography, and responsive behavior with concrete fixes and file:line evidence
- `codebase-onboarding-prompt.md` **[spec]** - understand an unfamiliar repo at verification depth: stack, architecture, data flow, conventions, gotchas, with file:line evidence
- `issue-triage-for-maintainers-prompt.md` - triage a backlog into labeled, prioritized, answerable queues
- `responsible-web-scraping-prompt.md` - scrape within robots.txt/ToS, resilient selectors, checkpointed crawls
- `datetime-timezone-correctness-prompt.md` - UTC storage, DST handling, safe parsing, calendar/duration math
- `csv-spreadsheet-wrangling-prompt.md` - clean messy CSV/spreadsheet exports with encoding detection, explicit type overrides, and a validation report
- `api-design-prompt.md` - design a well-structured REST API with OpenAPI spec
- `database-design-prompt.md` - model a relational schema from requirements
- `environment-setup-prompt.md` - bootstrap a dev environment from scratch
- `code-migration-prompt.md` **[spec]** - migrate code between frameworks/languages with behavior parity
- `performance-review-prompt.md` - review code for performance anti-patterns
- `accessibility-review-prompt.md` - audit UI code for WCAG compliance
- `ui-audit-prompt.md` - audit UI for visual consistency, design system adherence, spacing, typography, and responsive behavior
- `e2e-test-scaffold-prompt.md` - scaffold end-to-end/integration tests
- `mutation-testing-prompt.md` - validate test quality with mutation testing
- `api-documentation-prompt.md` - generate OpenAPI docs from existing code
- `readme-builder-prompt.md` - build a comprehensive README from scratch
- `inline-documentation-prompt.md` - add JSDoc/docstrings to existing code
- `secrets-management-prompt.md` - audit and remediate hardcoded secrets
- `load-testing-prompt.md` - design and run load/stress tests
- `dependency-audit-prompt.md` - audit dependencies for vulnerabilities and staleness
- `monitoring-observability-prompt.md` - set up logging, metrics, and alerting
- `incident-response-prompt.md` - debug incidents and write post-mortems
- `git-bisect-debug-prompt.md` - find the commit that introduced a bug with git bisect
- `release-automation-prompt.md` - automate versioning, tagging, and publishing
- `commit-checklist-prompt.md` - build consistency gates for derived artifacts
- `resume-review-prompt.md` - review a technical resume
- `tech-blog-writer-prompt.md` - turn a project into a blog post
- `component-build-prompt.md` - build a reusable, accessible UI component
- `responsive-design-prompt.md` - audit and implement responsive layouts
- New `frontend-ui/` category for UI-specific prompts
- `system-design-prompt.md` **[spec]** - design a scalable system end-to-end
- `adr-writing-prompt.md` - record a technical decision as an ADR
- `technical-debt-triage-prompt.md` - inventory and prioritize tech debt
- `concurrency-debugging-prompt.md` - debug race conditions and deadlocks
- `caching-strategy-prompt.md` - add caching with designed invalidation
- `data-pipeline-prompt.md` - build idempotent, validated ETL pipelines
- `sql-query-optimization-prompt.md` - optimize slow queries with plan evidence
- `rag-pipeline-prompt.md` - build grounded, cited RAG features with evals
- `llm-feature-eval-prompt.md` - evaluate LLM features against held-out test sets
- `threat-modeling-prompt.md` - STRIDE threat modeling ranked by real risk
- `auth-implementation-prompt.md` - implement authn/authz safely
- `contract-testing-prompt.md` - consumer-driven contract tests in CI
- `chaos-resilience-prompt.md` - failure injection and resilience fixes
- `state-management-prompt.md` - one home per piece of client state
- `web-performance-vitals-prompt.md` - Core Web Vitals optimization with proof
- `i18n-localization-prompt.md` - internationalization done properly
- `kubernetes-deployment-prompt.md` - secure, zero-downtime K8s deploys
- `feature-flag-rollout-prompt.md` - progressive delivery with kill switches
- `backup-disaster-recovery-prompt.md` - restore-proven backups and DR runbooks
- `learning-roadmap-prompt.md` - project-based learning plans with checkpoints
- `website-seo-prompt.md` - technical SEO audit with verification
- `instagram-carousel-prompt.md` - turn a repo into a branded Instagram carousel of HTML slides
- New `system-design/` category for architecture-level prompts
- New `data-ai/` category for data engineering and AI/LLM prompts
- `commit-checklist.yml` workflow enforcing PR gates: listed prompts, changelog coverage, folder/section sync, Contents counts, Conventional Commits titles
- `scripts/check-consistency.sh` for running the consistency checks locally
- Prompt counts in the README Contents list

---

## [0.2.0] - 2026-09-05

### Added

- 50 new prompts, bringing the catalog from 26 to 76 across 11 categories
- New `frontend-ui/` category for UI-specific prompts (ui-audit, component-build, responsive-design, web-performance-vitals, state-management, i18n-localization)
- New `data-ai/` category for data engineering and AI/LLM prompts (data-pipeline, sql-query-optimization, rag-pipeline, llm-feature-eval)
- New `system-design/` category for architecture-level prompts (system-design, adr-writing, caching-strategy, technical-debt-triage)
- `pr-review-prompt.md` for pull request review in `git-github/`
- `commit-checklist-prompt.md` for building consistency gates, plus the `commit-checklist.yml` workflow enforcing them
- `CONTRIBUTORS.md` and `CITATION.cff`
- CI hardening: markdownlint job, em-dash block in tracked files, LF line endings
- README repositioned around verification-first messaging with a category table of contents
- `ui-audit-prompt.md` and `codebase-onboarding-prompt.md` upgraded to **[spec]** prompts

---

## [0.1.0] - 2026-08-15

### Added

- Initial public release
- 26 curated copy-paste prompts covering the full development lifecycle: core coding, git & GitHub, code review, testing, docs, security, performance, DevOps, and career
- Prompts grouped into category folders with a categorized README index

---

[Unreleased]: https://github.com/shauryagangrade/awesome-ai-prompts/compare/v0.5.0...HEAD
[0.5.0]: https://github.com/shauryagangrade/awesome-ai-prompts/releases/tag/v0.5.0
[0.4.0]: https://github.com/shauryagangrade/awesome-ai-prompts/releases/tag/v0.4.0
[0.3.0]: https://github.com/shauryagangrade/awesome-ai-prompts/releases/tag/v0.3.0
[0.2.0]: https://github.com/shauryagangrade/awesome-ai-prompts/releases/tag/v0.2.0
[0.1.0]: https://github.com/shauryagangrade/awesome-ai-prompts/releases/tag/v0.1.0
