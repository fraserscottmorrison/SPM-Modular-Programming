import Foundation
import Observation
import Tools
import SwiftUI

extension DetailView {
    /// Manages DetailView state, title data, and routed actions.
    @MainActor @Observable final class ViewModel: VMProtocol {

        @ObservationIgnored
        @Binding var router: Router<DetailRoute>
        var state: ViewState = .loaded
        var title: String

        init(router: Binding<Router<DetailRoute>>, title: String) {
            _router = router
            self.title = title
        }

        /// Represents the loading lifecycle for DetailView.
        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded
        }

        /// Defines user and lifecycle actions handled by DetailView.
        enum ViewAction {
            case onAppear
        }

        func handle(action: ViewAction) async {
            switch action {
            case .onAppear:
                state = .loaded
            }
        }
    }
}
