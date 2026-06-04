---
name: Test-first workflow for bug fixes
description: Always write a failing test that proves the bug exists before applying the fix
type: feedback
---

Always write a failing test that reproduces the bug BEFORE applying the fix.

**Why:** Proves the bug actually existed, documents the failure mode, and confirms the fix addresses the right thing. The test must fail on the buggy code and pass after the fix.

**How to apply:** For every bug fix: (1) write the test, (2) run it to confirm it fails, (3) apply the fix, (4) run again to confirm it passes. Never write the fix first. Only commit once all new tests pass — that is the "win" condition.
