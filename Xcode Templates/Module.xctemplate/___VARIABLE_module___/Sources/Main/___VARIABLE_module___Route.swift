// Authored by Fraser Scott-Morrison

import Tools
import SwiftUI
import ___VARIABLE_module___Concurrent

/// Represents the navigation destinations in the ___VARIABLE_module___ module.
public enum ___VARIABLE_module___Route: RawRepresentable, Route {

    case initialRoute

    public init?(rawValue: String) {
        self = .initialRoute
    }

    public var rawValue: String {
        switch self {
        case .initialRoute:
            return "initialRoute"
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
