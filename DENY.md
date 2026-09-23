# DENY.md

Copy this into your own project root and edit it. `ux-lint` reads the nearest
one and **promotes everything listed here from advisory to blocking**.

This file is the whole point. Without it, `ux-lint` reports and exits 0, and a
check that cannot fail is a log line pretending to be a gate. Decide what your
project actually refuses, write it here, and wire it into CI.

## Refused, and the build fails

```
violet-accent-hex
violet-accent-tailwind
ai-gradient
invented-stats
placeholder-as-label
slop-copy
div-onclick
no-reduced-motion
color-only-meaning
hover-only-affordance
```

## Allowed here, with a reason

Every exception needs a line saying why, or it becomes the loophole that eats
the file.

```
soft-shadow      # the product is a card-based mobile UI; elevation is the model
stat-strip       # the numbers are measured and linked to the dashboard
```

## Project constants

Set these to your chosen system's actual values and the linter checks against
them rather than against generic defaults.

```
radius:        0, 9999
accent-count:  1
type-families: 2
type-weights:  400, 500
gradients:     none
display-max-weight: 400
```

## Wire it into CI

```yaml
# .github/workflows/design.yml
- run: ux-lint 'src/**/*.{tsx,css,html}' --max 0
```

Prove it refuses something on purpose before you trust it. Add a violet
gradient to a scratch file, watch the build go red, then delete it. A guard
that has never fired once is not installed.
