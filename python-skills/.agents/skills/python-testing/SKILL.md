---
name: python-testing
description: Design or debug Python tests with the project's existing harness. Use for regression reproduction, coverage of changed behavior, fixtures, and test doubles. Use python-standards for any accompanying production code changes.
---

# Python testing

Follow `AGENTS.md`. Use the repo's existing runner and helpers. The examples here assume pytest where configured.

- For a bug fix, reproduce through the narrowest meaningful entry point. When feasible, show the regression test failing on the old behavior and passing with the fix. Confirm the initial failure comes from the bug. If the environment prevents reproduction, state the gap.
- Test the observable contract with inputs that distinguish correct from broken behavior. Check the returned value, error, or relevant side effect. Prefer one behavior per test with as many assertions as that behavior needs. Use parametrization for meaningful variants of the same behavior.
- Assert a specific exception with `pytest.raises`. Match wording only when a stable message is part of the contract. Use an independent expected result and keep the operation under test visible in the body.
- Start with real in-process values and `tmp_path` for filesystem behavior. Use an existing fixture or a small fake at an external, expensive, or nondeterministic boundary. Keep the behavior under test real. When mocking, patch where the code looks up the object and use a spec or autospec where the object supports it. Check that important fakes still match the real boundary.
- Keep tests isolated and deterministic. Control the clock or random seed where relevant. Synchronize on events or completion. Use the project's async test setup. Give external integration tests controlled endpoints, deadlines, and synthetic data.
- Keep setup local until several modules truly share it. A short local literal is fine. Use a fixture or factory when it makes the inputs that matter easier to see.
- Diagnose failures against the intended contract before changing assertions. Investigate flaky ordering or shared state. Keep the production path exercised by the test.
- Run the narrow target first, then the suite affected by the change. Report the actual scope and any important cases left unverified. Use coverage to locate missing behavior, then decide whether that behavior warrants a test.
