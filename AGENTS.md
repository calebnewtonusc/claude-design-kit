# AGENTS.md

Cross-agent parity file. Claude Code reads `CLAUDE.md`; other agents read this.
The content is the same doctrine, and `CLAUDE.md` is the longer version.

## Load order

1. `CLAUDE.md` is the doctrine. Read it before any UI work.
2. `skills/design-refusals/SKILL.md` before choosing a look.
3. `skills/interface-presets/SKILL.md` before building a component.
4. `skills/motion-budget/SKILL.md` before animating anything.
5. `data/constants.json` instead of guessing a number.

## The short version

The generated look is an empty deny list, not bad taste. Choose a real design
system whose brand logic is native to the subject, write down what it refuses,
and follow that literally. A palette tells a model what it may use and it will
use all of it. A refusal is what creates a recognizable look.

Behaviour comes from `presets/`, which never states colour or radius. Look
comes from the chosen system, which never states keyboard behaviour. They do
not overlap by design.

Motion is budgeted by frequency: something seen a hundred times a day gets no
animation at all.

## For agents without skill discovery

There is no hook system to rely on. Read the four files above directly at the
start of any task that is visibly about how something looks, and keep
`data/constants.json` open rather than recalling numbers from training.

## What this kit deliberately does not do

It does not score taste. It measures distance from the default, which is
tractable. Aesthetic scorers measure photorealism and conventionality; see the
note in `skills/design-refusals/SKILL.md`.
