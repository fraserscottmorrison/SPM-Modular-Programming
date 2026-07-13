// Authored by Fraser Scott-Morrison

import SwiftUI
import Tools

public struct Details: Codable, Equatable, Sendable {
    
    public init(name: String) {
        self.name = name
    }
    
    public var name: String
    public var description: String?
    public var colorString: String?
    public var color: Color {
        return colorString?.toColor() ?? .white
    }
    public var isColorInverted: Bool = false
}
