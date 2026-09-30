# Reusable prompt: Instagram carousel from a repo

Copy-paste the block below into any AI coding agent to turn a repository into a
branded, swipeable Instagram carousel, delivered as self-contained HTML slides
ready to screenshot and post. Repo-agnostic: it works for any project, in any
language, with any visual identity.

Keywords: instagram, carousel, social media, slides, marketing, graphics, post

---

Create an Instagram carousel post about this repository, following the repo's
existing visual identity. Deliver it as a single self-contained HTML file
containing `N` slide sections (ask me for `N` if I haven't said, otherwise default
to 8), each sized exactly **1080x1080 pixels**, ready for me to open in a
browser and screenshot in order as an Instagram carousel.

## Step 1 - Understand the content (what I'm posting about)

1. **Read the repo's README.md** and, if present, its `CHANGELOG.md`, category
   folders, and sample files. Extract: what the project does, who it's for, its
   headline value proposition, and 3-5 concrete, real features or use-cases I
   can cite on the slides.
2. **Gather real facts, not invented ones** - count actual entries/items per
   category (e.g. `find . -name '*-prompt.md'`), pull real feature names, real
   numbers, and real sample titles directly from the repo. Every number or claim
   that goes on a slide must be verified against the actual files. Never make up
   stats, counts, or feature names.

## Step 2 - Discover the brand identity (the visual style)

Find and mirror the repo's existing branding rather than inventing a new look:

1. Look for brand artifacts in the repo tree and the owning organization:
   - SVG logos / lockups (e.g. `logo-lockup.svg`, `profile/*.svg`).
   - README badges, shields, and the org profile README - these often leak the
     exact brand hex colors.
   - Any mentions of the website/handle/account (Instagram, Twitter/X, etc.).
2. **Extract the brand tokens:**
   - **Colors** - the 1-3 accent colors actually used in the logo/badges plus a
     neutral background and a text color. Record their exact hex values.
   - **Fonts** - the heading and mono/label font families used in the lockup or
     badges (e.g. a display font for headings and a monospace for labels).
   - **Logo** - rebuild the logo mark as inline SVG (from the official SVG or by
     approximating its shapes/colors) so it can be placed on each slide.
   - **Voice** - pull the org tagline and tone from the README (e.g. "built by
     students, for students") and reuse its phrasing.
3. If I gave you a reference post or a style description, follow it; otherwise
   mirror the extracted brand identity.

## Step 3 - Write the carousel script

Plan `N` slides with a clear narrative arc. Recommended default structure (8
slides, adapt to `N`):

1. **Cover / hook** - a bold, benefit-led headline that makes people swipe. Add
   a small "swipe →" cue.
2. **The problem** - the pain the project solves.
3. **What it is** - project overview: free/open-source status, key facts and
   verified numbers.
4. **Feature / category grid** or a key breakdown (chips with real per-category
   counts).
5. **How it works** - a numbered 2-4 step walkthrough.
6. **Why it's different** - the differentiators / core philosophy as short cards.
7. **Real examples** - a few concrete, real items pulled from the repo in step 1.
8. **CTA** - clear action (e.g. "star on GitHub"), the handle/URL, and a
   "save/share" prompt.

Keep on-screen text short and scannable. Aim for one idea per slide, big
headlines, and no walls of text.

## Step 4 - Build the HTML

1. **One self-contained `.html` file** with all `N` slides as sibling
   `<section class="slide">` elements, each exactly `1080px x 1080px`.
2. **No external dependencies** - no CDN links, no external fonts, no remote
   assets. Use the extracted brand fonts with sensible system fallbacks (e.g.
   `'Space Grotesk', system-ui, sans-serif`). Inline all SVG.
3. **Shared slide chrome** for consistency (the "template"): the logo in the
   top-left, a `NN / NN` page indicator top-right, and a footer strip with the
   handle and a short tagline. Repeat this exact chrome on every slide (vary
   only the content and the CTA).
4. Use CSS custom properties (`:root` variables) for the brand colors so they're
   easy for me to tweak in one place.
5. Use the brand palette, the brand fonts for headings and mono for labels/tags,
   and the brand voice for all copy.

## Step 5 - Verify the layout

Programmatically confirm, for EVERY slide, that the content fits within the
1080x1080 bounds and does not overflow into the footer:

- Render the file (e.g. with a headless browser) and measure each slide's
  content bounding box against the footer boundary.
- Check the slide is exactly 1080x1080 and that `overflow:hidden` on the slide is
  only clipping intentional decorative elements - not real text or cards.
- If any slide overflows, tighten that slide's font size, spacing, or copy and
  re-check until all slides fit cleanly.

If a headless browser isn't available, reason carefully about the layout: keep
content vertically centered, cap headline sizes so the longest allowed text fits,
and leave generous margins.

## Step 6 - Deliverable

In the same HTML file, below the slides, include a clearly-labeled section that
is **not part of the slides** (e.g. a `.post-notes` block) containing:

- A suggested **caption** for the Instagram post.
- A set of **hashtags**.
- 2-3 posting **tips** (file size, screenshot method, bio link suggestion).

## Rules

- Every fact, number, count, and feature name on the slides must be real and
  verified against the repository. Never invent stats or content.
- If the repo or org has no discoverable brand (no logo, no colors), ask me for
  one preferred accent color + a heading font, or pick a clean, modern default
  and tell me what you assumed.
- Keep it fully offline/self-contained - the HTML must render correctly from a
  local file with no internet access.
- Do not pad slides with placeholder content; if you don't have a real fact for
  a slot, leave the slide out or reshape the arc rather than fabricate.
- Follow the repo's actual category counts and naming.
