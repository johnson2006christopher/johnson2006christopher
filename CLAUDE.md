# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The GitHub profile README for `johnson2006christopher` (repo name matches the username, so `README.md` renders on the profile page). It is a **single content file** — there is no source code, no package manager, no build, test, or lint step. Do not add `package.json`, CI workflows, linters, or generators.

## Rendering gotchas

The README is Markdown wrapped around ~20 nested raw-HTML blocks (`<div align="center">`, `<table>`, `<td>`). GitHub's renderer is unforgiving here:

- **Never leave a tag unclosed.** GitHub silently drops everything after an unbalanced `<div>` or `<table>` — the file looks fine in an editor and the live profile goes blank below the break.
- **Markdown inside an HTML block needs a blank line around it.** Badges and images work inline, but a `###` heading or fenced code block directly against `<td>` renders as literal text.
- Use `<br/>` for vertical spacing between sections — blank lines alone collapse inside HTML blocks.
- Anything that must be centered goes inside `<div align="center">`; GitHub ignores CSS and most style attributes.

## Visual conventions

Default to the existing style unless asked for a redesign (proposing alternatives is fine — just say so rather than quietly switching):

- Palette: cyan `#00F0FF` and violet `#A78BFA` on black `000000`, over the dark gradient `0F0C29 → 302B63 → 24243E`.
- Badges: `img.shields.io` with `style=for-the-badge&labelColor=000000` (or `-000000` in the badge slug), alternating cyan/violet `logoColor`.
- Section headings: emoji + ALL-CAPS dotted name — `## ⚡ SYSTEM.STACK`, `## 🛰️ FEATURED.PROJECTS`.
- Banners: `capsule-render.vercel.app` waving type, header at the top and footer at the bottom, same gradient reversed.
- Percent-encode text in `capsule-render` and `readme-typing-svg` URLs (`%20`, `%7C`, emoji as `%F0%9F...`) — raw characters break the generated image.

## Content rules

Awards, job titles, impact metrics, and project claims in this README are real credentials. Do not invent, embellish, or adjust them — add or change these only from information the user provides.

## Workflow

Edits are committed and pushed directly to `main`; no branch or PR for README changes. External badge and link URLs rot silently (renamed repos, dropped PyPI packages) — run `/check-badges` after any edit that touches links.
