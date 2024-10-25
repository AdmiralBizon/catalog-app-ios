import Models

/// A provider for fetching product data from the API.
public enum ProductsProvider {

    /// Asynchronously fetches a list of products from the API.
    public static func fetchProducts(after pointer: Int?, limit: Int?) async throws -> ProductsResponseEntry {
        let endpoint = ProductsEndpoint.products(pointer: pointer, limit: limit)
        return try await UrlSessionNetworkManager.shared.sendRequest(
            endpoint,
            responseType: ProductsResponseEntry.self
        )
    }

}
