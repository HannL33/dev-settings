---
name: python-standards
description: Implement or refactor Python production code, including API and data-model changes. Prefer explicit data, direct functions, and readable modules. For test-only work or a dedicated review, use python-testing or python-review respectively.
---

# Python standards

Read the applicable `AGENTS.md` and inspect the repo's existing tools, layout, and minimum supported Python version. Treat the design preferences below as defaults. Preserve caller contracts and local conventions when they matter to the change.

## Data and behavior

- Start from the inputs, outputs, and who owns mutation. Pass data into transformations and return the result. Keep network, filesystem, clocks, and randomness in the code that coordinates the work when that makes the rules easier to test. A CLI can parse a file, call `summarize(rows)`, then write the result without introducing a service class.
- Reuse the representation callers already understand. Use a dataclass for a stable named record, `TypedDict` when a known mapping shape needs to stay a dict, and a plain dict for dynamic keys or small local data. Type hints alone do not validate incoming data.
- Use `Enum` or `Literal` for a meaningful closed set. Use distinct states when a flag and optional fields would allow invalid combinations. A short-lived tuple is fine when the meaning is clear from local unpacking.
- Give classes cohesive state or an invariant to maintain. Prefer a function for stateless behavior. Add a `Protocol` where a structural interface serves a concrete caller need. Keep constructors and imports free of surprising I/O or global state changes.
- Keep the main path visible. Extract a function when it names a domain operation, isolates meaningful effects, or safely reuses the same rule. Use an explicit loop when comprehension, iterator, or decorator machinery obscures branches or effects. Local mutation is fine when it makes the work clearer and the mutated object is owned locally.
- Keep import direction consistent with the repo. Put an operation next to its data or primary caller. Avoid a growing `utils.py` and packages named only for an implementation pattern.

## Types and compatibility

- Annotate new function signatures and changed interfaces. Match the project's type checker and annotation practice, and keep unrelated typing changes out of the diff.
- Narrow uncertain values at boundaries. Prefer `object` with a real check to `Any` that spreads into business logic. Use `cast` only for a type the program already establishes. Validate uncertain values at runtime.
- Use language and stdlib features supported by the repo's minimum Python version. Check runtime annotation consumers such as validators separately when relevant. Follow the configured formatter and lint rules.
- Use `field(default_factory=...)` for per-instance mutable defaults. In a function, use `None` if it can mean omitted, or a dedicated sentinel if explicit `None` has its own meaning.

## Errors and effects

- Catch exceptions where you can recover, translate to the caller's contract, or report a failure at the boundary. Catch the expected exception around the smallest relevant operation. When translating, use `raise DomainError(...) from err` and preserve useful context. Log once where the error is handled.
- Keep absence, empty data, and failure distinguishable where callers act differently. Use an explicit outcome when the caller consumes it. Expected cases may map to a documented default, such as optional config missing on `FileNotFoundError`.
- For multi-item work, preserve whether callers expect atomicity, fail-fast with possible earlier effects, or partial success with per-item outcomes. If the operation is atomic, use a transaction or an equivalent mechanism. Check what happens if the caller retries after partial progress.
- Manage resources with context managers. In async code use the project's runtime and structured task APIs where available. Move blocking I/O and expensive computation off the event loop. Preserve cancellation and clean up owned resources.
- Represent instants with timezone-aware datetimes. Keep date-only and local calendar values explicit when that is what the domain needs.
- Use parameterized SQL and argument lists for subprocesses. For untrusted paths, enforce the intended directory boundary when the contract requires it, including symlink handling. Use a safe parser for untrusted data and keep executable formats such as pickle within trusted boundaries.

## Review your edit

Follow the verification in `AGENTS.md`. Explain contract changes and meaningful design decisions. Comments and docstrings should capture invariants, surprising behavior, and rationale that a reader cannot infer from the code.
