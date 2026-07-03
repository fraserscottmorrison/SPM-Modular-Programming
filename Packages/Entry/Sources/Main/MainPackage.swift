import Foundation
import SwiftUI
import Tools

@MainActor
/// Defines the public UI package contract for Entry.
public protocol MainProtocol: UIPackageProtocol {
}

@MainActor
/// Exposes the Entry module metadata and route entry point.
public final class MainPackage: MainProtocol {
    public typealias R = EntryRoute

    public static let bundle = Bundle.module
    public static let name = "Main"

    public init() {}

    @ViewBuilder
    public func navigateTo(route: any Route, path: Binding<NavigationPath>) -> some View {
        EmptyView()
    }
}
