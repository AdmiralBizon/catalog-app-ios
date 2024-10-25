import Foundation

/// Component for constructing `URLRequest` objects for selected API endpoints.
class RequestBuilder {
    
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        let url = try makeUrl(from: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        return request
    }

}

private extension RequestBuilder {

    func makeUrl(from endpoint: Endpoint) throws -> URL {
        let localVariableURLString = endpoint.baseURL + endpoint.path
        var localVariableUrlComponents = URLComponents(string: localVariableURLString)

        if let queryParams = endpoint.queryParams, endpoint.method == .get {
            let queryItems: [URLQueryItem] = queryParams.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }

            localVariableUrlComponents?.queryItems = queryItems
        }

        guard let url = localVariableUrlComponents?.url else {
            throw APIError.invalidURL
        }
        
        return url
    }

}
