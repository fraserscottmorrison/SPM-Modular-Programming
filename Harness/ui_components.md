# Reusable UI Component Index

## Goal

Help agents discover existing shared SwiftUI helpers before creating new components, wrappers, or modifiers.

## When To Load

- Adding reusable SwiftUI views, modifiers, wrappers, preview helpers, or UI utilities.
- Deciding whether code belongs in `SharedPackages/Tools` or a feature package.

## Live Shared Helpers

| Component or helper | Path | Use |
| --- | --- | --- |
| `CoordinatorStack` | `SharedPackages/Tools/Sources/Main/Coordinator/CoordinatorStack.swift` | Owns a `NavigationPath` and optionally wraps content in `NavigationStack`. |
| `CoordinatorView` | `SharedPackages/Tools/Sources/Main/Coordinator/CoordinatorView.swift` | Renders an initial route and attaches push/sheet/full-screen destinations. |
| `CoordinatorBase` | `SharedPackages/Tools/Sources/Main/Coordinator/CoordinatorBase.swift` | Observes router state while rendering coordinator content. |
| `PreviewRouter` | `SharedPackages/Tools/Sources/Main/Coordinator/PreviewRouter.swift` | Supplies in-memory router bindings for previews and tests. |
| `Router` and `Route` | `SharedPackages/Tools/Sources/Main/Coordinator/Router.swift` | Shared route-driven navigation state and route identity. |
| `String.toHashColor()` | `SharedPackages/Tools/Sources/Main/Foundation/String+Color.swift` | Creates deterministic colors from strings for placeholder/detail screens. |
| `ViewModelProtocol` / `FormProtocol` | `SharedPackages/Tools/Sources/Main/Modules/ViewModelProtocol.swift` | Shared action/state/form contracts for ViewModels. |

## Component Placement

- Put cross-package, domain-neutral infrastructure in `SharedPackages/Tools`.
- Keep feature-specific UI in the owning feature package until another package genuinely needs it.
- Add public access only for APIs consumed outside their defining package.
- There is no live `Components` package; do not create one without explicit project direction.

## Accessibility

- No shared accessibility identifier convention exists yet.
- Add accessibility labels/identifiers at the component level when creating reusable controls that tests or users depend on.
- UI tests should not rely on unstable visible labels unless labels are the product contract.

## Accuracy Contracts

### Do

- Search existing Swift helpers before adding new shared code.
- Extend `Tools` only when the helper is reusable and package-neutral.
- Add tests for non-trivial shared behavior.

### Do Not

- Do not duplicate router/coordinator wrappers inside feature packages.
- Do not add brand-specific controls to `Tools` unless `Tools` is explicitly made responsible for shared UI primitives.
- Do not reference stale helper names that are not present in live source.

## Verification

- Build all packages that import a changed shared helper.
- Run focused tests for utility behavior when available.
