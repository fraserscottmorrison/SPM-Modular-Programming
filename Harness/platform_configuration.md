# Platform Configuration And Build Surface

## Goal

Document the build, package, Xcode, template, and resource surfaces agents must touch deliberately.

## When To Load

- Editing `Package.swift`, Xcode project settings, deployment targets, schemes, resources, templates, or build/test commands.
- Diagnosing package build failures caused by platform availability.

## Applicability Evidence

- `xcodebuild -list -project SPM-Modular-Programming.xcodeproj` reports schemes: `SPM-Modular-Programming`, `Entry`, `EntryUnitTests`, `Detail`, `DetailUnitTests`.
- Package manifests use Swift tools 6.2 and `.iOS(.v26)`.
- Xcode project uses iOS deployment targets 26.0 and 26.2 across app/test settings.
- SwiftPM package tests run on macOS by default and currently hit SwiftUI/Combine availability errors because the packages are iOS-only.

## Guidance

### build_commands_and_entrypoints

- Discover schemes with `xcodebuild -list -project SPM-Modular-Programming.xcodeproj`.
- Prefer Xcode scheme builds for iOS-specific packages instead of plain `swift test` on macOS.
- App entrypoint is `App/ModularProgrammingApp.swift`; it imports `Entry` and launches `EntryStack()`.

Known schemes:

| Scheme | Use |
| --- | --- |
| `SPM-Modular-Programming` | App build/run surface. |
| `Entry` | Entry package build surface. |
| `EntryUnitTests` | Entry package tests. |
| `Detail` | Detail package build surface. |
| `DetailUnitTests` | Detail package tests. |

### environment_configuration

- No `.xcconfig`, environment file, or secrets configuration was found.
- Do not add secrets or tokens to project files, package manifests, docs, or generated harness output.

### package_and_resource_surface

- Package resources are processed through `resources: [.process("Resources")]` where present.
- `Entry` currently has no resource processing entry in `Package.swift`; check before referencing `Bundle.module` resources there.
- `Tools` target path is `Sources` and has resource directories but no processed resources in its manifest.

### xcode_templates

- Templates under `Xcode Templates/` are aligned with the current live module shape.
- Module templates depend on `Tools` only and use `getCoordinatorView` from live `Tools`.
- View templates use `@StateObject`, `ObservableObject`, `@Published`, and `Binding<Router<...>>` to match `Entry` and `Detail`.
- Template output should still be compared against the closest live package for feature-specific route parameters, resources, and access control.

## Accuracy Contracts

### Do

- Keep package platform declarations aligned when adding packages.
- Use Xcode scheme validation for iOS-only SwiftUI package changes.
- Update package `resources` entries before referencing bundled assets.
- Verify templates against live source before generating files from them.

### Do Not

- Do not use plain `swift test` as the only validation for iOS-only packages on macOS.
- Do not add package dependencies that are only present in stale templates.
- Do not edit generated Xcode user data unless the task explicitly requires it.

### Expected Output Shape

- Package dependency change: update `Package.swift`, import only from allowed dependency direction, and validate with the owning Xcode scheme.
- Template update: align placeholder files with live route, ViewModel, and coordinator APIs.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `xcodebuild -list -project SPM-Modular-Programming.xcodeproj` | Schemes and targets. |
| `Packages/*/Package.swift` | Swift tools, platforms, resources, dependencies. |
| `SPM-Modular-Programming.xcodeproj/project.pbxproj` | Deployment targets and app package linkage. |
| `Xcode Templates/` | Current module and View/ViewModel scaffold shape. |

## Needs Project Confirmation

- Preferred simulator destination for app and scheme test validation.
- Preferred policy for keeping templates and live package examples in sync after module pattern changes.

## Verification

- `xcodebuild -list -project SPM-Modular-Programming.xcodeproj`
- Use a destination-specific `xcodebuild test` command once the preferred simulator is confirmed.
