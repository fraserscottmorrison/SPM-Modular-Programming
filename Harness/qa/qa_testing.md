# QA And Testing Pattern Coverage

## Goal

Guide agents toward the current package and Xcode testing surfaces.

## When To Load

- Adding or changing tests.
- Changing ViewModel behavior, route handling, shared utilities, package manifests, or build validation.
- Investigating why a package or platform build fails.

## Live Test Surface

| Package or target | Current tests | Framework |
| --- | --- | --- |
| `FeaturePackages/Detail` | View construction and ViewModel state tests | XCTest for view construction; Swift Testing for ViewModel tests. |
| `FeaturePackages/Entry` | `TabStack.ViewModel` tests | Swift Testing. |
| `SharedPackages/Tools` | Smoke test | Swift Testing. |
| Xcode app project | `FuturamaInvadersNewTests`, `FuturamaInvadersNewUITests` targets | Present in project; no strong live pattern in source. |

## Unit Test Patterns

- Match the package's existing test framework for nearby tests unless deliberately migrating that package.
- Use `@MainActor` for tests that construct SwiftUI views, routers, or ViewModels.
- Use `PreviewRouter` to construct router bindings in view and ViewModel tests.
- Test initial ViewModel state and affected `handle(action:)` transitions when behavior changes.
- Add behavior tests in `SharedPackages/Tools/Tests` for non-trivial shared utility or router logic.

## UI Test Patterns

- Xcode UI test targets exist, but there is no established robot/page-object pattern.
- Add accessibility identifiers before writing UI tests that need stable selectors.
- Do not rely on labels that are likely to change unless the label text is the product contract.

## Build Validation

- Use `env -u IS_RELEASE` for local debug builds so mock trait targets remain enabled.
- `swift build` from package directories is useful for manifest and macOS-host package smoke checks.
- Use Xcode scheme builds for app targets and platform-specific SwiftUI availability.
- visionOS, tvOS, and watchOS validation requires the corresponding Xcode platform component.

## Accuracy Contracts

### Do

- Add ViewModel tests when changing state transitions or action handling.
- Keep tests deterministic and isolated.
- Clean up persistent state if a test introduces storage.
- Run the narrowest owning package or scheme validation after edits.

### Do Not

- Do not claim an uninstalled platform component is a source failure.
- Do not add mocks or fixtures outside the owning package's `Sources/Mocks` or test fixture area.
- Do not add UI tests without stable selectors for controls they need to find repeatedly.

## Expected Output Shape

- ViewModel behavior change: test initial state and affected `handle(action:)` transition.
- Route/coordinator change: test route construction where possible and validate app/package build.
- Utility change: focused tests in `SharedPackages/Tools/Tests`.
- Platform/config change: `xcodebuild -list` plus the affected app/package build command.

## Verification Commands

```sh
cd SharedPackages/Tools && env -u IS_RELEASE swift test
cd FeaturePackages/Detail && env -u IS_RELEASE swift test
cd FeaturePackages/Entry && env -u IS_RELEASE swift test
xcodebuild -list -project FuturamaInvadersNew.xcodeproj
```

Use app build commands from [Harness/platform_configuration.md](../platform_configuration.md) when app targets or Xcode settings change.
