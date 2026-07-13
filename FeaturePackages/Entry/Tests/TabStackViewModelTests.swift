// Authored by Fraser Scott-Morrison

import Testing
import Tools
@testable import Entry

/// Verifies TabStack.ViewModel initial state and actions.
@MainActor
struct TabStackViewModelTests {

    @Test func testInitialStateUsesFirstTab() async throws {
        let viewModel = makeViewModel()
        
        #expect(viewModel.state == .idle)
        #expect(viewModel.selectedTab == .first)
    }
    
    @Test func testOnAppearSetsLoadedState() async throws {
        let viewModel = makeViewModel()
        
        await viewModel.handle(action: .onAppear)
        
        #expect(viewModel.state == .loaded)
    }
    
    private func makeViewModel() -> TabStack.ViewModel {
        TabStack.ViewModel(router: PreviewRouter<EntryRoute>().routerBinding)
    }
}
