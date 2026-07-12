// Authored by Fraser Scott-Morrison

import Testing
import Tools
@testable import ___VARIABLE_module___

/// Verifies ___VARIABLE_viewName___.ViewModel state transitions.
struct TabStackViewModelTests {

    @Test func testInitialStateIsLoaded() async throws {
        let viewModel = await makeViewModel()
        
        #expect(await viewModel.state == .loaded)
    }
    
    @Test func testOnAppearSetsLoadedState() async throws {
        let viewModel = await makeViewModel()
        
        await viewModel.handle(action: .onAppear)
        
        #expect(await viewModel.state == .loaded)
    }
    
    private func makeViewModel() async  -> ___VARIABLE_viewName___.ViewModel {
        await ___VARIABLE_viewName___.ViewModel(router: PreviewRouter<___VARIABLE_module___Route>().routerBinding, title: "Preview")
    }
}
