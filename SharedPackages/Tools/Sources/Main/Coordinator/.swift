import SwiftUI
import Factory

public extension Container {
    var screenHistoryService: Factory<ScreenHistoryProtocol> {
        self { ScreenHistoryManager() }.scope(.singletonSession)
    }
}
