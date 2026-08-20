# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The GitHub profile README for `johnson2006christopher` (repo name matches the username, so `README.md` renders on the profile page). It is a **single content file** plus the images it references in `assets/` — there is no source code, no package manager, no build, test, or lint step. Do not add `package.json`, CI workflows, linters, or generators.

## Rendering gotchas

The README is Markdown wrapped around ~15 nested raw-HTML blocks (`<div align="center">`, `<table>`, `<td>`) and ~19 `<details>` panels. GitHub's renderer is unforgiving here:

- **Never leave a tag unclosed.** GitHub silently drops everything after an unbalanced `<div>` or `<table>` — the file looks fine in an editor and the live profile goes blank below the break. The `PostToolUse` hook in `.claude/settings.json` counts `div`/`table`/`tr`/`td` after every edit; keep `details`/`summary` balanced by hand.
- **Markdown inside an HTML block needs a blank line around it.** An HTML block runs until the next blank line, so a `![badge](url)` on the line *directly after* an `<img .../>` is swallowed and renders as literal `![badge](url)` text. Either insert a blank line or write that badge as `<img>` too. Same for `###` headings and fenced code against `<td>`.
- Use `<br/>` for vertical spacing between sections — blank lines alone collapse inside HTML blocks.
- Anything that must be centered goes inside `<div align="center">`; GitHub ignores CSS and most style attributes.
- Inside `<details>`, put a blank line after `</summary>` or the body renders as literal text.

## Visual conventions

Default to the existing style unless asked for a redesign (proposing alternatives is fine — just say so rather than quietly switching):

- Palette: cyan `#00F0FF` and violet `#A78BFA` on black `000000`, over the dark gradient `0F0C29 → 302B63 → 24243E`.
- Badges: `img.shields.io` with `style=for-the-badge&labelColor=000000` (or `-000000` in the badge slug), alternating cyan/violet `logoColor`.
- Section headings: numbered bracket + ALL-CAPS dotted name — ``## `◤ 04 ◢` SKILL.MATRIX``. Renumber the whole sequence if a section is inserted.
- Banners: `capsule-render.vercel.app` waving type, header at the top and footer at the bottom, same gradient reversed.
- Percent-encode text in `capsule-render` and `readme-typing-svg` URLs (`%20`, `%7C`, `%27` for apostrophes, emoji as `%F0%9F...`) — raw characters break the generated image.
- **Never put an `&` in `capsule-render` text or desc, encoded or not.** It writes the value into its SVG unescaped, which makes the SVG invalid XML and the banner fails to render entirely. Use `·` or the word "and".
- `capsule-render`'s wave is an empty `<path>` filled in by SMIL, and `animation=fadeIn` starts at `opacity: 0` — both render blank in static rasterizers but animate correctly in browsers. Don't "fix" a banner based on a local rasterized preview.

## Interactive elements

GitHub allows very little interaction; these are the pieces that actually work and should be preserved:

- `<details>/<summary>` collapsibles — used for the role-based panels in `ACCESS.TERMINAL`, every skill domain, project deep dives, the FAQ, and the easter egg. `<details open>` is honoured.
- `<a name="x"></a>` anchors (`top`, `access`, `skills`, `arch`, `systems`, `hire`, `uplink`) driving the nav badge row and the "↑ back to top" links. Every anchor must have a link and vice versa.
- Pre-filled issue links (`.../issues/new?title=...&body=...`) behind the UPLINK and "start a project" badges. Percent-encode the body; `%0A` for newlines. These break if Issues are disabled on the repo.

## 3D diagrams

`assets/arch-3d.svg`, `assets/skills-3d.svg`, and `assets/impact-3d.svg` are hand-generated isometric art, not exports from a tool. Projection is `screen = (0.866·(x−y), 0.5·(x+y) − z)`, painter-ordered back-to-front by `x+y`, with the palette above and CSS keyframes for the glow and rising packets (CSS/SMIL animation inside an SVG does run when GitHub serves it through an `<img>`). The counts in `skills-3d.svg` and its caption mirror `SKILL.MATRIX` — if a badge is added or removed, update the tower height, the per-domain count, and the total in the caption.

## Content rules

Awards, job titles, impact metrics, and project claims in this README are real credentials. Do not invent, embellish, or adjust them — add or change these only from information the user provides. The skill badge list has been pruned by hand to what is actually used; do not re-add technologies that were removed.

**Positioning (set by the user, do not drift):**

- The headline identity is **Full-Stack Software & AI Engineer** — front end and back end carry equal weight. Edge AI, CPU-first vision, and constrained-system work are framed as the specialised passion, not the whole job.
- "Next Gen Lab" was removed from the profile entirely (founder title, section heading, service list, FAQ). Do not reintroduce it. Client work is framed as **johnson working directly as an independent engineer**.
- Availability is the three-part line: full-time engineering roles, remote freelance / client projects, open-source collaboration. `08 AVAILABILITY` lists the five client services and must stay aligned with it.
- Roles that stay: Software & AI Engineer @ BLECA SmartLabs · Software & AI Engineering Intern @ Neurotech Africa · Computer Engineering @ MUST, Tanzania.
- **The profile-views badge is load-bearing.** Keep `<img src="https://komarev.com/ghpvc/?username=johnson2006christopher&color=0F0C29&style=for-the-badge&label=SCANS" alt="Profile views"/>` byte-for-byte — editing the URL or the username resets the counter. It must stay an `<img>` tag, not Markdown (see the HTML-block rule above).

## Workflow

Edits are committed and pushed directly to `main`; no branch or PR for README changes. External badge and link URLs rot silently (renamed repos, dropped PyPI packages) — run `/check-badges` after any edit that touches links. `github-profile-summary-cards` intermittently returns a rate-limit error card; that is service-side and not a broken URL.
