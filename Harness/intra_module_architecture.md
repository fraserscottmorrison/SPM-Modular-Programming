# Intra-Module Architecture

## Goal

Document the screen, ViewModel, route, and state patterns used inside live Swift packages.

## When To Load

- Adding or changing SwiftUI views, nested ViewModels, route enums, package entrypoints, or state/action enums.
- Updating Xcode view/module templates.
- Deciding where UI state or async action handling belongs.

## Applicability Evidence

- `DetailView` and `TabStack` are SwiftUI views with nested ViewModels in `+ViewModel.swift` files.
- ViewModels conform to `VMProtocol` through `ViewModelProtocol & StateProtocol` in `Tools`.
- `DetailView.ViewModel` and `TabStack.ViewModel` define nested `ViewState` and `ViewAction` enums.
- Current live ViewModels use `@MainActor final class`, `ObservableObject`, and `@Published` state.

## Guidance

### view_patterns_and_structure

- Place package screens under `Packages/<Package>/Sources/Main/Views/`.
- Keep SwiftUI layout in the view file and ViewModel logic in `<View>+ViewModel.swift`.
- Use `#Preview` for view files and `PreviewRouter` from `Tools` for router bindings.
- Views may own their ViewModel with `@StateObject` in current live code.

### view_model_patterns_and_structure

- Nest the ViewModel inside an extension on the view type.
- Use `@MainActor final class ViewModel: VMProtocol, ObservableObject` for the current live pattern.
- Expose `@Published var state` and route/tab state needed by the view.
- Define nested `ViewState: ViewStateProtocol` with at least `.idle` and `.loading`; add `.loaded` where the view uses it.
- Define nested `ViewAction` and implement `func handle(action:) async`.
- Use `action(_:)` from `ViewModelProtocol` to launch async handling on the main actor.

### state_management_pattern

- View rendering switches over `viewModel.state` where the view has loading or loaded branches.
- Keep navigation path arrays and selected tab state in the owning ViewModel (`TabStack.ViewModel`).
- Keep transient view-only state in the view (`@State private var refreshIds` in `TabStack`).

### dependency_injection_pattern

- Live package manifests do not declare `Factory`; however `Packages/Tools/Sources/Coordinator/.swift` imports `Factory` and references missing screen-history types.
- Treat DI through `Factory` as unconfirmed until package dependencies and missing types are restored.
- Prefer initializer injection and protocol boundaries for new code unless a confirmed DI container is added back.

### form_patterns_and_field_validation

- No live forms exist.
- `FormProtocol` in `Tools` provides a submit/process contract if a form ViewModel is introduced.

## Accuracy Contracts

### Do

- Keep ViewModel state and actions adjacent to the view in `+ViewModel.swift`.
- Keep reusable protocols in `Tools/Sources/Modules/`.
- Add tests for ViewModel initial state and actions when changing ViewModel behavior.

### Do Not

- Use the Xcode templates as the starting point for new screens, then compare with the closest live package for feature-specific state and route parameters.
- Do not introduce dedicated feature-package structure unless that package is restored in source.
- Do not invent form validation rules without a feature spec or live form evidence.

### Expected Output Shape

- New screen in an existing package: `Views/<Screen>.swift`, `Views/<Screen>+ViewModel.swift`, preview, ViewModel tests if behavior changes.
- New ViewModel state: update nested `ViewState`, update view switch, and add tests for transitions.

## Existing Harness Sources Used

| Source | Evidence Used |
| --- | --- |
| `Packages/Detail/Sources/Main/Views/DetailView.swift` | View ownership and preview pattern. |
| `Packages/Entry/Sources/Main/Views/TabStack+ViewModel.swift` | Tab state and nested ViewModel pattern. |
| `Packages/Tools/Sources/Modules/ViewModelProtocol.swift` | Action/state protocol contract. |
| `Xcode Templates/` | Current module and View/ViewModel scaffolds. |

## Needs Project Confirmation

- Whether the project should standardise on `ObservableObject` or Swift 6.2 `@Observable` for new ViewModels.
- Whether `Factory` DI is intended to be restored.

## Verification

- Run the package or scheme tests for the package touched.
- Confirm every changed view still has a preview when it can be instantiated with `PreviewRouter`.
