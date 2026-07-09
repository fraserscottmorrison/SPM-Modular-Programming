import Testing
import Tools
@testable import Detail

/// Verifies DetailView.ViewModel state transitions.
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
    
    private func makeViewModel() async  -> DetailView.ViewModel {
        await DetailView.ViewModel(router: PreviewRouter<DetailRoute>().routerBinding, title: "Preview")
    }
}
