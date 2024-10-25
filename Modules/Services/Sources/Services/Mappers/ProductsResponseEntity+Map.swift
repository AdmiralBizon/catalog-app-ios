import Models

/// Mapper responsible for transforming the products response model from the API layer
/// to the business model used within the application.
extension ProductsResponseEntity {
    init(_ entry: ProductsResponseEntry) {
        self.init(
            products: entry.products.map { ProductEntity($0) },
            total: entry.total
        )
    }
}
