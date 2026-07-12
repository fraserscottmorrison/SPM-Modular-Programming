// Authored by Fraser Scott-Morrison

import Foundation
import SwiftUI
import Tools

@MainActor
/// Defines the public UI package contract for ___VARIABLE_module___.
public protocol ___VARIABLE_module___Protocol: UIPackageProtocol {
}

@MainActor
/// Exposes the ___VARIABLE_module___ module metadata and route entry point.
public final class ___VARIABLE_module___Package: ___VARIABLE_module___Protocol {
    public typealias R = ___VARIABLE_module___Route

    public static let bundle = Bundle.module
    public static let name = "___VARIABLE_module___"

    public init() {}

    @ViewBuilder
    public func navigateTo(route: any Route, path: Binding<NavigationPath>) -> some View {
        EmptyView()
    }
}
