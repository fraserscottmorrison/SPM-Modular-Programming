// Authored by Fraser Scott-Morrison

import XCTest
@testable import ___VARIABLE_module___
import SwiftUI
import Tools

@MainActor
/// Verifies ___VARIABLE_viewName___ can be constructed in isolation.
final class ___VARIABLE_viewName___Tests: XCTestCase {

    func test___VARIABLE_viewName___CanBeCreated() {
        let view = ___VARIABLE_viewName___(router: PreviewRouter<___VARIABLE_module___Route>().routerBinding, index: 0)

        XCTAssertNotNil(view)
    }
}
