---
name: rust-review
description: Review a Rust diff, branch, pull request, or named files for actionable defects and regressions. Use for an explicit review or a dedicated review of a substantial change.
---

# Rust review

## Review the change

- Identify the comparison base or requested files. For working-tree reviews include applicable staged, unstaged, and new files. Read the requirements, callers, manifests, and tests before deciding that a behavior is wrong.
- Use the relevant checks from `AGENTS.md` and confirm they covered the intended targets and features. Trace or reproduce suspected issues with a concrete input and path. Establish whether check failures are caused by the diff when feasible.
- Check the behavior of recoverable failures, panic paths, numeric conversions, invalid input, and partial writes or retries where they apply. Trace resource ownership and cleanup on both the success and error paths.
- Review public API, persisted data, feature behavior, MSRV, and target compatibility from the caller's point of view. Look for check suppressions and unexpected lockfile changes.
- For concurrency changes, check task ownership, cancellation, locks, and unbounded work. For `unsafe` changes, trace each precondition and whether the safe API keeps it true for all callers.
- Flag extra clones, wrappers, generic layers, or shared state when they make a call path harder to maintain or create a concrete runtime cost. Check that tests exercise the changed behavior and that assertions and failure paths remain intact.

## Report

Lead with actionable findings, most severe first. Give a file and line, the trigger and consequence, and a focused fix when it helps. Mark a finding as suspected if its trigger depends on an unverified assumption. Separate unrelated baseline failures. If there are no findings, say so and identify material limits in coverage or execution.
