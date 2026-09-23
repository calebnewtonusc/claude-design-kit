---
name: motion-budget
description: Decide what is allowed to move, for how long, and on what curve, using measured constants rather than taste. Use when adding any animation or transition, when an interface feels sluggish or busy, when implementing scroll effects, and when handling prefers-reduced-motion. Also fires on: animation, transition, easing, scroll effect, parallax, micro-interaction, feels slow, too much motion.
---

# Motion budget

## Decide whether it moves at all, first

| Seen by the user | Motion |
| --- | --- |
| 100+ times a day | **none** |
| Tens of times a day | reduced |
| Occasionally | standard |
| Rare or first-time | delight |

This rule does more work than anything else in the kit. An animation on a hundred-times-a-day
interaction is a tax charged a hundred times a day. Raycast ships no open/close
animation on its main window and that is a correct decision, not an oversight.

## Durations, from the systems that published them

`data/constants.json` carries the full scales with sources. Summary:

- Desktop standard 150ms, desktop max 200ms. Mobile standard 300ms, complex
  375ms, tablet roughly 1.3x desktop. Source: Material 2 motion guidance.
- IBM Carbon's productive scale: 70ms for a button or toggle, 110ms for a fade,
  150ms for a standard move, rising to 400ms for large expressive motion.
- Apple publishes **no** millisecond values anywhere in the Human Interface
  Guidelines. Any "Apple says 300ms" you have read is somebody's reconstruction.

## Easing

- Standard `cubic-bezier(0.4, 0, 0.2, 1)`.
- Entrance curve for things arriving, exit curve for things leaving. Asymmetric
  timing is most of what makes motion feel considered.
- `linear` only for constant-rate motion, such as a looping plot or a spinner.
  On anything that starts and stops it reads as mechanical.

## Springs

Start at 100% damping, zero overshoot. Add overshoot **only** when the driving
gesture carried momentum. Apple's Music app uses 100% damping on tap and 80% on
swipe, which is the rule stated as a product.

## The physics that is not optional

- Animate `transform` and `opacity`. Those are the GPU path.
- `background-image`, `color`, `box-shadow` and `border-radius` cost paint.
- `width`, `height`, `top`, `left` and `margin` cost layout. Never animate them.
- Frame budget is 16.66ms at 60fps and roughly 6ms of that belongs to the
  browser, so yours is about 10ms. A missed frame is a defect, not a degradation.
- Never `scale(0)`. Nothing in the real world appears from nothing. Use
  `scale(0.9)` to `scale(0.97)` plus opacity, and scale popovers, dropdowns and
  tooltips from their trigger.
- CSS transitions retarget mid-flight; `@keyframes` restart from zero. Use
  transitions for anything triggered rapidly, such as toasts and toggles.

## Reduced motion

`prefers-reduced-motion` has two values, `no-preference` and `reduce`. The spec
says the user agent "removes, reduces, **or replaces**" motion. It does not say
delete. Keep opacity and colour, drop transforms. Deleting all motion loses the
spatial cues that told the user where a thing came from, which is its own
accessibility failure.

## Scroll-driven animation

Native `animation-timeline: scroll()` support is around 87% of traffic. Gate it
with `@supports (animation-timeline: scroll())` and keep the effect decorative,
because roughly 13% of traffic will not run it and must still get a coherent page.

## When it is wrong, fix in this order

1. Delete it
2. Reduce it
3. Fix the easing
4. Fix the origin
5. Make it interruptible
6. Move it to the GPU
7. Make the timing asymmetric
8. Polish
9. Accessibility and cohesion

Most motion complaints are solved at step 1 or 2 and nobody tries those first.

## Measure the runtime, never the stylesheet

Grepping `transition:` in shipped CSS counts one population. Reading
`document.getAnimations()` in a real browser counts another. A teardown in
`motion/measured-motion.md` records a case where the grep produced a tidy
"clean two-tier 220/450ms system" story and the runtime showed 8 distinct
durations and 3 infinite loops. Both readings were of real things. Only one was
the answer.
