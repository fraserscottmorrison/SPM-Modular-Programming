// Authored by Fraser Scott-Morrison

import Foundation
import SwiftUI
import Tools

@MainActor
/// Defines the public UI package contract for Detail.
public protocol DetailProtocol: UIPackageProtocol {
}

@MainActor
/// Exposes the Detail module metadata and route entry point.
public final class DetailPackage: DetailProtocol {
    public typealias R = DetailRoute

    public static let bundle = Bundle.module
    public static let name = "Detail"

    public init() {}

    @ViewBuilder
    public func navigateTo(route: any Route, path: Binding<NavigationPath>) -> some View {
        EmptyView()
    }
}
