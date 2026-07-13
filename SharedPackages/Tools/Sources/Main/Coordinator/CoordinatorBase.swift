// Authored by Fraser Scott-Morrison

import SwiftUI

/// Wraps coordinator content with its current router state.
@MainActor
internal struct CoordinatorBase<Content: View, R>: View where R: Route {

    @ObservedObject var state: Router<R>

    let bodyContent: () -> Content

    public init(state: Router<R>, bodyContent: @escaping () -> Content) {
        self.state = state
        self.bodyContent = bodyContent
    }

    public var body: some View {
        bodyContent()
    }
}
