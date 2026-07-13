// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools

extension EntryCoordinator {

    @ViewBuilder private func navigateTo(route: EntryRoute, router: Binding<Router<EntryRoute>>) -> some View {
        switch route {
        case .tabStack:
            TabStack(router: router)
        }
    }
}

/// Hosts the Entry module tab stack with shared routing state.
public struct EntryCoordinator: View {

    @State internal var router: Router<EntryRoute>

    public init(path: Binding<NavigationPath>) {
        _router = State(wrappedValue: Router(path: path))
    }

    public var body: some View {
        getCoordinatorView(initialRoute: .tabStack,
                        router: $router,
                        viewByRoute: navigateTo)
    }
}
