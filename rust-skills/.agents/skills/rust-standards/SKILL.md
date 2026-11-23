---
name: rust-standards
description: Implement or refactor Rust production code, including API design and Cargo changes that affect code. Prefer direct control flow and straightforward ownership. For test-only work or a dedicated review, use rust-testing or rust-review respectively.
---

# Rust standards

Read the applicable `AGENTS.md`. Use the repo's Rust edition, minimum supported Rust version (MSRV), feature matrix, and lint configuration. Use rustfmt for formatting, with its defaults when the repo has no configuration. Treat the design preferences below as defaults and preserve existing contracts.

## Data, modules, and ownership

- Start with inputs, outputs, and who owns mutation. Put domain rules in code that takes data and returns data when practical. For example, a CLI can read a file, call `summarize(&rows)`, then write the result. Use an inherent method when the operation belongs to its type or protects its state.
- Use named fields for data whose meaning would be lost in tuple positions. Prefer enums when a flag and optional fields permit invalid combinations. Use a newtype when it prevents a real mix-up or protects an invariant. Keep fields private when callers must use a validating constructor or a controlled mutation path.
- Start with one owner. Borrow data for observation, pass `&mut` for exclusive updates, and take ownership when the callee stores or consumes it. For borrowed inputs, prefer `&str`, `&[T]`, and `&Path` when you only need the data.
- If borrowing gets hard to follow, first try shorter borrows, smaller inputs, or a clearer owner. A deliberate small clone can simplify ownership. Use `Rc`, `Arc`, and locks when shared ownership or mutation is part of the design. Make copying large data or synchronizing on hot paths a deliberate decision.
- Keep internal items private where possible. Widen visibility only to the necessary scope. Group code by concept and give a public item an intentional import path. Use explicit imports and qualify calls such as `fs::read` when the module clarifies where the behavior comes from.
- Start with concrete signatures. Use a trait or generic when a caller needs the abstraction, including a real boundary with one production implementation. Implement standard traits when their contract fits, such as `FromStr` for parsing. Prefer a constructor or options struct until a builder makes construction meaningfully easier to read or use.

## Errors and compatibility

- Use `Option` for expected absence and `Result` for a failure the caller may need to see or handle. Use `?` and keep the error source when adding context. Reuse an existing error type when its contract fits. Prefer typed library errors where callers need to distinguish causes. At a binary boundary, use the project's existing application error strategy.
- Reserve panics for bugs and violated invariants. An `expect` in production needs a real invariant and a message that identifies it. Return errors for malformed input and ordinary I/O failures. Log errors where they are handled and redact sensitive values, including in `Debug`.
- Preserve atomic, fail-fast, or partial-success behavior for batch work. An atomic operation needs rollback or equivalent guarantees. For partial success, make per-item outcomes visible. Consider retries after partial progress.
- Use checked conversions for values that may be out of range, and make the intended overflow behavior explicit when it matters. Keep external formats stable. Use `Path` and `OsStr` for platform paths and arguments where UTF-8 is not guaranteed.
- Check public changes from a downstream caller's perspective, including added enum variants, new required fields, feature defaults, and MSRV. Document guarantees, failure modes, and examples where they help users. Treat dependency types in public signatures as part of the API.
- Keep features additive where possible. For an existing exception, test the combinations the project supports. Check language and stdlib features against the MSRV. Check dependency compatibility against the resolved versions and the project's CI policy.

## Safety and verification

- For approved `unsafe`, keep the code small and encapsulate it behind an API that enforces its invariants. A `// SAFETY:` comment states why the requirements hold at the use site. Public unsafe functions document caller obligations under `# Safety`. Use the project's targeted validation, such as Miri where supported, and identify what remains unverified.
- Follow the repo's lint policy. A targeted lint exception needs the specific lint and a reason. Preserve existing safety and verification checks. Profile before adding complexity for speed.

[Official Rust Style Guide](https://doc.rust-lang.org/style-guide/) for formatting and style editions. [Google Rust Style Guide](https://google.github.io/styleguide/rustguide.html) for selected ownership, API, and error conventions. [Rust API Guidelines](https://rust-lang.github.io/api-guidelines/) for public library APIs.
