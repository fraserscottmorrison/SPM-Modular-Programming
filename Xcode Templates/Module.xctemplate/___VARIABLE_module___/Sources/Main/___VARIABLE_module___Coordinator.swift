import SwiftUI
import Tools

extension ___VARIABLE_module___Coordinator {

    @ViewBuilder private func navigateTo(route: ___VARIABLE_module___Route, path: Binding<NavigationPath>) -> some View {
        switch route {
        case .initialRoute:
            ___VARIABLE_viewName___(router: $router)
        }
    }
}

public struct ___VARIABLE_module___Coordinator: View {

    @State internal var router: Router<___VARIABLE_module___Route>
    var initialRoute: ___VARIABLE_module___Route

    public init(path: Binding<NavigationPath>,
                initialRoute: ___VARIABLE_module___Route = .initialRoute) {
        _router = State(wrappedValue: Router(path: path))
        self.initialRoute = initialRoute
    }

    public var body: some View {
        getCoordinatorView(initialRoute: initialRoute,
                        router: $router,
                        viewByRoute: navigateTo)
    }
}