# Coding Standards Coverage

## Goal

Capture live Swift conventions that agents should follow when editing this repository.

## When To Load

- Any Swift code edit.
- Adding doc comments, changing naming, choosing framework APIs, or adding previews/tests.
- Investigating style, logging, lint, or concurrency choices.

## Swift And Framework Standards

- Package manifests use Swift tools 6.2.
- Xcode build settings use Swift 6.0 plus approachable concurrency and default main-actor isolation.
- Use SwiftUI for UI surfaces.
- Use Swift Observation for current ViewModels: `@MainActor @Observable final class ViewModel: VMProtocol`.
- Use `@State` to store Observation ViewModels in SwiftUI views.
- Use `@ObservationIgnored` for router bindings or other values that should not participate in Observation.
- Use `NavigationStack`, `NavigationPath`, and the shared `Router`/coordinator infrastructure for navigation.

## Naming Conventions

| Entity | Convention | Example |
| --- | --- | --- |
| Package/module | UpperCamelCase | `Entry`, `Detail`, `Tools` |
| Package metadata class | `<Module>Package` | `DetailPackage`, `MainPackage` |
| Package contract protocol | `<Module>Protocol` or domain name | `DetailProtocol`, `MainProtocol` |
| Route enum | `<Module>Route` | `DetailRoute`, `EntryRoute` |
| Coordinator | `<Module>Coordinator` | `DetailCoordinator`, `EntryCoordinator` |
| Root stack | `<Module>Stack` | `EntryStack` |
| ViewModel file | `<View>+ViewModel.swift` | `DetailView+ViewModel.swift` |
| Tests | `<Subject>Tests` | `DetailViewModelTests` |

## Access Control

- Public: cross-package entrypoints, routes, coordinators, views, protocols, and utilities consumed by another package.
- Internal/default: feature-local types and helpers.
- Private/fileprivate: view-only helpers, route-builder functions, and implementation details.
- Keep public comments brief and factual.

## Comments And Docs

- Keep type doc comments one-line and useful.
- Add comments only for non-obvious constraints, invariants, or platform caveats.
- Do not add comments that reference a chat request, current task, or issue unless the user asks.

## Logging And Lint

- No live logging wrapper exists. Do not add `print` or a logging framework without project confirmation.
- No SwiftLint config exists. Treat compiler diagnostics and tests/builds as the current quality gate.

## Platform Availability

- Packages target iOS, macOS, tvOS, watchOS, and visionOS.
- Guard platform-specific SwiftUI APIs with `#if os(...)` when availability differs.
- Current examples: macOS uses `.sheet` for full-screen modal fallback, `.automatic` toolbar placement, and skips `StackNavigationViewStyle()`.

## Accuracy Contracts

### Do

- Match existing file organization and access control.
- Keep `#Preview` blocks when dependencies can be satisfied with `PreviewRouter`.
- Prefer live source over templates when style differs.
- Add tests when behavior changes.

### Do Not

- Do not introduce `ObservableObject`, `@Published`, or `@StateObject` for new ViewModels unless preserving an existing older type.
- Do not claim lint or logging infrastructure exists until config/source is added.
- Do not introduce global state or direct platform APIs when a shared package abstraction already exists.

## Verification

- Use editor diagnostics for touched files.
- Run the narrow package build/test or Xcode scheme build that owns the changed code.
