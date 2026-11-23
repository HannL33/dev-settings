# Rust project instructions

<!-- Fill in the project facts and replace command examples with the commands used by this repo. -->

## Project

- Purpose and layout: <what each main crate or module owns and which way dependencies flow>
- Rust support: follow each affected crate's effective `edition` and `rust-version` in Cargo manifests, the pinned toolchain where present, and the supported configurations in CI.
- Runtime and feature matrix: <existing runtime, supported feature sets, and target platforms>
- Exceptions to the defaults: <intentional constraints, generated files, known failures>

## Code and scope

- Before editing, check `git status --short` when applicable. Read the affected code, relevant callers, and tests. Search for an existing operation before adding one. Preserve unrelated user work and keep the diff focused.
- When the user points out a problem, identify the specific behavior they mean and fix it where it occurs. Preserve other agreed decisions. If an existing function fits and the issue is how its result is handled, keep using the function and fix the call site.
  For example, if the caller establishes that `offset(...)` returns `Some`, keep the call and use `expect` with a message that names the condition guaranteeing that the resulting coordinates are on the board. Keep handling `None` where it is a valid outcome.
- Change the approach only when a concrete limitation makes a local fix insufficient. Before broadening the change, state that limitation and explain why the local fix cannot address it.
- Start with structs, enums, and direct functions. Use inherent methods for behavior tied to a type. Keep I/O at the edges where practical. Prefer concrete types and straightforward ownership. Add traits, generic bounds, or shared state for a present need you can describe.
- Organize by feature or concept. Keep helpers near their users and use the narrowest useful visibility. Preserve existing contracts, including errors, stored data, feature behavior, and side effects.
- Validate external input at the boundary. Make small, reversible assumptions explicit. Ask when ambiguity would materially change behavior or when the change requires approval. Diagnose a failing native approach before adding a workaround. Explain the limitation and tradeoff before implementing a workaround.
- Get explicit approval to add, remove, or upgrade a dependency unless the user already requested the change. Explain why existing tools are insufficient and check its source, maintenance, features, license, and Rust compatibility. Use Cargo for lockfile changes.
- Get explicit approval before introducing or expanding `unsafe` unless the user already requested it. Document the safety invariant and why it holds at each use. Prefer safe APIs.
- Verify uncertain APIs against the resolved crate version or official docs. Ship complete behavior through the normal entry point and remove placeholder results and debug code. Use synthetic fixtures and keep credentials and personal data out of code, fixtures, and logs.

## Verification

Use the repo's commands and CI feature/target matrix. Examples from the workspace root:

- Format check: `cargo fmt --all -- --check`. Keep formatting writes in scope. For a leaf file, run `rustfmt --edition <crate-edition> <file>` if this matches the repo's formatter configuration. Honor a separate style edition when set. Check the resulting diff.
- Lint affected targets: `cargo clippy -p <package> --all-targets` with the relevant feature flags and the repo's warning policy.
- Narrow test: `cargo test -p <package> <name-fragment>`. Confirm that the intended test actually ran. With `-- --exact`, use the full test name, including its module path.
- Widen to the relevant workspace checks as risk warrants. With ordinary Cargo targets, `cargo test --workspace` includes library doctests by default. Run `cargo test --doc` separately when doctests need a dedicated check, for example when the normal runner is nextest.
- Use `--locked` on Cargo commands that resolve dependencies when the repo commits `Cargo.lock`. Use `--all-features` only for a supported combination or when CI explicitly checks it.

For bug fixes, prefer a regression test that fails for the right reason before the fix. For behavior changes, cover the cases that could plausibly break. Keep assertions and checks intact unless the agreed contract or the task itself calls for changing them. Distinguish failures introduced by the diff from established baseline failures or failures of unknown origin.

Review the final diff against the request. In the handoff, name the checks and results, explain meaningful assumptions or tradeoffs, and identify any relevant behavior left unverified.

## Task-specific guidance

For Rust edits, read [.agents/skills/rust-standards/SKILL.md](.agents/skills/rust-standards/SKILL.md). For tests or regression reproduction, also use [rust-testing](.agents/skills/rust-testing/SKILL.md). Use [rust-async](.agents/skills/rust-async/SKILL.md) for changes to async tasks, cancellation, or async shared state. Use [rust-review](.agents/skills/rust-review/SKILL.md) for a requested review or a dedicated review of a substantial diff.
