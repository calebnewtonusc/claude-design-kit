# Research

Why this kit works the way it does. Every claim here traces to a source, and
where a widely-repeated figure had no primary source it was left out rather
than guessed.

---

## 1. The mechanism of the generated look

The look is not a failure of taste. It is a measurable consequence of how these
models are trained, and the chain has four steps that each have a number.

**Step 1. Fluent, familiar, prototypical things get rated higher by humans.**
This is processing fluency, one of the oldest findings in empirical aesthetics.

**Step 2. That bias enters the reward model as a measurable term.** Fitted
coefficients came out at 0.57 +/- 0.07 and 0.65 +/- 0.07, both at p < 10^-14.

**Step 3. Optimizing against it sharpens the distribution.** Kirk et al.
(arXiv:2310.06452) found RLHF "significantly reduces output diversity" relative
to the base model. On Tulu-3-70B, direct prompting retains 23.8% of base-model
diversity.

**Step 4. The sharpened output is nameable**, and naming is the damage. "The AI
look" converted from a novelty advantage into a liability once audiences could
name it. The design response is therefore to **vary the surface so the output
cannot be named**, not to make it "better".

**Post-editing does not fix this, and it fails invisibly.** The
generate-then-humanize workflow produces output that is still LLM-shaped
underneath. A tool that scores and rewrites a finished artifact is operating at
the wrong stage. **The strong move is to condition on a narrow, specific corpus
before generating.** That is exactly what choosing a real design system and its
refusals does, and it is why this kit front-loads that choice.

---

## 2. Aesthetic scorers do not measure quality

Do not build a taste score. Do not trust one.

The 2026 LAION-Aesthetics audit found the scorer measures photorealism and
conventionality rather than quality. A Picasso scores 5.51 and loses to
conventional cityscape work at 7.09. Not one African, Oceanian, Native
American, Islamic, Egyptian or West Asian work scored above 6.5.

This kit therefore measures **distance from the default**, which is tractable,
and refuses to measure quality, which is not.

---

## 3. What actually predicts a good first impression

Reinecke's work is the strongest evidence base in the field for this question,
reaching adjusted R-squared of .48 on first-impression aesthetics from
computable features.

**Colourfulness and visual complexity together carry 56% of preference
variance.** Two levers, most of the outcome.

**Overshooting complexity costs roughly three times what undershooting costs.**
Asymmetric, which means the safe direction is simpler.

**The prototypicality interaction is the actionable finding.** Prototypicality
has a large effect at low complexity (d = 1.96) and that effect is destroyed by
high complexity. You cannot buy your way out of clutter with familiarity. The
design implication is precise: **keep the layout archetype and affordance
placement canonical, and spend your novelty budget on surface** (type, colour,
motion, imagery), not on structure.

A number that should keep anyone humble: the 20 Webby Award sites in that work
did not outperform the rest on measured first-impression aesthetics.

---

## 4. Subtraction is the move nobody makes

Adams et al., *Nature* 592 (2021), "People systematically overlook subtractive
changes". Participants defaulted to adding elements even when removing was
better and cheaper. **Eight words of prompting moved subtractive solutions by
twenty points.** Cognitive load reliably suppressed subtraction.

Direction is well supported, magnitude is unsettled; a 2024 cross-cultural
replication complicates the effect size.

This is why the motion fix list starts at "delete it" and why most motion
complaints resolve at step one or two, which nobody tries first.

---

## 5. Constraints as a spec, read literally

Dieter Rams' ten principles, read as a specification rather than a poster:
**nine of the ten are prohibitions.** Only four contain a positive instruction.
There is no rule saying "make it emotionally truthful". The entire aesthetic is
carried by what it forbids.

The parentheticals in each principle close the obvious loophole, which is the
second lesson in how to write a constraint that survives contact with a
generator.

On constraint volume, Acar, Tarakci and van Knippenberg (2019), *Journal of
Management* 45(1) report an inverted U for input constraints. The quantitative
curvilinear evidence is for **input** constraints; evidence for output
constraints is scarce and qualitative. The mechanism for output constraints is
exactly the generated-UI problem, so this kit applies them while flagging that
the evidence there is weaker.

---

## 6. Motion, measured

**The best single rule found is about frequency, not taste.** An interaction
seen 100+ times a day gets no animation; tens of times a day gets a reduced
one; only rare or first-time earns delight. Raycast ships no open/close
animation on its main window and that is correct.

**Published duration scales** exist and should be used instead of invented
numbers: Material 2 motion guidance, IBM Carbon's productive scale (70ms
button, 110ms fade, 150ms standard), Material 3's Durations class.

