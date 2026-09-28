# Assets

Design sources that are not part of the prompt catalog.

## social-preview

- `social-preview.svg` - the editable source (1280x640, GitHub's required size)
- `social-preview.png` - the rendered file to upload

`social-preview.png` is the image to set as the repository's social preview.
Per [GitHub's docs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/customizing-your-repositorys-social-media-preview),
that means: open the repository, click **Settings** under the repo name, scroll
to **Social preview**, click **Edit**, then **Upload an image...**. That upload
is a manual step in the GitHub UI, so it cannot be done from a commit. GitHub
accepts a PNG, JPG, or GIF under 1 MB and recommends 1280x640, which is what
this is.

To change the image, edit the SVG and re-render it to PNG. Keep it at
1280x640, then re-upload it.

## No numbers on the card

The card states no counts: no per-category numbers in the pills, no
"13 CATEGORIES" label, no prompt total in the footer. This is deliberate, not
an omission. A number on a social card is a snapshot that goes stale the moment
someone opens a pull request, and a card advertising 98 prompts when the repo
holds 101 is worse than a card that never claimed a figure. The names are the
only thing left that can drift, and they only change when a category is added
or renamed.

Two consequences worth knowing:

- Adding a prompt never requires re-rendering or re-uploading the card.
- Adding, removing, or renaming a category does. Update the pill labels to
  match the `##` headings in `README.md` and the number of category folders.

## What is checked

The card is checked by measurement, not by eye, so a re-render cannot silently
regress. The title must stay inside the canvas, no label may overflow its pill,
the category pills must not overlap, no digit may appear in any text run, and
every text run must clear WCAG AA contrast against the surface behind it.

That contrast check is why two of the catalog's own grays are not used verbatim:
`.toc .count` (`#888`) is 3.30:1 and `.prompt .meta` (`#777`) is 4.17:1 on the
page background, both under the 4.5:1 needed for body text, so the card uses
`#555` and `#666` instead.

Colors are taken from the CSS in `scripts/build-all.py` so the card reads as the
same product as `ALL_PROMPTS.html`: the `#f7f7f5` page background, `#1a1a1a`
ink, white cards with `#ddd` borders and 8px radii, and the `#2f4f7f` blue
accent. The card is light throughout, and its palette is a closed set of seven
colors. Catalog colors deliberately left out: `#4a6fa5`, which was the
pill-count color and has no role once the counts are gone; `#7fb3df` (the
`.spec` badge), which is 2.23:1 and too light to set text in; and `#999`,
`#111`, `#333`, and `#ccc`, which have no role on a card this size.

Adding to or changing the palette means changing the card's whole color story,
so check the two things that break silently:

- Every color in the SVG must be one of those seven, and every one of the seven
  must actually appear. A stray hex from an experiment is the exact failure this
  card already had once, when it shipped blue-on-navy against a page that is
  neither. A declared-but-unused color is the harmless version of the same
  drift, and is worth catching too.
- Every text run must clear its WCAG AA threshold against the surface behind it.
