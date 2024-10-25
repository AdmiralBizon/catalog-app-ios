import Foundation

/// Products API Endpoint.
enum ProductsEndpoint {
    case products(pointer: Int?, limit: Int?)
}

extension ProductsEndpoint: Endpoint {
    var baseURL: String {
        "https://dummyjson.com"
    }
    
    var path: String {
        switch self {
        case .products:
            "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .products:
            .get
        }
    }
    
    var queryParams: [String: Any]? {
        switch self {
        case let .products(pointer, limit):
            let nonNillableParams = ["skip": pointer, "limit": limit].compactMapValues { $0 }
            return nonNillableParams.isEmpty ? nil : nonNillableParams
        }
    }

}
