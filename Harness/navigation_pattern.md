# Navigation Pattern

## Goal

Keep route-based navigation consistent across coordinators, tabs, pushes, and modal presentations.

## When To Load

- Adding route enum cases, coordinators, tab flows, sheets, full-screen covers, or nested `NavigationStack` flows.
- Changing `Router`, `CoordinatorStack`, `CoordinatorView`, or `PreviewRouter`.

## Applicability Evidence

- `Tools/Sources/Coordinator/Router.swift` defines `PresentationStyle`, `RouterProtocol`, `Router`, and `Route`.
- `CoordinatorView` wires `navigationDestination`, `.sheet`, and `.fullScreenCover` from router state.
- `Entry/Views/TabStack.swift` creates independent `NavigationStack` paths per tab.
- `DetailCoordinator` maps `DetailRoute.initialRoute(String)` to `DetailView`.

## Guidance

### navigation_transition_types

Supported presentation styles are owned by `PresentationStyle`:

| Style | Router state | Use |
| --- | --- | --- |
| `.push` | appends to `NavigationPath` | In-stack navigation. |
| `.formSheet` | `router.formSheet` | Sheet presentation that wraps content in a new `CoordinatorStack`. |
| `.semiFormSheet` | `router.semiFormSheet` | Sheet presentation using the direct route view. |
| `.fullScreenCover` | `router.fullScreenCover` | Full-screen modal flow. |

### inter_module_navigation

- A module exposes route cases through its route enum and view construction through its coordinator.
- Parent/root modules own the decision to embed another module. `Entry` embeds `DetailCoordinator` in each tab.
- Pass route parameters through enum associated values, as `DetailRoute.initialRoute(String)` does.
- Do not navigate by constructing another module's private ViewModel directly.

### nested_modal_navigation

- `CoordinatorView.navigateToFormSheet` wraps form-sheet routes in a new `CoordinatorStack`, allowing pushes inside the sheet.
- Use `.formSheet` when a presented flow needs its own nested navigation path.
- Use `.semiFormSheet` when the sheet content is a single route view.

### tab_segment_navigation

- `TabStack.ViewModel.Tab` owns tab cases and display raw values.
- `TabStack.ViewModel.tabPaths` owns one `NavigationPath` per tab.
- Preserve each tab path while switching tabs; reset a path only through explicit root-pop behavior.

## Accuracy Contracts

### Do

- Add new presentation modes to `PresentationStyle` and `CoordinatorView` together.
- Keep route enum cases hashable and identifiable through `Route`.
- Use `PreviewRouter` for previews and tests that need router bindings.

### Do Not

- Do not add raw `NavigationLink` flows that bypass the package coordinator when route ownership matters.
- Do not make child modules own parent tab selection.
- Do not assume deep links exist; no live deep-link parser or URL route evidence was found.

### Expected Output Shape

- New route: add enum case, update coordinator switch, update call sites, add tests or previews that instantiate the route.
- New modal flow with internal pushes: use `.formSheet` so the flow receives a nested coordinator stack.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `Packages/Tools/Sources/Coordinator/Router.swift` | Presentation styles and route contract. |
| `Packages/Tools/Sources/Coordinator/CoordinatorView.swift` | Push, sheet, and full-screen wiring. |
| `Packages/Entry/Sources/Main/Views/TabStack.swift` | Tab navigation path ownership. |
| `Packages/Detail/Sources/Main/DetailCoordinator.swift` | Feature coordinator switch pattern. |

## Needs Project Confirmation

- Whether direct `viewModel.router.navigateTo(...)` calls inside views should be replaced by ViewModel actions or kept as the accepted live pattern.
- Whether parent callbacks or deep-link routing are planned.

## Verification

- Build the affected package or app scheme.
- For each new route, manually confirm the coordinator switch handles it and previews/tests can construct required router bindings.
