/// Protocol that defines the functionality for a network manager.
/// This protocol outlines methods and properties for performing network requests, 
protocol NetworkManager {
    func sendRequest<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T
}
