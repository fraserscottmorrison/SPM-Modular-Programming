// Authored by Fraser Scott-Morrison

import Testing
import Tools
@testable import Detail

/// Verifies DetailView.ViewModel state transitions.
@MainActor
struct TabStackViewModelTests {

    @Test func testInitialStateIsLoading() async throws {
        let viewModel = makeViewModel()
        
        #expect(viewModel.state == .loading)
    }
    
    @Test func testOnAppearSetsLoadedState() async throws {
        let viewModel = makeViewModel()
        
        await viewModel.handle(action: .onAppear)
        
        if case .loaded(let details) = viewModel.state {
            #expect(details.name == "Kylian Mbappe")
        } else {
            Issue.record("Expected loaded state")
        }
    }
    
    private func makeViewModel() -> DetailView.ViewModel {
        DetailView.ViewModel(router: PreviewRouter<DetailRoute>().routerBinding, index: 0)
    }
}
