import XCTest
@testable import ___VARIABLE_module___
import Tools

@MainActor
final class ___VARIABLE_viewName___ModelTests: XCTestCase {

    var viewModel: ___VARIABLE_viewName___.ViewModel!

    override func setUp() async throws {
        try await super.setUp()
        viewModel = ___VARIABLE_viewName___.ViewModel(router: PreviewRouter<___VARIABLE_module___Route>().routerBinding)
    }

    override func tearDown() async throws {
        try await super.tearDown()
        viewModel = nil
    }

    func testInitialStateIsIdle() {
        XCTAssertEqual(viewModel.state, .idle)
    }

    func testOnAppearSetsLoadedState() async {
        await viewModel.handle(action: .onAppear)

        XCTAssertEqual(viewModel.state, .loaded)
    }
}
