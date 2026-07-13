# Inter-Module Architecture And Dependency Graph

## Goal

Help agents decide where code belongs, which package dependencies are allowed, and which app target should own platform-specific shell work.

## When To Load

- Adding, removing, renaming, or splitting a package.
- Editing a `Package.swift` dependency list, product, target, trait, or resource declaration.
- Moving code between the app shell, feature packages, and shared utilities.
- Linking local package products from Xcode app targets.
- Updating Xcode module templates.

## Live Inventory

| Module or target | Path | Type | Owns |
| --- | --- | --- | --- |
| `FuturamaInvadersNew` | `FuturamaInvadersNew.xcodeproj` + `App/` | iOS-family app target | iOS app product, launch storyboard, app assets, generated Info.plist keys. |
| `FuturamaInvadersNew-macOS` | `FuturamaInvadersNew.xcodeproj` + `App/` | native macOS app target | macOS app product using the shared SwiftUI entrypoint. |
| `FuturamaInvadersNew-visionOS` | `FuturamaInvadersNew.xcodeproj` + `App/` | native visionOS app target | visionOS app product using the shared SwiftUI entrypoint. |
| `Entry` | `FeaturePackages/Entry` | root feature package | `EntryStack`, `EntryCoordinator`, `EntryRoute`, `TabStack`, and root tab/split navigation. |
| `Detail` | `FeaturePackages/Detail` | feature package | `DetailRoute`, `DetailCoordinator`, `DetailPackage`, `DetailView`, details models, and detail service. |
| `Tools` | `SharedPackages/Tools` | shared infrastructure package | Router, route protocols, coordinator wrappers, preview router, ViewModel/form protocols, networking mocks, and small utilities. |

## Dependency Rules

Allowed live dependency direction:

```text
App targets -> Entry -> Detail -> Tools
                    \-> Tools
```

- `Tools` must remain independent of feature packages and app targets.
- Feature packages may depend on `Tools` for routing, ViewModel contracts, previews, networking scaffolding, and utilities.
- `Entry` may depend on child feature packages it hosts, such as `Detail`.
- `Detail` must not depend on `Entry`; route ownership flows from root to leaf.
- App targets should link only the root package product they need, currently `Entry`.
- Do not add external dependencies to a lower-level package just because one feature needs them; keep ownership local unless reuse is real.

## Package Shape

Current package manifests use Swift tools 6.2, `defaultLocalization: "en"`, package traits, and all Apple OS platform declarations:

```swift
.iOS(.v26)
.macOS(.v26)
.tvOS(.v26)
.watchOS(.v26)
.visionOS(.v26)
```

Each live package uses this target layering where applicable:

- `Sources/Mocks`: package-owned mock fixtures, enabled in debug through the `DEBUG` trait.
- `Sources/Concurrent`: service/model/concurrent-safe code and mock-conditioned dependencies.
- `Sources/Main`: SwiftUI, coordinators, routes, public package entrypoints, protocols, resources.
- `Tests`: package tests.

The debug trait is enabled by default unless `IS_RELEASE=true` is present in the environment:

```swift
let isDebug = ProcessInfo.processInfo.environment["IS_RELEASE"] != "true"
```

## Module Creation Guidance

- Create a new feature package only when it has its own route surface, resources, tests, or ownership boundary.
- For a small screen inside an existing feature, add it under that feature package rather than creating a sibling package.
- Start from `Xcode Templates/Module.xctemplate`, then compare with live `FeaturePackages/Detail` and `FeaturePackages/Entry` before committing generated code.
- For a new package consumed by the app, update the package manifest, the consuming package dependency list, and the Xcode project package/product reference.
- Keep template changes in sync with live Observation, router-binding, resource, and platform patterns.

## App State Ownership

- `App/ModularProgrammingApp.swift` is intentionally small and launches `EntryStack()`.
- Navigation state lives in `Router` instances and `NavigationPath` bindings.
- Tab navigation paths live in `TabStack.ViewModel.tabPaths`.
- Feature state lives in nested Swift Observation ViewModels.
- No global session store, DI container, app-wide state service, or persistence layer exists in live source.

## Accuracy Contracts

### Do

- Keep dependencies flowing toward `Tools` and away from app-specific roots.
- Add shared contracts to `Tools` only when at least two packages need them or the contract is genuinely package-neutral.
- Keep package platform declarations aligned across live packages and templates unless a package has a real platform-specific reason to differ.
- Check live manifests before following templates.

### Do Not

- Do not add `Entry` as a dependency of `Detail` or `Tools`.
- Do not invent a `Components` package; none exists in live source.
- Do not turn the iOS app target into Catalyst or Mac Designed for iPad when the task asks for native macOS.
- Do not add app resources to a package unless the package owns and references them.

## Expected Output Shape

- New feature package: `FeaturePackages/<Name>/Package.swift`, `Sources/Main/<Name>Package.swift`, `<Name>Route.swift`, `<Name>Coordinator.swift`, `Sources/Main/Views/`, resources if needed, and tests.
- New shared utility: file under `SharedPackages/Tools/Sources/Main/<Area>/` or `Sources/Concurrent/<Area>/` with public API only when used cross-package.
- New app target: separate native target in `FuturamaInvadersNew.xcodeproj`, shared scheme under `xcshareddata/xcschemes`, and no iOS launch storyboard in non-iOS resource phases.

## Verification

- `xcodebuild -list -project FuturamaInvadersNew.xcodeproj`
- `env -u IS_RELEASE swift build` inside the touched package.
- App target builds from [Harness/platform_configuration.md](platform_configuration.md) when package or app linkage changes.