**Apple publishes no millisecond values anywhere in the Human Interface
Guidelines.** Any "Apple says 300ms" is somebody's reconstruction. Apple's
stated spring rule is real and useful: start at 100% damping, add overshoot
only when the gesture carried momentum.

**Measure the runtime, not the stylesheet.** Grepping `transition:` in shipped
CSS counts one population; reading `document.getAnimations()` in a browser
counts another. One teardown in this repo recorded a grep producing a tidy
"clean two-tier 220/450ms system" story while the runtime showed 8 distinct
durations and 3 infinite loops. Both readings were of real things. Only one
answered the question.

---

## 7. Numbers that circulate and do not survive checking

Left out of `data/constants.json` deliberately rather than guessed:

- **Apple's motion durations.** Not published. See above.
- **Warp's "5ms input latency".** Contradicted by Warp's own benchmark page.
- **Amazon's "100ms costs 1% of sales".** Traces to a 2006 talk, not a paper.
- **Every "Linear design system" token dump online.** All third-party
  reverse-engineering, none official.
- **The 100ms instant threshold** is real but is from web.dev RAIL and Paul
  Buchheit, **not** Miller 1968, which is the citation usually attached to it.

The discipline that produced this list is worth more than the list: when a
number cannot be traced, its absence is the honest record.

---

## 8. Prior art, and what is actually unclaimed

The anti-slop linter is not a new idea and the framing is funded.

| Project | What it ships |
| --- | --- |
| `@shadcn/lint` (2026-09-02, 2,226 stars) | per-component allow/deny contracts, errors written for an agent to fix, plus published agent evals |
| `ux-skill` (2026-05-24) | 152 executable regex refusals, `--fail-on high`, 160 brand specs each with an `ai_slop_avoided` list |
| `auteur` (1,022 stars) | fails builds on the purple-blue AI gradient |
| `tinte` (621 stars) | exits non-zero on any colour bypassing tokens |
| `stylelint-polaris`, `@atlaskit/eslint-plugin-design-system` | production deny lists, for years |

**Taste Labs raised $18.5M** in June 2026 explicitly to "end AI slop, starting
with design", with a thousand-expert judging network.

Two seams are genuinely less covered, and they are where this kit works:

1. **Nobody ships a corpus of what many named real systems refuse, with
   provenance.** `ux-skill`'s rules have no provenance field; they are
   hand-authored regexes against generic tells, derived from no system.
   `@shadcn/lint` ships six generic rules and expects you to author the rest.
2. **Everywhere else, the executable rules and the design-system rules are
   different objects.** What is enforced is generic; what is system-specific is
   advisory prose. Making a named system's own refusals executable and
   selectable, so "lint this page as Bugatti" is a command, is unclaimed.

The honest version of the claim, after the prior-art pass killed the first one:

> Not the first system to engineer taste. A citable index of what named design
> systems refuse, where every constant traces to a source and nothing is
> invented.

---

## Bibliography

Roughly 80 primary sources sit behind the above. The heaviest-used:

**Usability and interface research**
Nielsen Norman Group (11 articles: skeleton screens, error message guidelines,
empty states, response times), W3C WAI and the ARIA Authoring Practices Guide,
WebAIM, web.dev RAIL.

**Design systems, primary documentation**
IBM Carbon (v10 motion), Material 2 and Material 3 (Flutter Durations class),
Shopify Polaris and `stylelint-polaris`, Atlassian Design System, GOV.UK Design
System, Apple Human Interface Guidelines, Raycast developer docs.

**Papers**
arXiv:2310.06452 (Kirk et al., RLHF and output diversity), arXiv:2409.01754,
arXiv:2502.20503, arXiv:2510.01171, arXiv:2510.13939, arXiv:2601.06060,
arXiv:2601.09896, arXiv:2604.24444. Adams et al., *Nature* 592 (2021).
Acar, Tarakci and van Knippenberg, *Journal of Management* 45(1) (2019).
Cleveland and McGill on graphical perception. Reinecke on first-impression
aesthetics.

**Design theory**
Dieter Rams, ten principles (Vitsoe). Stanford Encyclopedia of Philosophy on
aesthetics and taste (10 entries). Hume, "Of the Standard of Taste". Paul
Graham's essays on taste and design.

**Corpora**
[VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md),
roughly 75 `DESIGN.md` files extracted from real production sites. This kit
does not redistribute that corpus; it tells you how to use it.

**A note on what is not here.** The upstream research also drew on a video
corpus of design talks and critiques. Those transcripts are not redistributable
and are not included. The findings extracted from them are.
