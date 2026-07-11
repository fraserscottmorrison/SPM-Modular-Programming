// Authored by Fraser Scott-Morrison

import Foundation

// TODO: Dependency injectsion to switch between live and mock network clients
// TODO: Move networking code to new shared package


public actor NetworkClientMocked<C: Codable & Sendable>: DataStoreProtocol {
        
    public let endpoint: Endpoint

    public init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    public func get() async throws(NetworkError) -> C {
        do {
            return try await self.execute(endpoint: endpoint, httpMethod: .get)
        } catch {
            throw .generalError
        }
    }

    public func execute(endpoint: Endpoint, httpMethod: HTTPMethod) async throws(NetworkError) -> C {
        do {
            let url = endpoint.bundle.url(forResource: endpoint.path + httpMethod.suffix, withExtension: "json",)!
            let data = try! Data(contentsOf: url)
            return try JSONDecoder().decode(C.self, from: data)
        } catch {
            throw .generalError
        }
    }
}

public enum HTTPMethod {
    case get, post, patch, delete
    
    var suffix: String {
        switch self {
        case .get:
            return "_get"
        case .post:
            return "_post"
        case .patch:
            return "_patch"
        case .delete:
            return "_delete"
        }
    }
}

public struct Endpoint: Sendable {
    public let path: String
    #if DEBUG
    public var bundle: Bundle = .main
    #endif
    
    public init(path: String) {
        self.path = path
    }
}
