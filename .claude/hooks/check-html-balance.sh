#!/usr/bin/env bash
# PostToolUse hook: warn when README.md has unbalanced raw-HTML tags.
# GitHub silently drops all content after an unclosed <div>/<table>, so an
# imbalance is invisible locally and blanks out the live profile page.

f=$(jq -r '.tool_response.filePath // .tool_input.file_path // empty' 2>/dev/null)
case "$f" in
  *README.md) ;;
  *) exit 0 ;;
esac
[ -f "$f" ] || exit 0

problems=""
for tag in div table tr td; do
  open=$(grep -o "<$tag[ >]" "$f" | wc -l)
  close=$(grep -o "</$tag>" "$f" | wc -l)
  if [ "$open" -ne "$close" ]; then
    problems="${problems}<$tag>: $open opening vs $close closing. "
  fi
done

[ -z "$problems" ] && exit 0

jq -nc --arg m "Unbalanced HTML in README.md — $problems GitHub will drop everything after the unclosed tag." \
  '{systemMessage: $m, hookSpecificOutput: {hookEventName: "PostToolUse", additionalContext: $m}}'
