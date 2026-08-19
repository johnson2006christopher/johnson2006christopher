---
name: check-badges
description: Check every external badge, banner image, and link URL in README.md and report which ones are broken. Use after editing links, adding a project, or when the profile page shows blank or broken images.
---

Verify that every external URL in `README.md` still resolves.

## Steps

1. Extract all URLs from `README.md` — both Markdown image/link targets and any `src`/`href` in raw HTML:

   ```bash
   grep -oE 'https?://[^)"'"'"' >]+' README.md | sed 's/[),.]*$//' | sort -u
   ```

2. Request each one and record the status code. Use `-L` to follow redirects and a browser user-agent — some hosts reject default curl:

   ```bash
   while read -r url; do
     code=$(curl -sS -o /dev/null -w '%{http_code}' -L --max-time 15 \
       -A 'Mozilla/5.0' "$url" 2>/dev/null || echo 000)
     printf '%s  %s\n' "$code" "$url"
   done < urls.txt
   ```

   Run these concurrently (e.g. `xargs -P 8`) — there are 40+ URLs and serial checks are slow.

3. Report only what needs attention, grouped by kind:
   - **Dead** (404/410) — the target is gone. Name the line in `README.md` and say what it points at.
   - **Errors** (000, timeouts, 5xx) — could be transient; re-check these once before reporting.
   - **Redirects** (301/302 to a different final URL) — worth updating in place, e.g. a renamed GitHub repo.

   Say "all N URLs OK" and stop if nothing is broken. Do not list working URLs.

## Notes

- `shields.io`, `capsule-render.vercel.app`, `readme-typing-svg.demolab.com`, and `komarev.com` are dynamic image generators — they return 200 with a valid SVG even for a nonsense query, so a 200 does not prove the badge *reads* correctly. If a badge's content looks wrong on the live profile, fetch the SVG body and inspect its text rather than trusting the status code.
- A PyPI download/version badge going 404 usually means the package name changed or was yanked — flag it, don't silently rewrite it.
- `linkedin.com` and some social hosts return 403/999 to automated requests. Treat those as "could not verify", not as broken.
- Do not edit `README.md` in this skill unless the user asks — report first.
