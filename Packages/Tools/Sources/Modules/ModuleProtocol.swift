import Foundation
import SwiftUI

@MainActor
/// Provides common metadata for a package module.
public protocol PackageProtocol {
    static var bundle: Bundle { get }
}

@MainActor
/// Provides navigation entry points for UI package modules.
public protocol UIPackageProtocol: PackageProtocol {
    associatedtype PackageBody: View
    static var name: String { get }
    func navigateTo(route: any Route, path: Binding<NavigationPath>) -> Self.PackageBody
}

public extension UIPackageProtocol {
}
