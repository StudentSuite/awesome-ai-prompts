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
and the category pills must not overlap. Dark background, light text, and one
accent color, so it stays legible when a social card is scaled down to a
thumbnail.
