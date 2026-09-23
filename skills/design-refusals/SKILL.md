---
name: design-refusals
description: Choose a real design system and follow what it refuses, so the result does not read as generated. Use before writing any UI, when a design "looks AI", when asked to make something look designed rather than generated, and when a page needs a point of view instead of a default. Also fires on: looks generic, ai slop, make it look good, redesign, restyle, landing page, hero section, brand, visual identity.
---

# Design refusals

## When this fires

Before the first line of UI, not after the complaint. If you are reading this
because someone already said "it looks AI", the fix is the same, you are just
doing it late.

## Why refusals and not palettes

A palette tells you what you may use, and a model will use all of it. A refusal
tells you what is forbidden, and forbidding is what creates a recognizable look.
Bugatti is recognizable because it has no accent colour, no gradient, no shadow,
radius of either 0 or a full pill, and never sets display type above weight 400.
Four refusals carry more identity than any palette.

## Step 1: choose a system whose logic is native

Pick from a real, documented system whose brand logic already belongs to the
subject. Borrowed logic reads as costume.

| Subject | Native logic | Systems to study |
| --- | --- | --- |
| Developer tool, dashboard | dense, keyboard-first, low chrome | Linear, Vercel Geist, GitHub Primer |
| Payments, trust, docs | legible, restrained, high contrast | Stripe, Shopify Polaris |
| Institutional, civic, forms | plain, accessible, unstyled by choice | GOV.UK, IBM Carbon |
| Physical goods, luxury | editorial, photographic, minimal type | Bugatti, Aesop-like editorial |
| Consumer marketplace | warm, photographic, one brand voltage | Airbnb, Material 3 |
| Enterprise application | systematic, token-driven, dense | Atlassian, Salesforce Lightning, Base |

The upstream corpus of extracted systems is
[VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md),
roughly 75 `DESIGN.md` files pulled from real sites. Clone it, read the one you
picked, and copy it into the repo as `reference/DESIGN.md`. A system that lives
only in this conversation is a system the next session will not have.

## Step 2: write the deny list before the code

Extract these from the chosen system and write them down explicitly. If the
system does not answer one, the answer is the most restrictive option.

```
gradients:      allowed / forbidden
accent colours: how many, exactly
shadows:        allowed / forbidden, and at what elevation
radius scale:   the complete set of permitted values
type families:  how many
type weights:   the complete set, and the max for display
borders:        hairline / none / heavy
motion:         what is allowed to move at all
capitalization: any all-caps? any title case?
imagery:        photographic / illustrated / none
```

Then follow it literally. The most common failure is choosing a restrained
system and then adding one gradient "for warmth", which puts the page straight
back at the centroid.

## Step 3: lint it

`bin/ux-lint <file>` fails the generated look with rules that each carry why
they exist and where the number came from. It is not a taste oracle; it catches
the tells that are mechanical.

## What this skill will not do

It will not tell you a design is good. Nothing here measures quality. It
measures distance from the default, which is a different and more tractable
thing. Aesthetic scorers are worse than useless at the quality question: the
2026 LAION-Aesthetics audit found the scorer rewards photorealism, scoring a
Picasso at 5.51 against a conventional cityscape at 7.09, with no African,
Oceanian, Native American, Islamic, Egyptian or West Asian work above 6.5.
Do not build a taste score and do not trust one.

## Prior art, honestly

This mechanism is not novel. `@shadcn/lint` ships per-component allow/deny
contracts with agent evals. `ux-skill` ships 152 executable refusals and 160
brand specs. `auteur` fails builds on the purple-blue AI gradient, `tinte`
exits non-zero on colours bypassing tokens. `stylelint-polaris` and
`@atlaskit/eslint-plugin-design-system` have done this in production for years.

What is less covered is making a **named system's own refusals selectable and
executable**, so "lint this page as Bugatti" is a command. That is the seam
this kit works in.
