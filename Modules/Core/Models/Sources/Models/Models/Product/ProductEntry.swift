import Foundation

/// Model representing a product, used in the API layer to manage product-related data in API requests and responses.
public struct ProductEntry: Decodable {
    public let id: Int
    public let title: String
    public let price: Double
    public let stock: Int
    public let images: [String]
}
