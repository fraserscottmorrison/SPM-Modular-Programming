import SwiftUI

public extension String {

    func toHashColor() -> Color {
        var hash = 0
        for scalar in self.unicodeScalars {
            hash = Int(scalar.value) + ((hash << 5) - hash)
        }
        let hueFraction = Double(abs(hash) % 360) / 360.0
        return Color(hue: hueFraction, saturation: 0.65, brightness: 0.85)
    }
}
