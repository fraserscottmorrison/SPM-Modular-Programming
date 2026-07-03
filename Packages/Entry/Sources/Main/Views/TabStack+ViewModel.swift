import Foundation
import Tools
import SwiftUI

extension TabStack {
    /// Manages tab selection and per-tab navigation paths.
    @MainActor final class ViewModel: VMProtocol, ObservableObject {

        @Binding var router: Router<EntryRoute>
        @Published var state: ViewState = .idle
        @Published var tabPaths = [NavigationPath]()
        @Published var selectedTabIndex: Int = 0
        @Published var selectedTab: Tab = .first

        init(router: Binding<Router<EntryRoute>>) {
            _router = router
            tabPaths = [NavigationPath(), NavigationPath()]
        }

        /// Defines the tabs available in the Entry tab stack.
        enum Tab: String, Hashable, CaseIterable {
            case first = "First"
            case second = "Second"

            static let allCases: [TabStack.ViewModel.Tab] = [.first, .second]
        }

        /// Represents the loading lifecycle for TabStack.
        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded
        }

        /// Defines user and lifecycle actions handled by TabStack.
        enum ViewAction {
            case onAppear
        }

        func handle(action: ViewAction) async {
            switch action {
            case .onAppear:
                self.tabPaths = (0...2).map { _ in NavigationPath() }
                state = .loaded
            }
        }
    }
}
