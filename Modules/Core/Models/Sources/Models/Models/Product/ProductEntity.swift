import Foundation

/// Model representing a product, used in the business layer to manage product-related data and operations.
public struct ProductEntity: Identifiable {
    public let id: Int
    public let title: String
    public let price: Double
    public let stock: Int
    public let images: [String]

    public init(
        id: Int,
        title: String,
        price: Double,
        stock: Int,
        images: [String]
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.stock = stock
        self.images = images
    }
}
