import Foundation

/// A protocol that defines the properties required for each API endpoint.
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: Any]? { get }
}
