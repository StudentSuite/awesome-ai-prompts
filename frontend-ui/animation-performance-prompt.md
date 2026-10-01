# Reusable prompt: animation that stays smooth on a mid-range phone

Copy-paste the block below into any AI coding agent to build or repair motion
that holds its frame budget on a mid-range phone: compositor-only properties,
long frames measured during real interaction, a genuine reduced-motion fallback,
and before and after numbers.

Keywords: animation performance, compositor, transform, reduced motion, fps

---

Add or repair motion in `[component, stack]`. A smooth animation on a laptop
says nothing about a four-year-old phone, so every claim here ends in a measured
number against a frame budget you state up front. Produce the rewritten
animations, the profiling evidence, and the reduced-motion path.

## Steps

1. **State the target and the device first** - Write down the frame-rate target
   and the measurement device, for example 60 fps with frames under 16.7 ms on a
   throttled mid-range Android profile. Without a stated target, "feels smooth"
   is unfalsifiable and cannot be traded against anything.
2. **List every property you animate** - Inventory the transitions and keyframes
   and mark each property. Layout-triggering: width, height, top, left, right,
   bottom, margin, padding, font-size. Paint-triggering: box-shadow, filter,
   background-color, border-radius. Only transform and opacity avoid both.
3. **Rewrite to the compositor** - A height change becomes a static geometry
   plus `transform: scaleY()` with the origin on the right edge. A shadow pulse
   becomes an opacity crossfade on a pre-rendered pseudo-element. A slide
   becomes `translateX`, and a color or blur change becomes `opacity` on two
   stacked
   layers. Show each rewrite beside the original it replaces.
4. **Profile during real interaction** - Record a scroll, a tap, and a route
   change in a performance panel or trace on the throttled mid-range profile,
   with CPU throttling on. Count long tasks and over-budget frames inside the
   interaction window, not while an animation runs untouched. Paste the frame
   timeline.
5. **Fix what the trace actually blames** - Over-budget frames usually come from
   synchronous work in the event handler, not from CSS. Show that work moved out
   of the interaction path: values precomputed before the gesture, work batched
   into idle time, or long lists virtualized. Then re-run the same trace and
   show the numbers moved.
6. **Write a real reduced-motion fallback** - Under the reduced-motion media
   query, replace travel with a crossfade or an instant state change, drop
   parallax, looping, and auto-playing decoration, and shorten what remains. Not
   a token that sets a duration to zero and leaves a 400 pixel slide in place:
   the fallback is a different animation, not a shorter one.
7. **Use compositor hints sparingly** - Each promoted layer costs memory, so a
   `will-change` in a shared rule can cost more than the animation saved. Set it
   on the one or two elements that actually animate, remove it when the
   interaction ends, and never leave it on a permanent element.
8. **Measure before and after** - Record the identical interaction on the
   identical profile before and after, and paste both numbers: median frame
   time, over-budget frame count, and dropped frames. If the after numbers are
   not better, revert.

## Rules

- Only transform and opacity animate; any other animated property needs a
  written reason it survived review.
- No smoothness claim without a measured number and the device profile it came
  from.
- Reduced motion changes what happens, not only how long it takes.
- `will-change` is applied on demand, to the fewest elements possible, and
  removed afterward.
- Layout thrash is fixed by separating reads from writes, not by shortening the
  duration.

## Verification

Paste the before and after traces of the same interaction on the same throttled
profile, the median frame time and over-budget frame counts for both, the
property list with each replacement, and a capture of the reduced-motion
fallback running with the query enabled.
