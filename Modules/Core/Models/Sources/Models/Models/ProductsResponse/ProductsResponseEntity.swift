/// Model representing a products response, used in the business layer to manage products-related data and operations.
public struct ProductsResponseEntity {
    public let products: [ProductEntity]
    public let total: Int

    public init(products: [ProductEntity], total: Int) {
        self.products = products
        self.total = total
    }
}
