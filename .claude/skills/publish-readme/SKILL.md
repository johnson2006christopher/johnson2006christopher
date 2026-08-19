---
name: publish-readme
description: Commit the current README.md changes and push them to main. User-triggered only.
disable-model-invocation: true
---

Publish the pending README change. Extra context from the user: $ARGUMENTS

## Steps

1. Show what is about to be published:

   ```bash
   git status --short && git diff --stat && git diff
   ```

   If there is nothing to commit, say so and stop.

2. Sanity-check the diff before committing — these are the failure modes that only show up on the rendered profile:
   - `<div>`/`</div>` and `<table>`/`</table>` counts still balance
   - no raw spaces or unencoded characters inside `capsule-render` / `readme-typing-svg` URLs
   - any new badge follows the existing `style=for-the-badge&labelColor=000000` convention

   Report anything off and ask before proceeding.

3. Confirm the current branch is `main`. If it is not, stop and ask.

4. Commit with a short message describing the content change — what changed on the profile, not "update README". Use `$ARGUMENTS` as the message if the user supplied one.

5. Push to `origin main`.

6. Tell the user the profile is live at https://github.com/johnson2006christopher and that GitHub's image CDN caches badges for a few minutes, so a changed badge may lag behind the commit.
