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

Keep the cloned folder where it is. The skills and linter are links into it, so
moving or deleting the folder breaks them. If you do move it, run `./install.sh`
again from the new spot.

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
| [bin/ux-lint](bin/ux-lint) | fails the generated look, every rule carrying its cost and its source |
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

---

# Resources

Curated, not exhaustive. Each entry says what makes it different from its
neighbours, because "a component library" is not a reason to pick one.

## Component libraries

The first question is not which library. It is **copy-paste or dependency**. A
copy-paste library puts the source in your repo and you own it forever, which
is what you want when the design has a point of view. A dependency keeps you on
someone else's upgrade path, which is what you want when it does not.

| | What it actually is |
| --- | --- |
| [shadcn/ui](https://ui.shadcn.com) | Copy-paste, you own the code. Radix primitives plus Tailwind. The default answer for React in 2026, and the reason is that you can edit it |
| [Radix Primitives](https://www.radix-ui.com/primitives) | Unstyled, accessible behaviour only. What shadcn is built on. Reach for it directly when you want zero opinion about looks |
| [Base UI](https://base-ui.com) | From the Radix and Material UI teams. Unstyled primitives, newer, actively converging with what shadcn needs |
| [Ark UI](https://ark-ui.com) | Headless, and the only one here that ships the same API for React, Vue **and** Solid. Built on Zag state machines |
| [Headless UI](https://headlessui.com) | Tailwind Labs' own unstyled set. Small surface, pairs natively with Tailwind |
| [Mantine](https://mantine.dev) | Batteries included, 100+ components and hooks. Fastest path when you do not want to assemble anything |
| [Park UI](https://park-ui.com) | Ark UI plus a design system layer. Panda CSS or Tailwind |
| [HeroUI](https://www.heroui.com) | Formerly NextUI. Styled, opinionated, good motion defaults out of the box |
| [Tremor](https://tremor.so) | Dashboard and chart components specifically. Stop hand-rolling KPI cards |

**Effects and motion-first sets.** These are where the "looks expensive"
components live. Use sparingly; a page built entirely from them reads as a
demo reel.

- [Aceternity UI](https://ui.aceternity.com) and [Magic UI](https://magicui.design), animated marketing components, copy-paste
- [Motion Primitives](https://motion-primitives.com), motion-first primitives built on Motion
- [Origin UI](https://originui.com) and [Cult UI](https://www.cult-ui.com), large shadcn-compatible collections
- [Kibo UI](https://www.kibo-ui.com), shadcn registry with the composite pieces shadcn leaves out
- [shadcn registries](https://ui.shadcn.com/docs/registry), the mechanism that lets any of these install with the same command

## Tailwind ecosystem

Tailwind v4 moved configuration into CSS and dropped the JS config file for most
uses, so check v4 support before adopting anything here.

- [Tailwind UI / Catalyst](https://tailwindcss.com/plus), official, paid, and the Catalyst kit is the closest thing to a Tailwind-native application UI
- [DaisyUI](https://daisyui.com), semantic class names on top of Tailwind, themeable, no JS
- [Flowbite](https://flowbite.com) and [Preline](https://preline.co), large free component sets with interactive behaviour
- [cva](https://cva.style), [tailwind-variants](https://www.tailwind-variants.org), [tailwind-merge](https://github.com/dcastil/tailwind-merge). Not optional at scale. `cva` gives variants a type-safe API, `tailwind-merge` stops class conflicts silently winning by source order

## Animation

Pick by what the thing actually is. Layout that rearranges is a different
problem from a timeline that scrubs.

| | Best at |
| --- | --- |
| [Motion](https://motion.dev) | Formerly Framer Motion, renamed and now framework-agnostic. Layout animation, gestures, springs. The default for React |
| [GSAP](https://gsap.com) | Timelines, sequencing, scroll orchestration. **Now free including all plugins** under Webflow, which removed the old paid-club barrier |
| [Anime.js](https://animejs.com) | Small, imperative, no framework. v4 is a full rewrite |
| [Lenis](https://lenis.darkroom.engineering) | Smooth scroll that does not break accessibility or anchor links. The one everybody actually uses |
| [Rive](https://rive.app) | Interactive state-machine animation. A real runtime, not a player. Use when the animation has logic |
| [Lottie / dotLottie](https://lottiefiles.com) | After Effects exports. Good for illustration, heavy for UI |
| [AutoAnimate](https://auto-animate.formkit.com) | One line, animates list add/remove/move. Highest ratio of effect to effort |
| [Theatre.js](https://www.theatrejs.com) | Visual sequencer for code animation. Overkill until suddenly it is not |
| [View Transitions API](https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API) | Native, cross-document as of 2024. Free page transitions with no library at all |

Before reaching for any of them, read [skills/motion-budget](skills/motion-budget/SKILL.md).
Most animation problems are solved by deleting the animation.

## 3D and canvas

- [Three.js](https://threejs.org), the substrate
- [React Three Fiber](https://r3f.docs.pmnd.rs) and [drei](https://drei.docs.pmnd.rs), Three as React components plus the helpers you would otherwise write
- [Spline](https://spline.design), design-tool 3D with a web runtime, no code
- [OGL](https://github.com/oframe/ogl), minimal WebGL when Three is too much
- [p5.js](https://p5js.org) and [Paper.js](http://paperjs.org), creative coding and vector graphics
- [Shadertoy](https://www.shadertoy.com), for reading shaders rather than shipping them

## Icons

Consistency matters more than the set. Pick one and do not mix.

- [Lucide](https://lucide.dev), 1,500+, clean 24px stroke geometry, the shadcn default
- [Phosphor](https://phosphoricons.com), six weights including duotone, the most flexible single family
- [Heroicons](https://heroicons.com), by Tailwind Labs, outline and solid, small and tidy
- [Tabler](https://tabler.io/icons), 5,000+, the largest consistent stroke set
- [Radix Icons](https://www.radix-ui.com/icons), 15px, built for dense UI
- [Iconoir](https://iconoir.com) and [Remix Icon](https://remixicon.com), strong free alternatives
- [Simple Icons](https://simpleicons.org), brand and company logos, which none of the above cover
- [Iconify](https://iconify.design), the aggregator, 200k+ icons across 150+ sets with one API

## Type

Type does more than anything else to stop a page reading as generated, because
the generated default is Inter and everyone knows what Inter looks like.

- [Google Fonts](https://fonts.google.com), free, ubiquitous, and the reason your page looks like every other page if you take the first suggestion
- [Fontshare](https://www.fontshare.com), free quality faces from Indian Type Foundry. **Satoshi**, **General Sans**, **Switzer**, **Clash Display**. If you change one thing about a page, change it here
- [Fontsource](https://fontsource.org), self-host any open font as an npm package, no Google request
- [Variable Fonts](https://v-fonts.com), what is actually variable and on what axes
- [Type Scale](https://typescale.com) and [Utopia](https://utopia.fyi), build the scale instead of guessing

Faces that currently read as designed rather than generated: Instrument Serif,
Newsreader, Fraunces (display serifs), Geist and Geist Mono, Satoshi, General
Sans, Bricolage Grotesque, Departure Mono.

## Colour

OKLCH matters now because it is perceptually uniform: lightening a colour by 10
actually looks like the same step across every hue, which HSL never did. Tailwind
v4 ships OKLCH by default, and CSS supports it natively.

- [OKLCH Color Picker](https://oklch.com), the one to learn in
- [Radix Colors](https://www.radix-ui.com/colors), 12-step scales designed so step 9 is always the accent and steps 3 to 5 are always backgrounds. Solves dark mode by construction
- [Realtime Colors](https://www.realtimecolors.com), see a palette on a real layout instead of on swatches
- [Coolors](https://coolors.co), fast exploration
- [APCA](https://apcacontrast.com/), the contrast model that is replacing WCAG 2 ratios, and which actually predicts legibility for thin light-on-dark text
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/), the one you cite in an audit

## Inspiration and reference

Each of these is good at a different thing. Using the wrong one is how you end
up with an award-site animation on a settings page.

| | Good for |
| --- | --- |
| [Mobbin](https://mobbin.com) | **Real product flows**, screen by screen, iOS and web. The single best reference for what an app should do, not how a landing page should look |
| [Godly](https://godly.website) | Curated award-tier web design, less noisy than Awwwards |
| [Awwwards](https://www.awwwards.com) | The maximalist end. Study the craft, do not copy the pattern into a SaaS product |
| [Land-book](https://land-book.com) and [SaaS Landing Page](https://saaslandingpage.com) | Landing pages specifically, filterable by industry |
| [Refero](https://refero.design) | Web app UI patterns, searchable by component |
| [Screens](https://screensdesign.com) | Mobile app flows with video |
| [Curated.design](https://curated.design), [Lapa Ninja](https://www.lapa.ninja), [Httpster](https://httpster.net) | Broad inspiration feeds |
| [Dark Mode Design](https://www.darkmodedesign.com) | Dark UI specifically, which is its own discipline |
| [Page Flows](https://pageflows.com) | Recorded user flows, onboarding and checkout especially |

## Design systems worth reading

Read these as specifications, not as galleries. The rules and the refusals are
the value.

[Linear](https://linear.app), [Stripe](https://stripe.com/docs) and
[Stripe Elements](https://stripe.com/payments/elements),
[Vercel Geist](https://vercel.com/geist/introduction),
[Shopify Polaris](https://polaris.shopify.com),
[Atlassian](https://atlassian.design),
[GOV.UK](https://design-system.service.gov.uk),
[IBM Carbon](https://carbondesignsystem.com),
[Material 3](https://m3.material.io),
[Apple HIG](https://developer.apple.com/design/human-interface-guidelines),
[GitHub Primer](https://primer.style),
[Adobe Spectrum](https://spectrum.adobe.com),
[Salesforce Lightning](https://www.lightningdesignsystem.com),
[Base (Uber)](https://base.uber.com).

Plus the corpus this kit is built around:
[VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md),
roughly 75 `DESIGN.md` files extracted from real production sites.

## Tools

- [Figma](https://figma.com) and [Penpot](https://penpot.app), the open-source alternative
- [tldraw](https://tldraw.com) and [Excalidraw](https://excalidraw.com), for thinking, not for specs
- [Storybook](https://storybook.js.org), component isolation, and the place your states actually get built
- [Polypane](https://polypane.app) and [Responsively](https://responsively.app), every breakpoint at once
- [VisBug](https://github.com/GoogleChromeLabs/ProjectVisBug), edit any live page like a design tool
- [Squoosh](https://squoosh.app) and [SVGOMG](https://jakearchibald.github.io/svgomg/), image and SVG compression
- [Ray.so](https://ray.so) and [Screely](https://www.screely.com), presentable screenshots

## Accessibility

Not a separate phase. Most of it is decided by which element you chose.

- [ARIA Authoring Practices Guide](https://www.w3.org/WAI/ARIA/apg/), the keyboard contract for every pattern. Read the one for your component before building it
- [WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/), filterable by level
- [axe DevTools](https://www.deque.com/axe/devtools/) and [WAVE](https://wave.webaim.org), catch the mechanical half
- [Pa11y](https://pa11y.org), the same checks in CI
- [Inclusive Components](https://inclusive-components.design), Heydon Pickering's pattern-by-pattern book. Free to read, and better than any checklist

## A note on these links

All 113 were checked on 2026-09-22 and 104 returned 200. Five
(Land-book, Lapa Ninja, Shadertoy, WebPageTest, LottieFiles) return 403 to a
plain HTTP client because they sit behind bot protection; they are live in a
browser. Cult UI rate-limited the check. Two were genuinely dead and have been
replaced: VisBug's old domain and the myndex.com APCA host.

## Performance

Current Core Web Vitals thresholds, "good" at the 75th percentile:

| Metric | Good | Note |
| --- | --- | --- |
| LCP | under 2.5s | largest contentful paint |
| **INP** | under 200ms | interaction to next paint, **replaced FID in March 2024** |
| CLS | under 0.1 | cumulative layout shift |

- [web.dev Vitals](https://web.dev/vitals/), the definitions
- [PageSpeed Insights](https://pagespeed.web.dev), field data plus lab
- [WebPageTest](https://www.webpagetest.org), when Lighthouse is not enough
- [Bundlephobia](https://bundlephobia.com), what that import actually costs

---

# Research

The full version with citations is [RESEARCH.md](RESEARCH.md). The short version
of why any of this works:

**The generated look has a mechanism, and the mechanism has numbers.** Fluent,
familiar, prototypical things get rated higher by humans. That bias enters the
reward model as a measurable term, fitted at 0.57 and 0.65 with p below 10^-14.
Optimising against it sharpens the distribution: Kirk et al.
([arXiv:2310.06452](https://arxiv.org/abs/2310.06452)) found RLHF "significantly
reduces output diversity", and on Tulu-3-70B direct prompting retains 23.8% of
base-model diversity. The sharpened output is nameable, and **naming is the
damage**, because once a viewer can say "that's AI" they have an explanation for
why the page read easily and the fluency-to-liking path is cut.

**Post-editing does not fix it, and it fails invisibly.** Generate-then-humanize
produces output that is still model-shaped underneath. A tool that scores and
rewrites a finished artifact is working at the wrong stage. The move that works
is conditioning on a narrow, specific corpus **before** generating, which is why
this kit front-loads the choice of system.

**Do not build a taste score.** The 2026 LAION-Aesthetics audit found the scorer
measures photorealism and conventionality: a Picasso scores 5.51 and loses to
conventional cityscape work at 7.09, and no African, Oceanian, Native American,
Islamic, Egyptian or West Asian work scored above 6.5. This kit measures
distance from the default instead, which is tractable.

**Colourfulness and visual complexity together carry 56% of first-impression
preference variance**, and overshooting complexity costs about three times what
undershooting costs. Prototypicality has a large effect at low complexity
(d = 1.96) that is destroyed by high complexity, so keep the layout archetype
canonical and spend the novelty budget on surface.

**Subtraction is the move nobody makes.** Adams et al., *Nature* 592 (2021):
people systematically overlook subtractive changes, and eight words of prompting
moved subtractive solutions by twenty points. Cognitive load suppressed it
reliably. That is why the motion fix list starts at "delete it".

**Dieter Rams' ten principles are nine prohibitions and four positive
instructions.** There is no rule saying "make it emotionally truthful". The
entire aesthetic is carried by what it forbids, which is the whole thesis of
this repo stated forty years earlier.

**Numbers that circulate and do not survive checking** are deliberately absent
from `data/constants.json` rather than guessed. Apple publishes no millisecond
durations anywhere in the HIG. Warp's "5ms input latency" is contradicted by
Warp's own benchmark page. Amazon's "100ms costs 1% of sales" traces to a 2006
talk. Every "Linear design system" token dump online is third-party
reverse-engineering. The 100ms instant threshold is real but comes from web.dev
RAIL, not from Miller 1968, which is the citation usually attached to it.

## Prior art, honestly

This mechanism is not novel and the framing is funded. `@shadcn/lint` ships
per-component allow/deny contracts with published agent evals. `ux-skill` ships
152 executable refusals and 160 brand specs. `auteur` fails builds on the
purple-blue AI gradient, `tinte` exits non-zero on colours bypassing tokens.
`stylelint-polaris` and `@atlaskit/eslint-plugin-design-system` have done this in
production for years. Taste Labs raised $18.5M in June 2026 to "end AI slop,
starting with design".

The first version of this project claimed to be "the first system to engineer
taste into AI". An adversarial prior-art pass killed that on the same day it was
written. What survived is smaller and checkable:

> Not the first system to engineer taste. A citable index of what named design
> systems refuse, where every constant traces to a source and nothing is
> invented.

## Contributing

The most useful contribution is a **new preset**, because presets are the part
that cannot be scraped. Read [presets/README.md](presets/README.md) for the
rules: state behaviour, states and constants, never colour or radius, and cover
every state including too-many and offline.

The second most useful is a **rule for `ux-lint` with real provenance**. Every
rule carries why it costs the user something and where the number came from. A
rule without both is not mergeable, because provenance is the only thing
separating this from the four projects above.

MIT licensed. Built with [Chewbacca](https://github.com/calebnewtonusc/Chewbacca).

All glory to God! ✝️❤️
