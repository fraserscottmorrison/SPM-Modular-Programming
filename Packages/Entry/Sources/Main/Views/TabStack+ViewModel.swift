import Foundation
import Observation
import Tools
import SwiftUI

extension TabStack {

    static let iPadTabBarEnabled = false

    /// Manages tab selection and per-tab navigation paths.
    @MainActor @Observable final class ViewModel: VMProtocol {

        @ObservationIgnored
        @Binding var router: Router<EntryRoute>
        var state: ViewState = .idle
        var tabPaths = [NavigationPath]()
        var selectedTabIndex: Int = 0
        var selectedTab: Tab = .first

        init(router: Binding<Router<EntryRoute>>) {
            _router = router
            tabPaths = Self.Tab.allCases.map { _ in NavigationPath() }
        }

        /// Defines the tabs available in the Entry tab stack.
        @MainActor enum Tab: String, Hashable, @MainActor CaseIterable {
            case first = "First"
            case second = "Second"

            static let allCases: [TabStack.ViewModel.Tab] = [.first, .second]

            var isSplitView: Bool {
                switch self {
                case .first, .second:
                    !TabStack.iPadTabBarEnabled
                }
            }
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
                self.tabPaths = Self.Tab.allCases.map { _ in NavigationPath() }
                state = .loaded
            }
        }
    }
}
