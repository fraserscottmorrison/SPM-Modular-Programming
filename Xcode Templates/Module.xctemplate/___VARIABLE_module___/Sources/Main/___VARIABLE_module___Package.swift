import Foundation
import SwiftUI
import Tools

@MainActor
public protocol ___VARIABLE_module___Protocol: UIPackageProtocol {
}

@MainActor
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