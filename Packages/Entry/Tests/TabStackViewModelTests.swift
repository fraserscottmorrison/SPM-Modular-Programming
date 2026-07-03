import XCTest
@testable import Entry
import Tools

@MainActor
/// Verifies TabStack.ViewModel initial state and actions.
final class TabStackViewModelTests: XCTestCase {

    func testInitialStateUsesFirstTab() {
        let viewModel = makeViewModel()

        XCTAssertEqual(viewModel.state, .idle)
        XCTAssertEqual(viewModel.selectedTab, .first)
    }

    func testOnAppearSetsLoadedState() async {
        let viewModel = makeViewModel()

        await viewModel.handle(action: .onAppear)

        XCTAssertEqual(viewModel.state, .loaded)
    }

    private func makeViewModel() -> TabStack.ViewModel {
        TabStack.ViewModel(router: PreviewRouter<EntryRoute>().routerBinding)
    }
}
