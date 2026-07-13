// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools

extension DetailCoordinator {

    @ViewBuilder private func navigateTo(route: DetailRoute, router: Binding<Router<DetailRoute>>) -> some View {
        switch route {
        case .initialRoute(let index):
            DetailView(router: router, index: index)
        }
    }
}

/// Coordinates navigation for the Detail module.
public struct DetailCoordinator: View {

    @State internal var router: Router<DetailRoute>
    var initialRoute: DetailRoute

    public init(path: Binding<NavigationPath>,
                initialRoute: DetailRoute) {
        _router = State(wrappedValue: Router(path: path))
        self.initialRoute = initialRoute
    }

    public var body: some View {
        getCoordinatorView(initialRoute: initialRoute,
                        router: $router,
                        viewByRoute: navigateTo)
    }
}
