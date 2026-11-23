---
name: rust-testing
description: Design or debug Rust tests with the project's existing harness. Use for regression reproduction, coverage of changed behavior, doctests, fixtures, and test doubles. Use rust-standards for any accompanying production code changes.
---

# Rust testing

Follow `AGENTS.md`. Use the repo's existing runner and helpers.

- For a bug fix, reproduce through the narrowest meaningful entry point. When feasible, show the regression test failing on the old behavior and passing with the fix. Confirm that the failure is the reported bug. If the environment prevents reproduction, state the gap.
- Test observable results, error variants, and relevant side effects. Prefer one behavior per test with as many assertions as it needs. Use table-driven cases for meaningful variants. Assert panic behavior or error wording only when the contract includes it.
- Keep unit tests close to the module. Use integration tests for behavior exposed to consumers. Put shared integration helpers under a submodule such as `tests/common/mod.rs` to avoid a standalone Cargo test target. Keep public examples as doctests when they benefit from execution.
- Use real data and the project's existing temp-directory helpers. Use a small fake at a costly, nondeterministic, or external boundary. Keep the behavior under test real. Use property tests, snapshots, or fuzzing where they fit the behavior and the tooling already exists.
- Keep tests isolated. Control time or randomness where relevant, synchronize on events, and avoid process-global changes. For environment-driven behavior, prefer explicit inputs or a subprocess with its own environment. Process-wide environment mutation requires stronger guarantees than serial execution of tests.
- For async tests, use the project's runtime setup. Await completion, bound potentially hanging waits, and verify cleanup where cancellation or shutdown changes. For Tokio timer tests, use the existing paused-time support when applicable.
- Run the narrow Cargo filter and check the test count. Use the repo's supported feature and target combinations for wider checks. Run relevant doctests separately if the chosen target or runner skips them. Use coverage to locate missing behavior, then decide whether that behavior warrants a test.
