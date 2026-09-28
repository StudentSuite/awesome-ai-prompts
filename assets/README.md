# Assets

Design sources that are not part of the prompt catalog.

## social-preview

- `social-preview.svg` - the editable source (1280x640, GitHub's required size)
- `social-preview.png` - the rendered file to upload

`social-preview.png` is the image to set as the repository's social preview:
**Settings > General > Social preview > Upload an image**. That upload is a
manual step in the GitHub UI, so it cannot be done from a commit.

To change the image, edit the SVG and re-render it to PNG. Keep it at
1280x640. The counts and category names in the SVG are a snapshot: if a
category is added or renamed, update the labels to match `README.md` so the
card does not advertise a catalog that has moved on.

The card is checked by measurement, not by eye, so a re-render cannot silently
regress: the title must stay inside the canvas, no label may overflow its pill,
the category pills must not overlap, and every text run must clear WCAG AA
contrast against the surface behind it. That last check is why two of the
catalog's own grays are not used verbatim: `.toc .count` (`#888`) is 3.30:1 and
`.prompt .meta` (`#777`) is 4.17:1 on the page background, both under the 4.5:1
needed for body text, so the card uses `#555` and `#666` instead.

Colors are taken from the CSS in `scripts/build-all.py` so the card reads as the
same product as `ALL_PROMPTS.html`: the `#f7f7f5` page background, `#1a1a1a`
ink, white cards with `#ddd` borders and 8px radii, and the `#2f4f7f` and
`#4a6fa5` blue accents. The card is light throughout, and its palette is a
closed set of eight colors. Three catalog colors are deliberately left out:
`#7fb3df` (the `.spec` badge) is 2.23:1 and too light to set text in, and
`#999`, `#111`, and `#333` have no role on a card this size.

Adding to or changing the palette means changing the card's whole color story,
so check the two things that break silently:

- Every color in the SVG must be one of those eight. A stray hex from an
  experiment is the exact failure this card already had once, when it shipped
  blue-on-navy against a page that is neither.
- Every text run must clear its WCAG AA threshold against the surface behind
  it. That check is why the card uses `#555` and `#666` for secondary text
  rather than the catalog's own `#888` and `#777`.
