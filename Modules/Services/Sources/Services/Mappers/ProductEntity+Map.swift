import Models

/// Mapper responsible for transforming the product model from the API layer
/// to the business model used within the application.
extension ProductEntity {
    init(_ entry: ProductEntry) {
        self.init(
            id: entry.id,
            title: entry.title,
            price: entry.price,
            stock: entry.stock,
            images: entry.images
        )
    }
}

