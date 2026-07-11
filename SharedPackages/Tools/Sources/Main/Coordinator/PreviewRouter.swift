// Authored by Fraser Scott-Morrison

import SwiftUI

/// Supplies in-memory router bindings for previews and tests.
open class PreviewRouter<R> where R: Route {

    public var navPathBinding: Binding<NavigationPath>
    public var routerBinding: Binding<Router<R>>

    public init() {
        var navPath = NavigationPath()
        self.navPathBinding = Binding(
            get: { navPath },
            set: { navPath = $0 }
        )
        var router = Router<R>(path: self.navPathBinding)
        self.routerBinding = Binding(
            get: { router },
            set: { router = $0 }
        )
    }
}
