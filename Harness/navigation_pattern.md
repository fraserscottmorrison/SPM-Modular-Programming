# Navigation Pattern

## Goal

Keep route-based navigation consistent across coordinators, tabs, pushes, and modal presentations.

## When To Load

- Adding route enum cases, coordinators, tab flows, sheets, full-screen covers, or nested `NavigationStack` flows.
- Changing `Router`, `CoordinatorStack`, `CoordinatorBase`, `CoordinatorView`, or `PreviewRouter`.

## Live Navigation Surface

- `SharedPackages/Tools/Sources/Main/Coordinator/Router.swift` defines `PresentationStyle`, `RouterProtocol`, `Router`, and `Route`.
- `CoordinatorView` wires `navigationDestination`, `.sheet`, and full-screen presentations from router state.
- `CoordinatorView` passes `Binding<Router<R>>` into route builders so nested modal routes use the correct router.
- `EntryStack` starts `CoordinatorStack(withNavigationStack: false)` and hosts `EntryCoordinator`.
- `EntryCoordinator` owns a `Router<EntryRoute>` and maps `.tabStack` to `TabStack`.
- `TabStack` owns independent tab `NavigationPath` values and embeds `DetailCoordinator` for each tab.
- `DetailCoordinator` owns a `Router<DetailRoute>` and maps `.initialRoute(Int)` to `DetailView`.

## Presentation Styles

| Style | Router state | Use |
| --- | --- | --- |
| `.push` | appends to `NavigationPath` | In-stack navigation. |
| `.formSheet` | `router.formSheet` | Modal flow wrapped in a fresh `CoordinatorStack`, allowing pushes inside the sheet. |
| `.semiFormSheet` | `router.semiFormSheet` | Sheet content rendered directly from the current route builder. |
| `.fullScreenCover` | `router.fullScreenCover` | Full-screen modal flow on platforms that support it; macOS falls back to `.sheet`. |

## Coordinator Rules

- Each module exposes route cases through its route enum and view construction through its coordinator.
- Coordinator route builders should take `(Route, Binding<Router<Route>>) -> View`.
- Parent/root modules decide when to embed child modules. `Entry` embeds `DetailCoordinator`; `Detail` does not know about `Entry`.
- Pass route parameters through enum associated values.
- Keep route enums `Route` conforming, hashable, and stable enough for `NavigationPath`.

## Modal Rules

- Use `.formSheet` when a presented flow needs its own nested navigation stack.
- Use `.semiFormSheet` for a single-route sheet that should not create a nested stack.
- When adding a new modal presentation style, update `PresentationStyle`, `Router`, `CoordinatorView`, previews/tests, and any templates together.
- Do not share the root router with a presented coordinator flow unless the desired behavior is explicitly root-level navigation.

## Tab Rules

- `TabStack.ViewModel.Tab` owns tab cases and display raw values.
- `TabStack.ViewModel.tabPaths` owns one `NavigationPath` per tab.
- Preserve tab paths while switching tabs.
- Reset paths only through explicit behavior, not as a side effect of selection changes.
- `NavigationSplitView` is used for regular-width split layouts; tab bar behavior is controlled by `TabStack.iPadTabBarEnabled`.

## Platform Rules

- `CoordinatorView` uses `.sheet` instead of `.fullScreenCover` on macOS.
- `DetailView` uses `.automatic` toolbar placement on macOS and `.topBarTrailing` elsewhere.
- `TabStack` avoids `StackNavigationViewStyle()` on macOS.
- Check platform availability before adding SwiftUI navigation APIs because packages target iOS, macOS, tvOS, watchOS, and visionOS.

## Accuracy Contracts

### Do

- Update route enum, coordinator switch, and tests/previews together.
- Use `PreviewRouter` for previews and tests that need router bindings.
- Keep child modules independent of parent route and tab selection decisions.

### Do Not

- Do not add raw `NavigationLink` flows that bypass a package coordinator when route ownership matters.
- Do not make child modules own parent tab state.
- Do not assume deep links exist; there is no live URL/deep-link route parser.

## Expected Output Shape

- New route: enum case, coordinator switch branch, call sites, preview/test coverage for construction or ViewModel action behavior.
- New modal flow with internal pushes: use `.formSheet` and ensure the presented content receives the modal router binding.
- Router behavior change: focused tests or executable preview/build validation plus app build if public API changes.

## Verification

- Build the affected package or app target.
- For each new route, confirm the coordinator switch handles it and previews/tests can construct required router bindings.
