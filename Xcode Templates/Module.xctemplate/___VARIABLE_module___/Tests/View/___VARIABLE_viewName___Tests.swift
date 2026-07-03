import XCTest
@testable import ___VARIABLE_module___
import SwiftUI
import Tools

@MainActor
final class ___VARIABLE_viewName___Tests: XCTestCase {

    func test___VARIABLE_viewName___CanBeCreated() {
        let view = ___VARIABLE_viewName___(router: PreviewRouter<___VARIABLE_module___Route>().routerBinding)

        XCTAssertNotNil(view)
    }
}
