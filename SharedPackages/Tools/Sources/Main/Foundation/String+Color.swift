// Authored by Fraser Scott-Morrison

import SwiftUI

public extension String {
    func toColor() -> Color? {
        var cleanedHex = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }
        
        var rgbValue: UInt64 = 0
        guard Scanner(string: cleanedHex).scanHexInt64(&rgbValue) else { return nil }
        
        let r, g, b, a: Double
        
        switch cleanedHex.count {
        case 6: // RGB (e.g., "FF0000")
            r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            b = Double(rgbValue & 0x0000FF) / 255.0
            a = 1.0
        case 8: // RGBA (e.g., "FF0000FF")
            r = Double((rgbValue & 0xFF000000) >> 24) / 255.0
            g = Double((rgbValue & 0x00FF0000) >> 16) / 255.0
            b = Double((rgbValue & 0x0000FF00) >> 8) / 255.0
            a = Double(rgbValue & 0x000000FF) / 255.0
        default:
            return nil
        }
        
        return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
