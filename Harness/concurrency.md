# Concurrency

## When To Load

- Swift actor, `@MainActor`, `ObservableObject`, `@Published`, async action, or Sendable work.

## Guidance

Live concurrency guidance is split by owner:

- ViewModel and main-actor state patterns: [Harness/intra_module_architecture.md](intra_module_architecture.md)
- Framework and Swift-version preferences: [Harness/coding_standards.md](coding_standards.md)
- Package boundary decisions for pure/shared code: [Harness/inter_module_architecture.md](inter_module_architecture.md)

Do not add generic Swift concurrency rules here unless they are backed by live source evidence.
