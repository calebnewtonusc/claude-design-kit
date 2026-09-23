# Design doctrine

Loads when the work is visibly about how something looks. Applies to `.tsx`,
`.jsx`, `.css`, `.html`, `.vue`, `.svelte`, and any task where someone will
look at the result and form an opinion.

## The one idea

The generated look comes from an empty deny list.

Every model has seen enough interfaces to produce a competent one, and does,
every single time: the violet-to-blue gradient, the rounded bordered card, the
four-up stat strip, the pulsing emerald status dot, "Let's build something."
None of those are mistakes. They are the centroid of the training distribution,
and the centroid is what reads as generated.

Real design systems are not defined by what they permit. They are defined by
what they **refuse**, and the refusals are machine-readable:

- Shopify Polaris bans raw hex and all 25 CSS length units in stylelint.
- Atlassian bans `<button>` and `placeholder` in ESLint.
- GOV.UK bans pasted hex in Sass.
- Bugatti's radius scale is `0px` and `9999px` with nothing between, no
  saturated colour, no display weight above 400.

Adopting one brand's refusals removes most of the generated signal, because
every generated page has the thing that brand forbids.

## The order of operations

1. **Pick a system before writing a line.** Choose one whose brand logic is
   native to the subject, not borrowed. Automotive language for a car importer,
   editorial for a writer, institutional for a government form. Copy its
   constraints into the repo as `reference/DESIGN.md` so the next session
   inherits them instead of re-deriving.
2. **Follow the refusals literally.** If the system has no gradient, you have
   no gradient. The constraint is the product.
3. **Load a preset for behaviour.** `presets/` says what a component must DO:
   every state, every keyboard path, every failure. It never says colour or
   radius, because those come from the system. The two do not overlap.
4. **Budget the motion.** See below. Most interfaces are over-animated.
5. **Lint before shipping.** `bin/ux-lint` fails the generated look.

## Motion, the best single rule

Match motion to how often the user sees the interaction, not to how much you
like it:

| Seen | Motion |
| --- | --- |
| 100+ times a day | **none** |
| Tens of times a day | reduced |
| Occasionally | standard |
| Rare or first-time | delight |

Raycast ships no open/close animation. That is correct, not lazy. An animation
on something you do two hundred times a day is a tax you charge two hundred
times.

Animate `transform` and `opacity` only. Never animate `width`, `height`, `top`,
`left` or `margin`; those cost layout. Never `scale(0)`, because nothing in the
real world appears from nothing; go `scale(0.96)` plus opacity.

`prefers-reduced-motion` means reduce, not delete. The spec says "removes,
reduces, **or replaces**". Keep opacity and colour, drop transforms.

## Numbers you should not re-derive

`data/constants.json` carries them with sources attached. Response budgets,
Material and Carbon duration scales, easing curves, loading thresholds, spring
damping, empty-state requirements, scroll-driven-animation support. Read it
rather than guessing, and note what is deliberately **absent**: figures that
circulate widely without a primary source were left out rather than invented.

## Refusals that apply everywhere

- No violet-to-blue gradient on anything.
- No text over a busy image without a solid scrim.
- No more than two font families, and no more than four weights.
- No `<div>` with an onClick where a `<button>` belongs.
- No colour as the only carrier of meaning.
- No animation on an interaction seen more than tens of times a day.
- No placeholder as a label.
- No state left undesigned. Loading, empty, error, one, many, too many,
  offline. A missing state is a defect, not an omission.
- No centred numeric column.
- No hover-only affordance, because touch has no hover.

## The test

Before shipping, ask what this page **refuses to do** that a generated page
would have done. If there is no answer, the system was never chosen and the
result is the centroid.
