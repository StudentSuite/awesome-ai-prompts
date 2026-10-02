# Reusable prompt: Instagram carousel from a repo [spec]

Copy-paste the block below into any AI coding agent to turn a repository into a
branded, swipeable Instagram carousel. The heavy format is here because every
number on a slide has to trace to a real file and every slide has to be measured
at exactly 1080x1080, not eyeballed.

Keywords: instagram, carousel, social media, slides, marketing, graphics, post

---

Create an Instagram carousel post about `[this repository]`, following the
repo's existing visual identity. Deliver `[N]` slide sections (ask me for `N` if
I haven't said, otherwise default to 8), each sized exactly **1080x1080
pixels**, ready for me to open in a browser and screenshot in order as an
Instagram carousel.

## Define the scope first

Nothing gets designed until these are settled. Each one is a fact to establish
from the repository, not an assumption to carry forward.

1. **What the repository actually is** - Read `README.md` and, if present, its
   `CHANGELOG.md`, the category folders, and a few sample files. Extract what
   the project does, who it is for, its headline value proposition, and 3-5
   concrete, real features or use-cases I can cite on the slides.
2. **Every fact that will appear on a slide** - Count actual entries per
   category (e.g. `find . -name '*-prompt.md'`), and pull real feature names,
   real numbers, and real sample titles from the files themselves. Any number
   or claim on a slide traces to a file you read. The repo's actual category
   counts and naming are the counts and naming you use.
3. **The brand source** - Locate the brand artifacts before designing anything:
   SVG logos and lockups (`logo-lockup.svg`, `profile/*.svg`), README badges and
   shields, the org profile README (which often leak the exact brand hex
   colors), and any website, handle, or account mentions. If the repository has
   no discoverable identity, that is a scope question to raise, not a gap to
   fill with invention.
4. **Slide count and narrative arc** - Confirm `N` (default 8) and the arc
   across the slides. If I gave you a reference post or a style description,
   that governs; otherwise the extracted brand identity governs.
5. **Out of scope** - Posting to Instagram, exporting or screenshotting image
   files, and writing copy for other platforms. The deliverable is the HTML file
   and its post-notes, not a published post.

## What to produce

1. **One self-contained `.html` file** with all `N` slides as sibling
   `<section class="slide">` elements, each exactly `1080px x 1080px`.
2. **Measurement evidence for every slide** - the measured dimensions, and the
   result of the overflow check from method step 6, so the layout is proven
   rather than asserted.
3. **A `.post-notes` block in the same file**, below the slides and clearly
   labeled as not part of them, containing a suggested caption, a set of
   hashtags, and 2-3 posting tips (file size, screenshot method, bio link
   suggestion).
4. **The brand token set as `:root` CSS custom properties**, so the colors are
   tweakable in one place.

## Method

1. **Gather the real facts** - From scope items 1 and 2: what the project does,
   who it is for, its value proposition, real feature names, real per-category
   counts, and real sample titles. Record where each came from. Never make up
   stats, counts, or feature names.

2. **Extract the brand tokens** - From scope item 3:

   - **Colors** - the 1-3 accent colors actually used in the logo or badges,
     plus a neutral background and a text color. Record their exact hex values.
   - **Fonts** - the heading and mono/label families used in the lockup or
     badges, for example a display font for headings and a monospace for
     labels.
   - **Logo** - rebuild the mark as inline SVG, from the official SVG or by
     approximating its shapes and colors, so it can sit on each slide.
   - **Voice** - pull the org tagline and tone from the README, for example
     "built by students, for students", and reuse its phrasing.

3. **Plan the slide arc** - One idea per slide, big headlines, no walls of
   text. The recommended default structure for 8 slides, adapted to `N`:

   1. **Cover / hook** - a bold, benefit-led headline that makes people swipe,
      with a small "swipe" cue.
   2. **The problem** - the pain the project solves.
   3. **What it is** - overview: open-source status, key facts, verified
      numbers.
   4. **Feature / category grid** - chips with real per-category counts, or a
      key breakdown.
   5. **How it works** - a numbered 2-4 step walkthrough.
   6. **Why it is different** - the differentiators or core philosophy as short
      cards.
   7. **Real examples** - concrete items pulled from the repository in method
      step 1.
   8. **CTA** - a clear action such as starring on GitHub, the handle or URL,
      and a save/share prompt.

4. **Build the HTML** - All `N` slides as sibling sections in one file, with:

   - **No external dependencies** - no CDN links, no external fonts, no remote
     assets. Use the extracted brand fonts with sensible system fallbacks, for
     example `'Space Grotesk', system-ui, sans-serif`, and inline all SVG.
   - **Shared slide chrome** as the template: the logo top-left, an `NN / NN`
     page indicator top-right, and a footer strip with the handle and a short
     tagline. Repeat that exact chrome on every slide, varying only the content
     and the CTA.
   - **Brand values from `:root` variables**, the brand palette, brand fonts for
     headings, monospace for labels and tags, and the brand voice for all copy.

5. **Add the post-notes** - Below the slides in the same file, a clearly labeled
   `.post-notes` block that is not a slide: caption, hashtags, and posting tips.

6. **Verify the layout programmatically** - For every slide, confirm the content
   fits within the 1080x1080 bounds and does not overflow into the footer:
   - Render the file with a headless browser and measure each slide's content
     bounding box against the footer boundary.
   - Confirm each slide is exactly 1080x1080, and that `overflow:hidden` on the
     slide is clipping only intentional decorative elements, not real text or
     cards.
   - If a slide overflows, tighten that slide's font size, spacing, or copy and
     re-check until every slide fits cleanly.

## Verification

- [ ] Every fact, number, count, and feature name on the slides was read out of
      the repository, and the repo's actual category counts and naming are used.
- [ ] The visual style comes from the project's own brand tokens, or the
      absence of a discoverable brand was raised rather than invented.
- [ ] The file is one self-contained `.html` with no CDN links, external fonts,
      or remote assets, and it renders offline from `file://`.
- [ ] Every slide measures exactly 1080x1080, with each slide's measured
      dimensions pasted.
- [ ] No slide overflows its box; each was checked by rendering, not by eye.
- [ ] A caption, hashtags, and posting tips are delivered alongside the file.

## Rules

- Never invent a stat, count, or feature name. Every number on a slide must
  trace to a file you read.
- Never invent a visual identity. If the repository has no discoverable brand,
  ask me for one accent color and a heading font, or pick a clean, modern
  default and tell me what you assumed.
- Never let the HTML depend on the network. It must render correctly from a
  local file with no internet access.
- Never pad slides with placeholder content. If you have no real fact for a
  slot, leave the slide out or reshape the arc rather than fabricate.
- Never ship a slide you did not measure. If a headless browser is unavailable,
  say so explicitly and state what you reasoned about instead, keeping content
  vertically centered, capping headline sizes, and leaving generous margins.
