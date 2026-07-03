import Foundation
import Tools
import SwiftUI

extension ___VARIABLE_viewName___ {

    @MainActor final class ViewModel: VMProtocol, ObservableObject {

        @Binding var router: Router<___VARIABLE_module___Route>
        @Published var state: ViewState = .idle

        init(router: Binding<Router<___VARIABLE_module___Route>>) {
            _router = router
        }

        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded
        }

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