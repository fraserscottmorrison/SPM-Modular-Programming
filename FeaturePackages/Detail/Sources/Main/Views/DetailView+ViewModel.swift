// Authored by Fraser Scott-Morrison

import Foundation
import Observation
import Tools
import SwiftUI
import DetailConcurrent

extension DetailView {
    /// Manages DetailView state, title data, and routed actions.
    @MainActor @Observable final class ViewModel: VMProtocol {

        @ObservationIgnored
        @Binding var router: Router<DetailRoute>
        var state: ViewState = .loading
        let index: Int

        init(router: Binding<Router<DetailRoute>>, index: Int) {
            _router = router
            self.index = index
        }

        /// Represents the loading lifecycle for DetailView.
        enum ViewState: ViewStateProtocol {
            case idle
            case loading
            case loaded(Details)
        }

        /// Defines user and lifecycle actions handled by DetailView.
        enum ViewAction {
            case onAppear
            case onNext
        }

        func handle(action: ViewAction) async {
            switch action {
            case .onAppear:
                do {
                    let details = try await DetailService().details(for: index).get()
                    self.state = .loaded(details)
                    
                } catch let error {
                    switch error {
                    case .generalError:
                        break
                    }
                }
            case .onNext:
                let nextIndex = Int.random(in: 0...4)
                self.router.navigateTo(.initialRoute(nextIndex))
            }
        }
    }
}
