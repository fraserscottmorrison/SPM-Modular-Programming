# Coding Standards Coverage

## Goal

Capture the live Swift coding conventions that agents should follow when editing this repository.

## When To Load

- Any Swift code edit.
- Adding doc comments, changing naming, choosing framework APIs, or adding previews/tests.
- Investigating lint, logging, or concurrency style.

## Applicability Evidence

- Package manifests use `// swift-tools-version:6.2` and `.iOS(.v26)`.
- Xcode project uses Swift 6.0 settings with approachable concurrency flags and main-actor default isolation.
- Live ViewModels are `@MainActor` classes and SwiftUI views rely on main-thread state.
- No SwiftLint config or script was found.

## Guidance

### naming_conventions

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

### framework_preferences

- Use SwiftUI for UI surfaces in live packages.
- Use Swift concurrency and `@MainActor` for UI/ViewModel code.
- Use `ObservableObject` and `@Published` for current live ViewModels unless the project confirms a move to `@Observable`.
- Use `NavigationStack`, `NavigationPath`, and the shared `Router` for navigation.
- Use XCTest for current `Entry` and `Detail` tests; `Tools` currently has a Swift Testing smoke test.

### comments_and_docs

- Keep type doc comments brief and factual.
- Add explanatory comments only for non-obvious constraints or invariants.
- Do not add comments that reference the current task or issue number.

### logging_approach

- No live logging wrapper or logger implementation was found.
- Do not add `print` or a new logging framework without project confirmation.

### lint_rules

- No lint configuration was found.
- Treat compiler diagnostics and tests as the current quality gate.

## Accuracy Contracts

### Do

- Match existing access-control style: public API for cross-package entrypoints, internal/default for feature internals, private for view-only helpers.
- Keep `#Preview` blocks in SwiftUI view files when dependencies can be satisfied.
- Prefer live source over stale templates when style differs.

### Do Not

- Do not claim SwiftLint rules exist until a config or script is added.
- Do not use deleted or absent logging utilities from stale harness docs.
- Do not introduce global state or direct platform APIs when a shared package abstraction already exists.

### Expected Output Shape

- Swift code changes should be minimal, compile in the owning package, and include tests when behavior changes.
- Public cross-package types should have one-line `///` comments.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `Packages/*/Package.swift` | Swift tools and platform versions. |
| `SPM-Modular-Programming.xcodeproj/project.pbxproj` | Swift version and concurrency build settings. |
| Live package sources | Naming, previews, access control, ViewModel style. |

## Needs Project Confirmation

- Whether a lint tool is intended.
- Whether a logging utility should be restored.
- Whether new ViewModels should migrate to `@Observable`.

## Verification

- Use editor diagnostics for touched files.
- Run the narrow package or Xcode scheme test that owns the changed code when available.
