// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools

/// Hosts the Entry module tab stack with shared routing state.
public struct EntryCoordinator: View {

    @State internal var router: Router<EntryRoute>

    public init(path: Binding<NavigationPath>) {
        _router = State(wrappedValue: Router(path: path))
    }

    public var body: some View {
        TabStack(router: $router)
    }
}
