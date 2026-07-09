import XCTest
@testable import Detail
import Tools

@MainActor
/// Verifies DetailView.ViewModel state transitions.
final class DetailViewModelTests: XCTestCase {

    var viewModel: DetailView.ViewModel!

    override func setUp() async throws {
        try await super.setUp()
        viewModel = DetailView.ViewModel(router: PreviewRouter<DetailRoute>().routerBinding, title: "Preview")
    }

    override func tearDown() async throws {
        try await super.tearDown()
        viewModel = nil
    }

    func testInitialStateIsLoaded() {
        XCTAssertEqual(viewModel.state, .loaded)
    }

    func testOnAppearSetsLoadedState() async {
        await viewModel.handle(action: .onAppear)

        XCTAssertEqual(viewModel.state, .loaded)
    }
}