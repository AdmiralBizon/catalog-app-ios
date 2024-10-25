/// List of API-related errors that can occur during network requests.
/// Each case represents a specific error condition that may arise:
/// - `decodingError`: Indicates a failure to decode the response data.
/// - `invalidResponse`: Represents an unexpected or invalid response from the server.
/// - `invalidURL`: Signifies that the URL provided for the request is not valid.
/// - `requestFailed`: Indicates that the network request has failed for an unspecified reason.
public enum APIError: Error {
    case decodingError
    case invalidResponse
    case invalidURL
    case requestFailed
}
