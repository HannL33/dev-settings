---
name: rust-async
description: Change or review Rust async behavior, including task lifetimes, cancellation, state shared across awaits, deadlines, retries, and shutdown. Use with rust-review for async reviews. General Rust implementation guidance is in rust-standards.
---

# Rust async

For implementation, also use `rust-standards`. Use the project's runtime and verify the semantics of its installed version. Keep a sequential operation synchronous when callers and workload permit.

- Keep blocking I/O and expensive CPU work off runtime worker threads. Bound blocking work when load can grow. In Tokio, an already running `spawn_blocking` closure keeps running after abort, so design its stopping condition separately when needed.
- Await related operations in the caller when possible. Spawn when work needs a separate task. Give spawned work an owner that observes completion, errors, and panics. Choose fail-fast, drain-all, or partial success according to the contract. Bound concurrent work and queue capacity where inputs can accumulate.
- Prefer short lock scopes and release synchronous guards before `.await`. Use an async lock across an await only when serialization across that operation is required. Review lock ordering, contention, and what happens if a task is cancelled while it owns the guard.
- When a pending future is dropped, its synchronous destructors run and the future is no longer polled. Async cleanup needs an explicit awaited path. In a `select!` loop, check the cancellation safety of each losing branch. For operations like Tokio's `write_all`, retain in-flight progress where necessary or make partial effects an explicit part of the protocol.
- Dropping a Tokio `JoinHandle` detaches its task. After a timeout, account for external side effects and for detached or already-running blocking work that can continue. Decide whether to signal, abort, join, or reconcile the outcome. For shutdown, stop accepting work, signal workers, and drain within the service's budget.
- Use deadlines that fit the operation and the caller's remaining budget. Retry only when the failure is eligible and repeating the operation is safe, for example with a stable idempotency key. Bound attempts and total time. Reuse the existing client policy when it fits.
- For public async traits, check MSRV, whether callers require `Send` futures, and whether dynamic dispatch is needed. Choose the simplest signature that meets those requirements and follow the project's trait strategy.

[Tokio select! and cancellation safety](https://docs.rs/tokio/latest/tokio/macro.select.html), [JoinHandle](https://docs.rs/tokio/latest/tokio/task/struct.JoinHandle.html), and [spawn_blocking](https://docs.rs/tokio/latest/tokio/task/fn.spawn_blocking.html).
