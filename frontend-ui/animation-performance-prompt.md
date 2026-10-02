# Reusable prompt: animation that stays smooth on a mid-range phone

Copy-paste the block below into any AI coding agent to build or repair motion
that holds its frame budget on a mid-range phone: compositor-only properties,
long frames measured during real interaction, a genuine reduced-motion
fallback, and before and after numbers.

Keywords: animation performance, compositor, transform, reduced motion, fps

---

Add or repair motion in `[component, stack]`. A smooth animation on a laptop
says nothing about a four-year-old phone, so every claim here ends in a
measured number against a frame budget you state up front. Produce the
rewritten animations, the profiling evidence, and the reduced-motion path.

## Steps

1. **State the target and the device** - Write down the frame-rate target and
   the device class it must hold on, because 60fps on a flagship says nothing
   about a mid-range phone.
2. **Inventory every animated property** - List each transition and keyframe
   and what it touches. Only `transform` and `opacity` stay off the main
   thread; a height change becomes a static geometry with a transform, and
   animating width, height, top, or margin is layout work.
3. **Profile during real interaction** - Record a scroll, a tap, and a route
   change in a real trace. Long frames come from layout, style, or paint, not
   from the animation's complexity.
4. **Fix what the trace actually blames** - Separate reads from writes to stop
   layout thrash; shrink the area being repainted; move the work off the main
   thread. Shortening the duration hides nothing.
5. **Write a real reduced-motion fallback** - Under `prefers-reduced-motion`,
   change what happens, not just how long it takes: cross-fade or snap instead
   of slide.
6. **Use compositor hints sparingly** - Each promoted layer costs memory, so
   `will-change` goes on the fewest elements, briefly.
7. **Measure before and after** - Record the identical interaction on the
   identical device and report frame rate and the dropped-frame count.

## Verification

- [ ] The frame-rate target and the device profile it was measured on are both
      stated.
- [ ] Every animated property is compositor-only, or a trace justifies the
      exception.
- [ ] A trace from real interaction is shown, with the blamed phase named.
- [ ] Reduced motion changes what happens, not only the duration.
- [ ] `will-change` is applied on demand to the fewest elements possible.
- [ ] Before and after numbers come from the same build, device, and
      interaction.

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
