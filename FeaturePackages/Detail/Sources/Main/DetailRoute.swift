// Authored by Fraser Scott-Morrison

import Tools
import SwiftUI
import DetailConcurrent

/// Represents the navigation destinations in the Detail module.
public enum DetailRoute: RawRepresentable, Route {

    case initialRoute(Int)

    public init?(rawValue: String) {
        self = .initialRoute(0)
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
