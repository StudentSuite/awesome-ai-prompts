# Reusable prompt: Core Web Vitals optimization

Copy-paste the block below into any AI coding agent to diagnose and fix real
Core Web Vitals problems - measured in lab and field, with before/after proof.

A baseline-vs-after table per vital per page, the changes made ranked by
impact, and what remains with expected gains.

Keywords: core web vitals, lighthouse, page speed, largest contentful paint, layout shift, inp

---

Diagnose and improve this site's Core Web Vitals (LCP, INP, CLS). Work from
measurements: identify the dominant problem first, fix it, re-measure.
Optimizing the wrong thing is wasted effort.

## Steps

1. **Measure the baseline** - Lab runs (Lighthouse against production-like
   builds) and field data (RUM/CrUX if available) per page template. Record
   LCP, INP, CLS with the offending elements identified.
2. **Attack LCP first if it lags** - Usual suspects in order: render-blocking
   CSS/JS, slow server response (caching, streaming SSR), unoptimized hero
   images (right format and size, preload/priority hints), late-discovered
   resources. Fix the biggest contributor, not everything at once.
3. **Then INP** - Profile long tasks on interaction: hydration storms,
   oversized JS payloads, synchronous layout thrash. Split tasks, defer
   non-critical work, reduce shipped JS, memoize expensive renders.
4. **Then CLS** - Images/video without dimensions, late-loading fonts (use
   `font-display` plus preload), injected content above the fold, animations on
   layout properties. Reserve space; animate transform/opacity only.
5. **Guard the wins** - Bundle-size budgets and performance assertions in CI
   (Lighthouse CI or equivalent), an enforced image pipeline, and a RUM
   dashboard so regressions are seen in the field, not just the lab.

## Verification

- [ ] A baseline was measured against a production-like build, with field data
      alongside it.
- [ ] LCP, INP, and CLS each have a named culprit and a specific fix.
- [ ] Before and after numbers were re-measured under the same build and page,
      not estimated.
- [ ] Where field and lab data disagree, the field number decided.
- [ ] Bundle budgets and performance assertions are enforced in CI, so a
      regression fails the build.
- [ ] No vital was polished past comfortably green while another was still
      failing.

## Rules

- Never claim improvement without re-measuring under the same build and page
  conditions.
- Field data outranks lab data when they disagree - optimize what users
  experience.
- Once a vital is comfortably green, stop polishing it and move to the next.
