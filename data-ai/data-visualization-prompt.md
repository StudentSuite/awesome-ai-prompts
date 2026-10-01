# Reusable prompt: honest, accessible charts

Copy-paste the block below into any AI coding agent to build or review a data
visualization that answers a real question, stays readable for every reader
including color-blind ones, and can be checked against the numbers behind it.

Keywords: chart type, colorblind palette, axis labels, empty state, tooltips

---

Build the chart for `[the question a reader must be able to answer]` using the
data in `[file, table, or query in this repo]`. A chart is an argument about the
data. Make the choice defensible, the encoding readable without color, and the
rendering verifiable against the source numbers.

## Steps

1. **Name the question and the shape** - Write the question the reader brings
   to the chart, then state the data shape it implies: one measure over time,
   composition of a whole, comparison across categories, distribution,
   relationship between two measures, or flow. The shape picks the chart;
   never pick the chart first and hunt for a question later.
2. **Pick the least decorated chart that works** - Bar for comparison, line for
   trend, scatter for relationship, histogram for distribution, stacked area
   for composition over time. A table beats a chart for a handful of exact
   values. If two chart types would both answer the question, choose the one
   with fewer encoding channels and say why.
3. **Set honest axes and label everything** - Bar and area baselines start at
   zero unless you state the truncated range in the axis title. Show tick
   units and a real date or category label, never raw timestamps or IDs. Label
   every series directly at its end or in a legend, never by color alone. Name
   the measure, the population, and the time window on the chart face.
4. **Encode twice for accessibility** - Use a palette that stays distinguishable
   under deuteranopia, protanopia, and tritanopia, and pair it with a second
   channel: distinct marker shapes, line dash patterns, hatch patterns, or
   direct labels on the marks. Check contrast of text against background and
   state the checked background color. Keyboard users must reach the underlying
   values, so ship a table or an accessible name per mark.
5. **Handle every state, not just the happy one** - Design the empty state (what
   the reader should do next), the partial-data state, the single-datapoint
   state, the loading skeleton, and the error state with a plain message. Never
   render an empty frame with axes and no explanation.
6. **Size it responsively** - No fixed pixel width. Use the container, keep text
   legible at the narrowest supported breakpoint, avoid truncated axis labels,
   and on small screens drop series, shorten tick density, or scroll with a
   visible affordance rather than shrinking the type.
7. **Check the aggregation** - State the aggregation behind each mark (sum,
   mean, median, count) and the denominator. Show raw points or a sample count
   where averaging hides spread. Confirm that missing values are gaps or zeros
   by intent, not by accident, and that filters and date ranges are visible on
   the chart.
8. **Verify against the source numbers** - Recompute at least three mark values
   by hand from the source query and compare to what the chart renders. Paste
   the source values, the rendered values, and the diff. Then check the chart
   survives its own states by triggering empty, loading, and error in a
   screenshot or test run.

## Rules

- Never rely on color as the only encoding, and never ship a palette you have
  not checked for color-vision deficiency or for contrast against the chart
  background.
- Truncated axes on bar or area charts require the truncation stated on the
  axis label; a line chart over time may use a non-zero baseline when labeled.
- No 3D, no gratuitous animation, no rainbow scale for ordered data. Encode
  magnitude with position or length wherever the layout allows.
- If the data cannot support the question, say which field or grain is
  missing instead of drawing the chart anyway.
- Every chart ships with the table of the values it draws. Anything a reader
  cannot read off the chart should be in the alt text or the tooltip.

## Verification

Paste the source query, the mark values you recomputed by hand, and what the
chart renders, with the diff. Include the empty, loading, and error states, the
narrowest supported viewport, and the palette contrast check output.
