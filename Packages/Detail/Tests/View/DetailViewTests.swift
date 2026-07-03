import XCTest
@testable import Detail
import SwiftUI
import Tools

@MainActor
/// Verifies DetailView can be constructed in isolation.
final class DetailViewTests: XCTestCase {

    func testDetailViewCanBeCreated() {
        let view = DetailView(router: PreviewRouter<DetailRoute>().routerBinding, title: "Preview")

        XCTAssertNotNil(view)
    }
}