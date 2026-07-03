# QA And Testing Pattern Coverage

## Goal

Guide agents toward the current package and Xcode testing surfaces.

## When To Load

- Adding or changing tests.
- Changing ViewModel behavior, route handling, shared utilities, package manifests, or build validation.
- Investigating why `swift test` fails for iOS-only packages.

## Applicability Evidence

- `Packages/Detail/Tests/View/DetailViewTests.swift` and `Packages/Detail/Tests/ViewModel/DetailViewModelTests.swift` use XCTest.
- `Packages/Entry/Tests/TabStackViewModelTests.swift` uses XCTest.
- `Packages/Tools/Tests/ToolsTests.swift` uses Swift Testing.
- Xcode project declares `SPM-Modular-ProgrammingTests` and `SPM-Modular-ProgrammingUITests` targets.

## Guidance

### unit_test_patterns

- Match the package's existing test framework unless deliberately migrating it.
- Detail and Entry tests use XCTest with `@MainActor` on UI/ViewModel test classes.
- Tools currently has a Swift Testing smoke test; add behavior tests there for non-UI utility logic.
- Use `PreviewRouter` to construct router bindings in view and ViewModel tests.

### ui_test_patterns

- Xcode UI test targets exist, but no live UI test files or robot/page-object pattern were found.
- Do not invent a robot pattern without project confirmation.
- Add accessibility identifiers to reusable controls before relying on them in UI tests.

### test_plan_structure

- No standalone test plans were found.
- Use live tests and current user requirements as requirements evidence; no generated planning documents are present.

## Accuracy Contracts

### Do

- Add ViewModel tests when changing state transitions or action handling.
- Keep tests deterministic; avoid persisting shared state without cleanup.
- Use `@MainActor` for SwiftUI/ViewModel tests that construct main-actor types.
- Prefer Xcode scheme tests for iOS-only SwiftUI packages.

### Do Not

- Do not rely on plain `swift test` as proof of success for the current iOS-only package manifests on macOS.
- Do not add mocks or fixtures under `.agents/skills/...`; those belong to the optimiser skill's own tests, not the app.
- Do not add UI tests that depend on labels without stable accessibility identifiers when labels may change.

### Expected Output Shape

- ViewModel behavior change: test initial state and affected `handle(action:)` transition.
- Route/coordinator change: test construction where possible and manually verify navigation if executable UI tests are absent.
- Utility change: add focused package tests in `Packages/Tools/Tests`.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `Packages/Detail/Tests/` | XCTest view and ViewModel patterns. |
| `Packages/Entry/Tests/` | XCTest ViewModel pattern. |
| `Packages/Tools/Tests/ToolsTests.swift` | Swift Testing presence. |
| `SPM-Modular-Programming.xcodeproj/project.pbxproj` | App unit/UI test target presence. |

## Needs Project Confirmation

- Whether to standardise on XCTest or Swift Testing across packages.
- Preferred iOS simulator destination for scheme tests.
- Whether UI tests should use a page-object or robot pattern.

## Verification

- Run the narrow owning scheme when available, such as `EntryUnitTests` or `DetailUnitTests`.
- Use editor diagnostics when an executable iOS test destination is unavailable.
