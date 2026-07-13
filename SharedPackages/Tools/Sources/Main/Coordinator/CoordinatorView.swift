// Authored by Fraser Scott-Morrison

import SwiftUI

/// Renders routes through push and modal navigation presentations.
@MainActor
public struct CoordinatorView<R, V>: View where R: Route, V: View {
    private let initialRoute: R
    @Binding private var router: Router<R>
    private let viewByRoute: (R, Binding<Router<R>>) -> V

    fileprivate init(initialRoute: R,
                     router: Binding<Router<R>>,
                     @ViewBuilder viewByRoute: @escaping (R, Binding<Router<R>>) -> V) {
        self.initialRoute = initialRoute
        self._router = router
        self.viewByRoute = viewByRoute
    }

    public var body: some View {
        CoordinatorBase(state: router, bodyContent: {
            ZStack {
                self.attachFullScreenCover(
                    to: self.navigateTo(route: initialRoute)
                    .sheet(item: $router.semiFormSheet, onDismiss: {
                        router.semiFormSheet = nil
                    }, content: navigateToSemiFormSheet)
                    .sheet(item: $router.formSheet, onDismiss: {
                        router.formSheet = nil
                    }, content: navigateToFormSheet)
                )
            }
            .navigationDestination(for: R.self, destination: navigateTo)
        })
    }

    @ViewBuilder private func attachFullScreenCover<Content: View>(to content: Content) -> some View {
        #if os(macOS)
        content.sheet(item: $router.fullScreenCover, onDismiss: {
            router.fullScreenCover = nil
        }, content: navigateTo)
        #else
        content.fullScreenCover(item: $router.fullScreenCover, onDismiss: {
            router.fullScreenCover = nil
        }, content: navigateTo)
        #endif
    }

    @ViewBuilder private func navigateTo(route: R) -> some View {
        viewByRoute(route, $router)
    }
    
    @ViewBuilder private func navigateToSemiFormSheet(route: R) -> some View {
        viewByRoute(route, $router).presentationDetents([.medium, .large])
    }

    @ViewBuilder private func navigateToFormSheet(route: R) -> some View {
        CoordinatorStack { path in
            ModalCoordinatorView(initialRoute: route,
                                 path: path,
                                 viewByRoute: viewByRoute)
        }
    }
}

@MainActor
private struct ModalCoordinatorView<R, V>: View where R: Route, V: View {
    private let initialRoute: R
    @State private var router: Router<R>
    private let viewByRoute: (R, Binding<Router<R>>) -> V

    init(initialRoute: R,
         path: Binding<NavigationPath>,
         @ViewBuilder viewByRoute: @escaping (R, Binding<Router<R>>) -> V) {
        self.initialRoute = initialRoute
        self._router = State(wrappedValue: Router(path: path, isModal: true))
        self.viewByRoute = viewByRoute
    }

    var body: some View {
        CoordinatorView(initialRoute: initialRoute,
                        router: $router,
                        viewByRoute: viewByRoute)
    }
}

public extension View {
    @MainActor
    func getCoordinatorView<R: Route, V: View>(initialRoute: R,
                                                   router: Binding<Router<R>>,
                                                   @ViewBuilder viewByRoute: @escaping (R, Binding<Router<R>>) -> V) -> some View {

        CoordinatorView(initialRoute: initialRoute,
                            router: router,
                            viewByRoute: viewByRoute)
    }
}
