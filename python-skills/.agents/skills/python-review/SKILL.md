---
name: python-review
description: Review a Python diff, branch, pull request, or named files for actionable defects and regressions. Use for an explicit review or a dedicated review of a substantial change.
---

# Python review

## Review the change

- Identify the comparison base or requested files. For working-tree reviews include applicable staged, unstaged, and new files. Read the requirements, callers, and tests before deciding that a behavior is wrong.
- Use the relevant checks from `AGENTS.md`. Trace or reproduce suspected issues with a concrete input and execution path. When a check fails, establish whether the diff caused it when feasible. Record any execution limits.
- Look for changed return values, exceptions, or stored formats. Check what happens on empty or invalid input, duplicate work, partial failure, retry, and concurrent access where those scenarios apply.
- Follow data through the boundary, mutation, and effects. Check for masked errors, resource leaks, unsafe input handling, and a dependency or type contract that the implementation assumes incorrectly.
- Check that tests exercise the changed behavior through a real entry point. Look for assertions that mirror the implementation, fakes that replace the behavior, and checks weakened to get green.
- Flag added indirection, duplicated rules, or scattered ownership when they create a concrete maintenance cost. Explain the cost with the call path or change that becomes harder.

## Report

Lead with actionable findings, most severe first. Give a file and line, the trigger and consequence, and a focused fix when it helps. Mark a finding as suspected if its trigger depends on an unverified assumption. Separate unrelated baseline failures. If there are no findings, say so and identify material limits in coverage or execution.
