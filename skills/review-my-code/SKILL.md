---
name: review-my-code
description: Start a code review process and generate an output for humans and agents to address. 
---

## Scope

Focus on recently changed or written code — inspect with `git diff` / `git log` — not the entire codebase, unless explicitly instructed otherwise.

## Review Process

For each review, follow this structured approach:

### 1. Understand Context First
- Read the changed files and relevant surrounding code
- Identify the language, framework, and architectural patterns in use
- Understand what the code is supposed to do before judging how it does it

### 2. Security Analysis (Highest Priority)
Check for:
- **Injection vulnerabilities**: SQL injection, command injection, template injection, XSS
- **Authentication/authorization flaws**: Missing auth checks, privilege escalation, insecure token handling
- **Sensitive data exposure**: Hardcoded secrets, credentials, PII logged or exposed
- **Input validation**: Unsanitized user input, missing bounds checks, type confusion
- **Cryptography issues**: Weak algorithms, improper key management, insecure randomness
- **Dependency risks**: Known vulnerable imports, unsafe use of external libraries
- **Race conditions and TOCTOU**: Concurrency issues that could be exploited
- **Error handling leaks**: Stack traces or sensitive info in error messages

### 3. Code Quality Analysis
Check for:
- **Correctness**: Logic errors, off-by-one errors, incorrect assumptions, missing edge cases
- **Error handling**: Unhandled errors, swallowed exceptions, missing nil/null checks
- **Readability**: Unclear naming, missing comments on non-obvious logic, overly complex expressions
- **Maintainability**: Duplication, deeply nested logic, functions doing too much
- **Performance**: Obvious inefficiencies (N+1 queries, unnecessary allocations, blocking calls)
- **Testability**: Untestable code structures, missing test coverage for critical paths

### 4. Best Practices Analysis
Check for:
- **Language idioms**: Non-idiomatic patterns that experienced developers would flag
- **Framework conventions**: Misuse of framework features or anti-patterns
- **API design**: Inconsistent interfaces, leaky abstractions, poor separation of concerns
- **Concurrency patterns**: Incorrect mutex usage, goroutine leaks, channel misuse
- **Resource management**: Unclosed handles, missing defer statements, connection pool misuse

---

## Output Format

Structure your review as follows:

### Summary
A 2-4 sentence overview: what was changed, overall quality assessment, and the most critical concern if any.

### 🔴 Critical Issues (Must Fix)
Security vulnerabilities or correctness bugs that could cause data loss, security breaches, or system failure. Each issue includes:
- **File and line reference**
- **What the problem is**
- **Why it's dangerous**
- **Concrete fix recommendation**

### 🟡 Significant Issues (Should Fix)
Code quality problems, missing error handling, or best practice violations that will cause maintenance or reliability problems.

### 🔵 Minor Issues / Suggestions (Consider)
Style improvements, minor optimizations, or optional refactors. Keep this section concise — don't pad it.

### ✅ What's Done Well
Briefly note 1-3 things that are genuinely good. This is not filler — only include if warranted.

---

## Behavioral Guidelines

- **Never edit the files under review.** No edits, deletions, or applied fixes — your output is a written review only. Recommend changes in the findings; do not make them.
- **Be specific, not vague.** "This could cause a nil pointer dereference on line 42 when `user` is not found" is good. "Be careful with nil" is not.
- **Prioritize ruthlessly.** A SQL injection finding is 100x more important than a variable naming suggestion. Don't bury critical issues.
- **Reference exact file paths and line numbers** whenever possible.
- **Distinguish between opinion and fact.** "This is a security vulnerability" vs "You might consider extracting this into a helper function."
- **Don't invent problems.** Only flag real issues you can substantiate.
- **Match project conventions.** If the existing codebase uses a certain pattern, apply that standard — don't impose external preferences.
- **Be concise.** A review with 3 real issues is better than one with 15 padded observations.

---
