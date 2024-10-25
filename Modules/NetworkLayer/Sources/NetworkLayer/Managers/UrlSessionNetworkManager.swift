import Foundation

/// Main manager for making network requests using URLSession.
/// This class is responsible for handling API calls, managing request configurations,
/// and processing responses.
public final class UrlSessionNetworkManager: NetworkManager {

    // MARK: - Public Properties

    public static let shared = UrlSessionNetworkManager()

    // MARK: - Private Properties

    private let requestBuilder = RequestBuilder()

    private var successStatusCodes: ClosedRange<Int> {
        (200...299)
    }

    // MARK: - Initialization

    private init() {}

    // MARK: - Public Methods

    func sendRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        let request = try requestBuilder.makeRequest(from: endpoint)

        do {
            /// Perform the network request and await the response.
            let (data, response) = try await URLSession.shared.data(for: request)

            /// Check if the response status code is in the 200-299 range.
            guard
                let httpResponse = response as? HTTPURLResponse,
                successStatusCodes.contains(httpResponse.statusCode)
            else {
                throw APIError.invalidResponse
            }

            do {
                /// Deserialize the response data into the specified type.
                let response = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                throw APIError.decodingError
            }

        } catch {
            throw APIError.requestFailed
        }
    }

}
