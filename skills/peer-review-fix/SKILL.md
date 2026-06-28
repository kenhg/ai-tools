---
name: peer-review-fix
description: Read .agents/code-review.md and apply its fixes, confirming each with the user first. Use when the user wants to act on a saved code review.
---

# Peer Review Fix

Manually-invoked skill that works through the findings in `.agents/code-review.md` and applies fixes.

## Process

1. Read `.agents/code-review.md`. If it does not exist, tell the user to run `peer-review` first and stop.

2. Parse the findings into a list, preserving their priority order (🔴 Critical → 🟡 Significant → 🔵 Minor).

3. For each finding, in order:
   - Show the user the finding and the concrete fix you propose (file, line, before/after).
   - Confirm before editing. Apply the fix only after the user agrees. The user may approve, skip, or amend.
   - Make the change surgical — touch only what the finding calls for.

4. After all findings are handled, display a summary table to the user with one row per finding:

   | Priority | Finding | File | Status |
   |----------|---------|------|--------|
   | 🔴 | ... | path:line | Fixed / Skipped / Deferred / N/A |

5. Once every finding has been addressed (fixed, skipped, deferred, or no longer applicable), delete `.agents/code-review.md`.

## Confirm-each unless told otherwise

Default to one confirmation per finding. If the user says to apply all, apply a priority tier, or "don't ask," proceed without per-finding confirmation for that scope — but still report what you changed.

## Notes

- Leave `.agents/code-review.md` intact while working through findings; it is deleted only in the final step, once all are addressed.
- If a fix is no longer applicable (code changed since the review), say so and skip it rather than forcing it.
