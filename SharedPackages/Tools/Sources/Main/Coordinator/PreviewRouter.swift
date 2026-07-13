// Authored by Fraser Scott-Morrison

import SwiftUI

/// Supplies in-memory router bindings for previews and tests.
@MainActor
open class PreviewRouter<R> where R: Route {

    private var navPath = NavigationPath()
    private lazy var router = Router<R>(path: navPathBinding)

    public var navPathBinding: Binding<NavigationPath> {
        Binding(
            get: { self.navPath },
            set: { self.navPath = $0 }
        )
    }

    public var routerBinding: Binding<Router<R>> {
        Binding(
            get: { self.router },
            set: { self.router = $0 }
        )
    }

    public init() {}
}
