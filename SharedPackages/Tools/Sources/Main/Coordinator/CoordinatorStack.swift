// Authored by Fraser Scott-Morrison

import SwiftUI

/// Owns a navigation path and optionally wraps content in NavigationStack.
public struct CoordinatorStack<Content: View>: View {

    @State private var path = NavigationPath()
    private let withNavigationStack: Bool

    let bodyContent: (_ path: Binding<NavigationPath>) -> Content

    public init(withNavigationStack: Bool = true, bodyContent: @escaping (_ path: Binding<NavigationPath>) -> Content) {
        self.withNavigationStack = withNavigationStack
        self.bodyContent = bodyContent
    }

    public var body: some View {
        if withNavigationStack {
            NavigationStack(path: $path) {
                bodyContent($path)
            }
        } else {
            bodyContent($path)
        }
    }
}
