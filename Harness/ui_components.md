# Reusable UI Component Index

## Goal

Help agents discover existing shared UI helpers before creating new components or modifiers.

## When To Load

- Adding reusable SwiftUI views, modifiers, wrappers, preview helpers, or UI utilities.
- Deciding whether a component belongs in `Tools` or a feature package.

## Applicability Evidence

- `Tools` exposes coordinator wrapper views and preview routing helpers.
- `String+Color.swift` provides a reusable `String.toHashColor()` extension used by `DetailView`.
- No live `Components` package exists, although older scaffolding may still imply one.

## Guidance

### component_index_entries

| Component or helper | Path | Use |
| --- | --- | --- |
| `CoordinatorStack` | `Packages/Tools/Sources/Coordinator/CoordinatorStack.swift` | Owns a `NavigationPath` and optionally wraps content in `NavigationStack`. |
| `CoordinatorView` | `Packages/Tools/Sources/Coordinator/CoordinatorView.swift` | Renders an initial route and attaches push/sheet/full-screen destinations. |
| `CoordinatorBase` | `Packages/Tools/Sources/Coordinator/CoordinatorBase.swift` | Internal wrapper for coordinator content and router state. |
| `PreviewRouter` | `Packages/Tools/Sources/Coordinator/PreviewRouter.swift` | Supplies in-memory router bindings for previews and tests. |
| `String.toHashColor()` | `Packages/Tools/Sources/General/String+Color.swift` | Creates deterministic colors from strings for placeholder/detail screens. |
| `WordGenerator.next()` | `Packages/Tools/Sources/General/WordGenerator.swift` | Generates sample titles for navigation demos. |

### view_modifier_index

- No custom `ViewModifier` types were found in live source.
- Reusable view behavior is currently expressed as wrapper views or extensions.

### component_accessibility_contracts

- No shared accessibility identifier or label convention is present in live components.
- Add accessibility labels and identifiers at the component level when creating reusable controls that tests or users depend on.

## Accuracy Contracts

### Do

- Put cross-package reusable SwiftUI infrastructure in `Tools` only when it is domain-neutral.
- Keep feature-specific UI in the owning feature package until reuse is real.
- Prefer extending the current helper surface over creating a missing `Components` package without confirmation.

### Do Not

- Do not reference `Packages/Components` as live source; it is absent.
- Do not duplicate router wrapper views inside feature packages.
- Do not add brand-specific controls to `Tools` unless `Tools` is explicitly made responsible for shared UI primitives.

### Expected Output Shape

- Shared helper: source file under `Packages/Tools/Sources/<Area>/`, public API only when used cross-package, and package tests for behavior.
- Feature-only component: keep next to the feature views and promote later if another package uses it.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `Packages/Tools/Sources/Coordinator/*.swift` | Reusable coordinator UI wrappers. |
| `Packages/Tools/Sources/General/String+Color.swift` | Reusable display helper. |

## Needs Project Confirmation

- Whether to restore a dedicated `Components` package for shared UI primitives.
- Accessibility identifier naming for reusable components.

## Verification

- Search `Packages/**/*.swift` for an existing helper before adding a new one.
- Build all packages that import the changed helper.
