# Concurrency

## When To Load

- Use this compatibility entrypoint for Swift actor, `@MainActor`, Swift Observation, async action, `Sendable`, or platform-availability work.

## Guidance

Live concurrency guidance is split by owner:

- ViewModel and main-actor state patterns: [Harness/intra_module_architecture.md](intra_module_architecture.md)
- Swift version, Observation, and framework preferences: [Harness/coding_standards.md](coding_standards.md)
- Package boundary decisions for pure/shared code: [Harness/inter_module_architecture.md](inter_module_architecture.md)
- Platform availability and build validation: [Harness/platform_configuration.md](platform_configuration.md)

Do not add generic Swift concurrency rules here unless they are backed by live source evidence.
