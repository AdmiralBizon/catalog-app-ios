import Foundation

/// Model representing a products response, used in the API layer to manage products-related data in API requests and responses.
public struct ProductsResponseEntry: Decodable {
    public let products: [ProductEntry]
    public let total: Int
}
