import SwiftUI
import Tools

extension DetailCoordinator {

    @ViewBuilder private func navigateTo(route: DetailRoute, path: Binding<NavigationPath>) -> some View {
        switch route {
        case .initialRoute(let title):
            DetailView(router: $router, title: title)
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
