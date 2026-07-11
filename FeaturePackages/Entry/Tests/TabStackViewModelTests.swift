// Authored by Fraser Scott-Morrison

import Testing
import Tools
@testable import Entry

/// Verifies TabStack.ViewModel initial state and actions.
struct TabStackViewModelTests {

    @Test func testInitialStateUsesFirstTab() async throws {
        let viewModel = await makeViewModel()
        
        #expect(await viewModel.state == .idle)
        #expect(await viewModel.selectedTab == .first)
    }
    
    @Test func testOnAppearSetsLoadedState() async throws {
        let viewModel = await makeViewModel()
        
        await viewModel.handle(action: .onAppear)
        
        #expect(await viewModel.state == .loaded)
    }
    
    private func makeViewModel() async  -> TabStack.ViewModel {
        await TabStack.ViewModel(router: PreviewRouter<EntryRoute>().routerBinding)
    }
}
