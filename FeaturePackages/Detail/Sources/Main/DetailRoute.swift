import Tools
import SwiftUI

/// Represents the navigation destinations in the Detail module.
public enum DetailRoute: RawRepresentable, Route {

    case initialRoute(String)

    public init?(rawValue: String) {
        self = .initialRoute("")
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
