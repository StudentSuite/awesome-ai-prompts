# Reusable prompt: honest, accessible charts

Copy-paste the block below into any AI coding agent to build or review a data
visualization that answers a real question, stays readable for every reader
including color-blind ones, and can be checked against the numbers behind it.

Keywords: chart type, colorblind palette, axis labels, empty state, tooltips

---

Build the chart for `[the question a reader must be able to answer]` using the
data in `[file, table, or query in this repo]`. A chart is an argument about
the data. Make the choice defensible, the encoding readable without color, and
the rendering verifiable against the source numbers.

## Steps

1. **Name the question, then the shape** - Write the question the reader brings, then the shape it implies: a measure over
   time, composition, comparison across categories, a distribution, a
   relationship, or a flow. The shape picks the chart.
2. **Pick the least decorated chart** - Bar for comparison, line for trend, scatter for relationship, histogram for
   distribution, stacked area for composition over time; a table beats a chart
   for a few exact values.
3. **Axes, labels, and states** - Baselines start at zero unless the axis title states the truncation. Label each
   series directly or in a legend, never by color alone; pair the palette with
   shapes, dash patterns, or hatch, keep it distinguishable under deuteranopia,
   protanopia, and tritanopia, and state the background and its contrast.
   Design the empty, partial-data, single-datapoint, loading, and error states.
4. **Aggregate, then verify** - Name the aggregation, denominator, filters, and missing values. Recompute at
   least three marks by hand, paste source, rendered, and diff values, then
   screenshot the empty, loading, error, and narrowest-viewport states.

## Verification

- [ ] The question and the data shape are stated, and the chart type follows
      from them rather than the reverse.
- [ ] No encoding relies on color alone, and the palette was checked for
      color-vision deficiency and for contrast against the stated background.
- [ ] Every truncated axis states the truncation on its label; no 3D,
      gratuitous animation, or rainbow scale for ordered data.
- [ ] The aggregation, denominator, active filters, and missing-value behavior
      are stated.
- [ ] At least three mark values were recomputed by hand, with the source,
      rendered, and diff values pasted.
- [ ] The empty, loading, error, and narrowest-viewport states are shown, and
      the chart ships with the table of values it draws.

## Rules

- Never rely on color as the only encoding, and never ship a palette you have
  not checked for color-vision deficiency or for contrast against the chart
  background.
- Truncated axes on bar or area charts require the truncation stated on the
  axis label; a line chart over time may use a non-zero baseline when labeled.
- No 3D, no gratuitous animation, no rainbow scale for ordered data. Encode
  magnitude with position or length wherever the layout allows.
- If the data cannot support the question, say which field or grain is missing
  instead of drawing the chart anyway.
- Every chart ships with the table of the values it draws. Anything a reader
  cannot read off the chart should be in the alt text or the tooltip.
