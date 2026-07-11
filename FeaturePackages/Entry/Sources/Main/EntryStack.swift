// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools

/// Provides the root Entry view hierarchy.
public struct EntryStack: View {
    public init() {}

    public var body: some View {
        CoordinatorStack(withNavigationStack: false) { path in
            EntryCoordinator(path: path)
        }
    }
}
