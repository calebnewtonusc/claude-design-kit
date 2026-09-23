# claude-design-kit

Make your coding agent design like it has a point of view.

Every model produces the same competent page: violet-to-blue gradient, rounded
bordered card, four-up stat strip, pulsing emerald dot, "Let's build something."
That is the centroid of the training distribution, and the centroid is what
reads as generated.

Real design systems are not defined by what they permit. They are defined by
what they **refuse**, and the refusals are machine-readable. Shopify Polaris
bans raw hex and all 25 CSS length units in stylelint. Atlassian bans `<button>`
and `placeholder` in ESLint. Bugatti's entire radius scale is `0px` and `9999px`
with nothing between, no saturated colour, no display weight above 400.

This kit makes an agent choose a real system, write down what it refuses, and
follow that literally, before it writes a line of markup.

## Install

```bash
git clone https://github.com/calebnewtonusc/claude-design-kit
cd claude-design-kit && ./install.sh
```

Symlinks three skills into `~/.claude/skills`, references the doctrine from your
`CLAUDE.md` without overwriting it, and links the linter. It skips anything you
already have and says so. Set `CLAUDE_DIR` to install elsewhere.

For Codex, Cursor, or anything else that reads markdown, point it at
[AGENTS.md](AGENTS.md).

**Verify it took.** Start a session and ask for a landing page. The agent should
name a design system and its refusals *before* writing markup. If it opens with
a violet gradient, the doctrine did not load.

## What is in it

| | |
| --- | --- |
| [CLAUDE.md](CLAUDE.md) | the doctrine. Refusals, order of operations, the motion rule |
| [skills/design-refusals](skills/design-refusals/SKILL.md) | choose a system whose brand logic is native, extract its deny list |
| [skills/interface-presets](skills/interface-presets/SKILL.md) | what a component must DO, separate from how it looks |
| [skills/motion-budget](skills/motion-budget/SKILL.md) | what may move, how long, what curve |
| [data/constants.json](data/constants.json) | numbers with sources attached, so nothing gets re-derived |
| [presets/](presets/) | 8 behavioural specs: table, form, dialog, palette, toast, chart, nav, empty |
| [motion/](motion/) | measured motion specs and one teardown |
| [bin/ux-lint](bin/ux-lint) | fails the generated look, every rule carrying why and where from |
| [RESEARCH.md](RESEARCH.md) | why any of this works, with citations |

## The three ideas worth stealing even if you never install it

**1. Design the deny list, not the palette.** A palette tells a model what it
may use and it will use all of it. Write down what is forbidden: how many accent
colours exactly, which radius values exist, whether gradients exist at all,
maximum display weight. Then follow it literally. The most common failure is
picking a restrained system and adding one gradient "for warmth", which puts the
page straight back at the centroid.

**2. Budget motion by frequency, not by taste.**

| Seen by the user | Motion |
| --- | --- |
| 100+ times a day | **none** |
| Tens of times a day | reduced |
| Occasionally | standard |
| Rare or first-time | delight |

Raycast ships no open/close animation. An animation on a hundred-times-a-day
interaction is a tax charged a hundred times a day.

**3. Keep the structure canonical and spend novelty on the surface.**
Prototypicality has a large effect on first impressions at low complexity
(d = 1.96) and that effect is destroyed by high complexity. You cannot buy your
way out of clutter with familiarity. Put the nav where people expect it and
spend the budget on type, colour and motion.

## Make it actually fail

`ux-lint` reports and exits 0 by default, and a check that cannot fail is a log
line pretending to be a gate. Two ways to give it teeth:

```bash
ux-lint 'src/**/*.{tsx,css,html}' --max 0     # any hit fails
```

or copy [DENY.md](DENY.md) into your project root and list what you actually
refuse. Everything named there is promoted from advisory to blocking, and the
file doubles as the written deny list the doctrine asks for.

Run it against [corpus/generated-hero.html](corpus/generated-hero.html), the
archetypal generated page kept as a fixture. It should return 9 hits across 8
distinct tells. If it returns zero, your install is broken.

## What it will not do

It will not tell you a design is good. Nothing here measures quality; it
measures distance from the default, which is a different and more tractable
problem. Aesthetic scorers are actively bad at the quality question, and
[RESEARCH.md](RESEARCH.md) has the audit numbers.

It is also not a novel mechanism. `@shadcn/lint`, `ux-skill`, `auteur` and
`tinte` all ship executable deny lists, and `stylelint-polaris` has done it in
production for years. The prior-art section of RESEARCH.md is honest about what
this adds and what it does not.
