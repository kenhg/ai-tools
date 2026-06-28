---
name: peer-review
description: Run a code review and save the result to .agents/code-review.md. Use when the user explicitly asks for a peer review or to write a review to a file.
---

# Peer Review

Manually-invoked wrapper that runs the `review-my-code` skill and persists its output.

## Process

1. Invoke the `review-my-code` skill and let it produce the full review (scope, findings, output format are defined there — do not duplicate them here).

2. Write the review verbatim to `.agents/code-review.md` in the project root, creating the `.agents/` directory if it does not exist. Overwrite any existing file.

3. Tell the user the review is saved at `.agents/code-review.md` and surface the Summary and any 🔴 Critical Issues inline so they don't have to open the file.

## Notes

- Never edit the files under review — this skill only reads code and writes the review document.
- The review document is the single artifact; do not scatter notes elsewhere.
