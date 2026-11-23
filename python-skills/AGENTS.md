# Python project instructions

<!-- Fill in the project facts and replace command examples with the commands used by this repo. -->

## Project

- Purpose and layout: <what each main package owns and which way dependencies flow>
- Python support: follow `requires-python` in `pyproject.toml` and the supported versions in CI.
- Exceptions to the defaults: <intentional constraints, generated files, platform limits, known failures>

## Code and scope

- Before editing, check `git status --short` when applicable. Read the affected code, relevant callers, and tests. Search for an existing operation before adding one. Preserve unrelated user work and keep the diff focused.
- When the user points out a problem, identify the specific behavior they mean and fix it where it occurs. Preserve other agreed decisions. If an existing function fits and the issue is how its result is handled, keep using the function and fix the call site.
- Change the approach only when a concrete limitation makes a local fix insufficient. Before broadening the change, state that limitation and explain why the local fix cannot address it.
- Start with explicit data and plain functions. Keep I/O and orchestration at the edges, with rules that can run on data directly. Use a class when it owns cohesive state, enforces an invariant, or serves a real framework contract. Keep each operation easy to follow from its caller.
- Organize by feature or concept. Keep helpers near their users and give shared code a name that describes what it owns. Add a layer, wrapper, or extension point only when it solves a present problem. Prefer local duplication to a shared abstraction between unrelated rules.
- Preserve existing contracts, including errors, stored data, and side effects. Parse and validate external input at the boundary and reuse the validated representation. Add guards and fallbacks for a concrete invariant, trust boundary, or failure path.
- Make small, reversible assumptions explicit. Ask when ambiguity would materially change behavior or when the change requires approval. Diagnose a failing native approach before adding a workaround. Explain the limitation and tradeoff before implementing a workaround.
- Get explicit approval to add, remove, or upgrade a dependency unless the user already requested the change. Explain why existing tools are insufficient and check the package identity, maintenance, and Python compatibility. Use the project's dependency manager and include the matching lockfile change where applicable.
- Verify uncertain APIs against the installed version or official docs. Ship complete behavior through the normal entry point and remove placeholder results and debug code. Use synthetic fixtures and keep credentials and personal data out of code, fixtures, and logs.

## Verification

Use the repo's existing commands and CI configuration. When setting up a new project is in scope, prefer uv with a committed lockfile, Ruff, and pytest. Examples for a repo with that setup:

- Lint changed files with `uv run --locked ruff check <paths>` and check format with `uv run --locked ruff format --check <paths>`. To format, pass only the files in scope to `ruff format`.
- Run the configured type checker when type checking covers the changed code. Use the repo's actual command and arguments.
- Run the narrow pytest target with `uv run --locked pytest <path-or-node-id>`. Widen to affected packages or the full suite as risk warrants. Use `--locked` for a project with an up-to-date committed `uv.lock`.

For bug fixes, prefer a regression test that fails for the right reason before the fix. For behavior changes, cover the cases that could plausibly break. Keep assertions and checks intact unless the agreed contract or the task itself calls for changing them. A targeted suppression needs the specific rule and a reason. Distinguish failures introduced by the diff from established baseline failures or failures of unknown origin.

Review the final diff against the request. In the handoff, name the checks and results, explain meaningful assumptions or tradeoffs, and identify any relevant behavior left unverified.

## Task-specific guidance

For Python edits, read [.agents/skills/python-standards/SKILL.md](.agents/skills/python-standards/SKILL.md). For test design, regression reproduction, or test debugging, also use [python-testing](.agents/skills/python-testing/SKILL.md). Use [python-review](.agents/skills/python-review/SKILL.md) for a requested review or a dedicated review of a substantial diff.
