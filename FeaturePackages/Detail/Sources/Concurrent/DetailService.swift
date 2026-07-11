// Authored by Fraser Scott-Morrison

import ToolsConcurrent
#if DEBUG
import DetailMocks
#endif

public protocol DetailServiceProtocol: Actor {
    func details(for index: Int) -> NetworkClientMocked<Details>
}

public actor DetailService: DetailServiceProtocol {
    public init() {}
    
    public func details(for index: Int) -> NetworkClientMocked<Details> {
        var endpoint = Endpoint(path: "details_\(index)" )
        #if DEBUG
        endpoint.bundle = DetailMocks.bundle
        #endif
        return NetworkClientMocked(endpoint: endpoint)
    }
}

