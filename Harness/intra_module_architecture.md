# Intra-Module Architecture

## Goal

Document the screen, ViewModel, route, state, resource, and service patterns used inside live Swift packages.

## When To Load

- Adding or changing SwiftUI views, nested ViewModels, route enums, package entrypoints, services, models, or state/action enums.
- Updating Xcode view/module templates.
- Deciding where UI state, async action handling, or feature-local helpers belong.

## Live Patterns

- Views live under `FeaturePackages/<Package>/Sources/Main/Views/`.
- ViewModel logic lives beside the view in `<View>+ViewModel.swift`.
- ViewModels are nested in an extension on the view type.
- Current ViewModels use Swift Observation: `@MainActor @Observable final class ViewModel: VMProtocol`.
- Views store ViewModels with `@State internal var viewModel: ViewModel`.
- Router bindings in ViewModels use `@ObservationIgnored @Binding var router: Router<Route>`.
- Feature services and models live under `Sources/Concurrent` when separated from SwiftUI.
- Package resources live under `Sources/Main/Resources` and must be declared in the owning target manifest.

## View Pattern

- Keep SwiftUI layout in the view file.
- Initialize the nested ViewModel in the view initializer with `State(initialValue:)`.
- Switch on `viewModel.state` for loading/loaded/empty rendering when the feature has lifecycle state.
- Trigger lifecycle work with `viewModel.action(.onAppear)` from `.onAppear`.
- Keep transient view-only state in the view when it does not belong in behavior tests.
- Keep `#Preview` blocks when dependencies can be satisfied with `PreviewRouter`.

## ViewModel Pattern

Use the live template shape for new ViewModels:

```swift
extension SomeView {
    @MainActor @Observable final class ViewModel: VMProtocol {
        @ObservationIgnored
        @Binding var router: Router<SomeRoute>
        var state: ViewState = .loading

        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded
        }

        enum ViewAction {
            case onAppear
        }

        func handle(action: ViewAction) async { }
    }
}
```

- Define nested `ViewState` with at least `.idle` and `.loading`; add associated values only when the view renders them.
- Define nested `ViewAction` for user and lifecycle events.
- Keep navigation decisions in actions when the navigation is user-driven.
- Use `action(_:)` from `ViewModelProtocol` to launch async handling on the main actor.

## State Ownership

- `TabStack.ViewModel` owns tab selection and one `NavigationPath` per tab.
- `DetailView.ViewModel` owns the current details loading state and uses `DetailService` for data.
- `Router` owns navigation presentation state; views should not duplicate router state locally.
- The app shell owns no durable state beyond launching the root stack.

## Dependency And DI Pattern

- There is no live DI container in package manifests.
- Prefer initializer injection and small protocol boundaries for new services.
- Do not add Factory, Resolver, environment singletons, or global stores unless the user explicitly asks for that architecture.
- Keep storage, networking, and service implementations in the owning package until reuse across packages is proven.

## Forms

- No live forms exist.
- `FormProtocol` in `SharedPackages/Tools/Sources/Main/Modules/ViewModelProtocol.swift` provides a submit/process contract if a form ViewModel is introduced.
- Do not invent validation rules without a feature requirement.

## Accuracy Contracts

### Do

- Use Swift Observation for new ViewModels unless the user asks for a migration back to `ObservableObject`.
- Keep ViewModel state and actions adjacent to the view in `+ViewModel.swift`.
- Add or update tests when changing ViewModel behavior.
- Keep public API only for cross-package entrypoints; prefer internal/default access for feature internals.

### Do Not

- Do not use `@StateObject`, `ObservableObject`, or `@Published` for new ViewModels unless you are preserving an existing older type.
- Do not construct another module's private ViewModel directly; use its coordinator or public view entrypoint.
- Do not add a feature package when a screen belongs inside an existing package.

## Expected Output Shape

- New screen in an existing package: `Views/<Screen>.swift`, `Views/<Screen>+ViewModel.swift`, preview, route/coordinator case if navigable, and ViewModel tests if behavior changes.
- New service/model: files under `Sources/Concurrent`, dependency from `Sources/Main` only when the UI layer consumes it, and tests where behavior is non-trivial.
- New ViewModel state: update nested `ViewState`, update the view switch, and add tests for the transition.

## Verification

- Run the owning package build or tests.
- Confirm previews can instantiate with `PreviewRouter` where applicable.
- Re-run app target builds when a public package API changes.
