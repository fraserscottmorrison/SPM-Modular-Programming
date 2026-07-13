// Authored by Fraser Scott-Morrison

import SwiftUI

/// Defines how a route should be presented.
public enum PresentationStyle: String, Hashable, Codable {
    case push
    case formSheet
    case semiFormSheet
    case fullScreenCover
}

/// Describes navigation operations shared by route routers.
@MainActor
public protocol RouterProtocol: AnyObject {
    associatedtype R = Route

    var path: NavigationPath { get set }
    var formSheet: R? { get }
    var semiFormSheet: R? { get }
    var fullScreenCover: R? { get }
    var isEmpty: Bool { get }

    func navigateTo(_ route: R, style: PresentationStyle)
    func popToRoot()
    func pop()
}

extension RouterProtocol {
    func navigateTo(_ route: R, style: PresentationStyle = .push) {
        navigateTo(route, style: style)
    }
}

/// Drives route-based navigation state for pushes and modal presentations.
@MainActor
open class Router<R>: ObservableObject, RouterProtocol where R: Route {
    private var pathCount = 0
    public let isModal: Bool
    @Binding public var path: NavigationPath
    @Published public var formSheet: R?
    @Published public var semiFormSheet: R?
    @Published public var fullScreenCover: R?

    public init(path: Binding<NavigationPath>, isModal: Bool = false) {
        _path = path
        self.isModal = isModal
        self.pathCount = path.wrappedValue.count
    }

    public func navigateTo(_ route: R, style: PresentationStyle = .push) {
        switch style {
        case .push:
            self.path.append(route)
            self.pathCount += 1
        case .formSheet:
            self.formSheet = route
        case .semiFormSheet:
            self.semiFormSheet = route
        case .fullScreenCover:
            self.fullScreenCover = route
        }
    }

    public func popToRoot() {
        self.path = NavigationPath()
        self.resetPathCount()
    }

    public func pop() {
        if self.path.isEmpty == false {
            self.path.removeLast()
            self.pathCount -= 1
        }
    }

    public func popToPath(_ path: NavigationPath) {

        var newPath = self.path
        var newPathCount = self.pathCount
        while newPath != path && !newPath.isEmpty {
            newPath.removeLast()
            newPathCount -= 1
        }

        self.path = newPath
        self.pathCount = newPathCount
    }

    public func resetPathCount() {
        self.pathCount = 0
    }

    public var isEmpty: Bool {
        return self.pathCount == 0
    }
}

public extension Router where R: RawRepresentable, R.RawValue == String {
    func trigger(_ routeName: String, style: PresentationStyle = .push) {
        if let route = R.init(rawValue: routeName) {
            self.navigateTo(route, style: style)
        }
    }
}

/// Identifies a hashable navigation destination.
public protocol Route: Hashable, Identifiable {
}

public extension Route {
    var id: String {
        String(describing: self)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    var rawValue: String {
        String(describing: self)
    }

    var displayValue: String {
        return self.rawValue
    }
}
