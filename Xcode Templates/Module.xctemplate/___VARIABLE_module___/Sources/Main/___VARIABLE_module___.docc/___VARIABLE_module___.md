# ``___VARIABLE_module___``

A SwiftUI feature package following the standard package and MVVM-C patterns.

## Package Structure

```text
Sources/
  Main/
    Views/
      ___VARIABLE_viewName___/
        ___VARIABLE_viewName___.swift
        ___VARIABLE_viewName___+ViewModel.swift
    Resources/
    ___VARIABLE_module___Coordinator.swift
    ___VARIABLE_module___Package.swift
    ___VARIABLE_module___Route.swift
    ___VARIABLE_module___Stack.swift
```

## Patterns

- The package uses Swift tools 6.2 and iOS 26.
- The app or consuming feature should enter through `___VARIABLE_module___Stack`.
- Routes conform to `Route` from `Tools` and are mapped in `___VARIABLE_module___Coordinator`.
- Screens own `@StateObject internal var viewModel` and pass a `Binding<Router<___VARIABLE_module___Route>>` into the nested `@MainActor ObservableObject` view model.
- Views call `viewModel.action(.someAction)`; view models implement `handle(action:) async`.
- Keep package resources under `Sources/Main/Resources` and load them through `Bundle.module` only from the main target.

## Verification

```bash
swift test --package-path Packages/___VARIABLE_module___
```

If `swift test` hits the repository's macOS host-platform limitation, validate with Xcode on an iOS simulator destination.
