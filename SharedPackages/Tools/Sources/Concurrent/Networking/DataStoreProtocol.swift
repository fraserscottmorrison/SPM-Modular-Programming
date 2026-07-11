// Authored by Fraser Scott-Morrison

import Foundation

public protocol DataStoreProtocol: Actor {
    associatedtype C: Codable, Sendable
    var endpoint: Endpoint { get }

    func get() async throws(NetworkError) -> C
}
