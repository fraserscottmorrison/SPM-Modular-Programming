import SwiftUI

/// Renders routes through push and modal navigation presentations.
public struct CoordinatorView<R, V>: View where R: Route, V: View {
    private let initialRoute: R
    @Binding private var router: Router<R>
    private let viewByRoute: (R, Binding<NavigationPath>) -> V

    fileprivate init(initialRoute: R,
                     router: Binding<Router<R>>,
                     @ViewBuilder viewByRoute: @escaping (R, Binding<NavigationPath>) -> V) {
        self.initialRoute = initialRoute
        self._router = router
        self.viewByRoute = viewByRoute
    }

    public var body: some View {
        CoordinatorBase(state: router, bodyContent: {
            ZStack {
                self.navigateTo(route: initialRoute)
                    .sheet(item: $router.semiFormSheet, onDismiss: {
                        router.semiFormSheet = nil
                    }, content: navigateTo)
                    .sheet(item: $router.formSheet, onDismiss: {
                        router.formSheet = nil
                    }, content: navigateToFormSheet)
                    .fullScreenCover(item: $router.fullScreenCover, onDismiss: {
                        router.fullScreenCover = nil
                    }, content: navigateTo)
            }
            .navigationDestination(for: R.self, destination: navigateTo)
        })
    }

    @ViewBuilder private func navigateTo(route: R) -> some View {
        viewByRoute(route, router.$path)
    }

    @ViewBuilder private func navigateToFormSheet(route: R) -> some View {
        CoordinatorStack { path in
            viewByRoute(route, path)
        }
    }
}

public extension View {
    func getCoordinatorView<R: Route, V: View>(initialRoute: R,
                                                   router: Binding<Router<R>>,
                                                   @ViewBuilder viewByRoute: @escaping (R, Binding<NavigationPath>) -> V) -> some View {

        CoordinatorView(initialRoute: initialRoute,
                            router: router,
                            viewByRoute: viewByRoute)
    }
}
