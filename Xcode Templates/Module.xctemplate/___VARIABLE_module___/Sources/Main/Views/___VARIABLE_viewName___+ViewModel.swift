// Authored by Fraser Scott-Morrison

import Foundation
import Observation
import Tools
import SwiftUI
import ___VARIABLE_module___Concurrent

extension ___VARIABLE_viewName___ {
    /// Manages ___VARIABLE_viewName___ state, title data, and routed actions.
    @MainActor @Observable final class ViewModel: VMProtocol {

        @ObservationIgnored
        @Binding var router: Router<___VARIABLE_module___Route>
        var state: ViewState = .loading

        init(router: Binding<Router<___VARIABLE_module___Route>>) {
            _router = router
        }

        /// Represents the loading lifecycle for ___VARIABLE_viewName___.
        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded
        }

        /// Defines user and lifecycle actions handled by ___VARIABLE_viewName___.
        enum ViewAction {
            case onAppear
        }

        func handle(action: ViewAction) async {
            switch action {
            case .onAppear:
                self.state = .loaded
            }
        }
    }
}
