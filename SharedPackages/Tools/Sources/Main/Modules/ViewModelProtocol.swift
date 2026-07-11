// Authored by Fraser Scott-Morrison

/// Defines the base action and state contract for view models.
@MainActor public protocol ViewModelProtocol {
    associatedtype VS
    var state: VS { get set }

    associatedtype VA
    func action(_ action: VA)
    func handle(action: VA) async
}

extension ViewModelProtocol {
    public func action(_ action: VA) {
        Task { @MainActor in
            await self.handle(action: action)
        }
    }
}

public typealias VMProtocol = ViewModelProtocol & StateProtocol

/// Defines common states exposed by view models.
public protocol ViewStateProtocol: Equatable {
    static var idle: Self { get }
    static var loading: Self { get }
}

/// Provides state access and loading convenience for view models.
@MainActor public protocol StateProtocol {
    associatedtype VS: ViewStateProtocol
    var state: VS { get set }
    var isLoading: Bool { get }
}

public extension StateProtocol {
    var isLoading: Bool {
        return self.state == .loading
    }
}

/// Defines a submit workflow for form view models.
@MainActor public protocol FormProtocol: AnyObject {
    func submitForm()
    func processSubmitForm() async

    var isFormValid: Bool { get }
}

extension FormProtocol {
    public func submitForm() {
        Task { @MainActor in
            await self.processSubmitForm()
        }
    }
    public func processSubmitForm() async {}
}
