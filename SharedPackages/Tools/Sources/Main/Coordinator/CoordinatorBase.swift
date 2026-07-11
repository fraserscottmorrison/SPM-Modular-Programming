// Authored by Fraser Scott-Morrison

import SwiftUI

/// Wraps coordinator content with its current router state.
internal struct CoordinatorBase<Content: View, R>: View where R: Route {

    var state: Router<R>

    let bodyContent: () -> Content

    public init(state: Router<R>, bodyContent: @escaping () -> Content) {
        self.state = state
        self.bodyContent = bodyContent
    }

    public var body: some View {
        bodyContent()
    }
}
