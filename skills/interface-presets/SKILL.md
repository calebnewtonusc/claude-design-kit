---
name: interface-presets
description: Load the behavioural spec for a component instead of re-deriving it. Covers data tables, forms, dialogs, command palettes, toasts, charts, sidebar nav and empty states, with every state, keyboard path and failure mode. Use when building any of those, when a component is missing states, or when keyboard and screen-reader behaviour needs to be right the first time.
---

# Interface presets

## The split that makes this work

A design system answers **what should this look like**. It cannot answer what a
dashboard should do, because systems are extracted from marketing pages. A
census of 64 machine-readable systems found 64 product-UI components against
365 marketing ones, so even a developer-tool brand's corpus carries
`pricing-card` and `testimonial-card`.

`presets/` answers **what should this DO**. It never states colour, radius or
type, because those come from the chosen system. Pick a system for appearance,
load a preset for behaviour, and they do not overlap.

## Available

| Preset | The thing it stops you getting wrong |
| --- | --- |
| `data-table` | `table` vs `grid` ARIA, which decides your tab order. A 50-row table with 3 buttons per row is 150 tab stops if you choose wrong |
| `form` | error placement, validation timing, label vs placeholder, autofill |
| `dialog` | focus trap, focus restore, scroll lock, escape, the `focusout` null-relatedTarget bug that pegs the CPU |
| `command-palette` | one palette one key, the same shortcut must close it, focus restore |
| `toast` | severity routing, timing, never the only carrier of an error |
| `chart` | encoding choice by Cleveland and McGill ranking, not by what looks good |
| `sidebar-nav` | current-page semantics, collapse behaviour, touch targets |
| `empty-state` | say which of the three it is: loading, error, or genuinely no data |

## The rule every preset enforces

**Every state, or it is a defect.** Loading, empty, error, one, many, too many,
offline. The most common shipped bug in generated UI is a component that only
renders the happy path with three plausible rows in it.

## How to use

Read the preset file before writing the component, not after review. They are
short, 70 to 160 lines, and they are compiled from specifications, papers and
the shipped source of the libraries that got the primitive right, rather than
scraped from marketing pages.

Reading the ARIA Authoring Practices Guide tells you the keyboard contract.
Reading Radix's focus-scope source tells you that `focusout` with a null
`relatedTarget` must be ignored or the CPU pegs. That second kind of thing is
what actually breaks, and it is only in the source.
