# Inter-Module Architecture And Dependency Graph

## Goal

Help agents decide where code belongs and which package dependencies are allowed.

## When To Load

- Adding, removing, renaming, or splitting a package.
- Editing a `Package.swift` dependency list.
- Moving code between app, feature packages, and shared utilities.
- Using or updating Xcode module templates.

## Applicability Evidence

- `App/ModularProgrammingApp.swift` imports `Entry` and launches `EntryStack()`.
- `Packages/Entry/Package.swift` depends on `Detail` and `Tools`.
- `Packages/Detail/Package.swift` depends on `Tools`.
- `Packages/Tools/Package.swift` declares no package dependencies.
- `SPM-Modular-Programming.xcodeproj/project.pbxproj` links the app target to the `Entry` package product.

## Guidance

### module_inventory

| Module | Path | Type | Owns |
| --- | --- | --- | --- |
| App target | `App/` | app shell | `@main` SwiftUI entrypoint and app asset catalogue. |
| `Entry` | `Packages/Entry` | feature/root UI package | Top-level `EntryStack`, tabs, `EntryCoordinator`, `EntryRoute`, and `TabStack`. |
| `Detail` | `Packages/Detail` | feature UI package | Detail route, coordinator, package metadata, `DetailView`, and nested ViewModel. |
| `Tools` | `Packages/Tools` | shared infrastructure package | Router, route protocols, coordinator wrappers, ViewModel protocols, preview router, and small utilities. |

### dependency_rules

Allowed live dependency direction:

```text
App -> Entry -> Detail -> Tools
             -> Tools
```

- Keep `Tools` independent of feature packages.
- Feature packages may depend on `Tools` for routing and ViewModel contracts.
- `Entry` may depend on feature packages it hosts in tabs or root flows.
- Do not make `Detail` depend on `Entry`; route ownership stays outward from root to leaf.

### module_creation_guidance

- Create a new package only when the feature has its own route surface, resources, tests, or ownership boundary.
- For a small screen inside an existing package, add files under that package instead of creating a sibling package.
- Start from `Xcode Templates/Module.xctemplate` for new modules, then compare with live `Packages/Detail` or `Packages/Entry` for feature-specific wiring.
- After adding a package, update its `Package.swift`, the consuming package dependency list, and the Xcode project package reference if the app target must link it.

### app_session_state_ownership

- App-level state is currently minimal: `ModularProgrammingApp` only launches `EntryStack()`.
- Navigation state lives in `Router` instances and `NavigationPath` bindings.
- Tab navigation paths live in `TabStack.ViewModel.tabPaths`.
- Feature state lives in nested ViewModels (`DetailView.ViewModel`, `TabStack.ViewModel`).
- Needs project confirmation: no global session store, DI container, or app-wide state service is present in live source.

## Accuracy Contracts

### Do

- Keep dependencies flowing toward `Tools` and away from app-specific UI roots.
- Add shared route or ViewModel contracts to `Tools` only when at least two packages need them.
- Check live package manifests before following templates.

### Do Not

- Do not add `Entry` as a dependency of `Detail` or `Tools`.
- Do not assume deleted feature or `Components` packages exist; they are absent from live `Packages/`.
- Do not add a new external dependency without updating package manifests and documenting why it belongs at that layer.

### Expected Output Shape

- New feature package: `Packages/<Name>/Package.swift`, `Sources/Main/<Name>Package.swift`, `<Name>Route.swift`, `<Name>Coordinator.swift`, views, resources if needed, and tests.
- New shared utility: add to `Packages/Tools/Sources/<Area>/` with tests when behavior is non-trivial.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `AGENTS.md` | Original package-boundary intent, updated to live module list. |
| `Packages/*/Package.swift` | Dependency direction and platform declarations. |
| `SPM-Modular-Programming.xcodeproj/project.pbxproj` | App target package linkage. |

## Needs Project Confirmation

- Whether deleted feature and `Components` packages are intentionally deleted or should be regenerated.
- Whether deleted feature and `Components` references in older planning docs should be ignored or implemented in a future feature stream.

## Verification

- `xcodebuild -list -project SPM-Modular-Programming.xcodeproj`
- Inspect `Packages/*/Package.swift` dependency lists for cycles before building.
